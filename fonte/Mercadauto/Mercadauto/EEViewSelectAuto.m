//
//  EEViewSelectAuto.m
//  Mercadauto
//
//  Created by Pedro Farias Barbosa on 24/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EEViewSelectAuto.h"
#import "EECellOpcoesFiltro.h"
#import "EETableSelectItemViewController.h"
#import "EECellVeiculoFiltro.h"
#import "EEViewGraficoController.h"
#import "EEViewTabelaController.h"

@interface EEViewSelectAuto ()

@end

@implementation EEViewSelectAuto
@synthesize arrayVeiculosComparacao;

EETableSelectItemViewController *tableSelectItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    arrayVeiculosComparacao = [[NSMutableArray alloc]init];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([tableView isEqual:_tableFiltro])
        return 3;
    else
        if ([tableView isEqual:_tableResult])
            return arrayVeiculosComparacao.count;
    
    return 0;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableFiltro])
    {
        static NSString *CellIdentifier = @"EECellOpcoesFiltro";
        
        EECellOpcoesFiltro *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (cell == nil)
        {
            
            cell = [[EECellOpcoesFiltro alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        if (indexPath.row == 0)
        {
            cell.labelName.text = @"Marca";
        }
        else
        {
            if (indexPath.row == 1)
            {
                cell.labelName.text = @"Modelo";
            }
            else
            {
                if (indexPath.row == 2)
                {
                    cell.labelName.text = @"Ano";
                }
            }
        }
        
        return cell;
    }
    else
    {
        if ([tableView isEqual:_tableResult])
        {
            static NSString *CellIdentifier = @"EECellVeiculoFiltro";
            
            EECellVeiculoFiltro *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
            
            if (cell == nil) {
                
                cell = [[EECellVeiculoFiltro alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            }
            
            NSMutableDictionary *veiculo = [arrayVeiculosComparacao objectAtIndex:indexPath.row];
            
            cell.labelMarca.text = [veiculo valueForKey:@"Marca"];
            cell.labelModelo.text = [veiculo valueForKey:@"Modelo"];
            cell.labelAno.text = [veiculo valueForKey:@"Ano"];
            
            return cell;
        }
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableResult])
        return 82;
    
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([tableView isEqual:_tableFiltro])
    {
        tableSelectItem = (EETableSelectItemViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"EETableSelectItemViewController"];
        
        [tableSelectItem setTipoPesquisa:indexPath.row];
        [tableSelectItem setMarca:self.marca];
        [tableSelectItem setModelo:self.modelo];
        [tableSelectItem setAnoModelo:self.anoModelo];
        tableSelectItem.viewDeRetorno = self;
        [self.navigationController pushViewController:tableSelectItem animated:YES];
    }
}

-(void)setValueCellFiltro:(int)tipo valueCell:(NSString *)value :(NSInteger*)idValue
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:tipo inSection:0];
    EECellOpcoesFiltro *cell = (EECellOpcoesFiltro *)[_tableFiltro cellForRowAtIndexPath:indexPath];
    cell.labelValue.text = value;
    
    switch (tipo) {
        case 0:
            self.marca = idValue;
            break;
        case 1:
            self.modelo = idValue;
            break;
        case 2:
            self.anoModelo = idValue;
            break;
        default:
            break;
    }
    [cell reloadInputViews];
}

- (IBAction)addVeiculoComparacao:(id)sender {
    
    
    if(arrayVeiculosComparacao.count < 2)
    {
        NSMutableDictionary *dictionaryVeiculo = [[NSMutableDictionary alloc]init];
        
        for (int i = 0; i < 3; i++)
        {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            EECellOpcoesFiltro *cell = (EECellOpcoesFiltro *)[_tableFiltro cellForRowAtIndexPath:indexPath];
            
            if ([cell.labelName.text isEqualToString:@"Ano"])
            {
                int i = self.anoModelo;
                [dictionaryVeiculo setObject:[NSString stringWithFormat:@"%d",i] forKey:cell.labelName.text];
            }
            else
            {
                [dictionaryVeiculo setObject:cell.labelValue.text forKey:cell.labelName.text];
            }
        }
        
        [arrayVeiculosComparacao addObject:dictionaryVeiculo];
        
        [_tableResult reloadData];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Alerta" message:@"É permitido comparar apenas dois veículos" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle==UITableViewCellEditingStyleDelete)
    {
        [arrayVeiculosComparacao removeObjectAtIndex:indexPath.row];
    }
    
    [tableView reloadData];
}

- (IBAction)btnGrafico:(id)sender {
    
    EEViewGraficoController *graficoController = (EEViewGraficoController *)[self.storyboard instantiateViewControllerWithIdentifier:@"EEViewGraficoController"];
    
    [self.navigationController pushViewController:graficoController animated:YES];
    
    [graficoController setDadosComparacao:arrayVeiculosComparacao];
}

- (IBAction)btnTabela:(id)sender {
    
    EEViewTabelaController *tabelaController = (EEViewTabelaController *)[self.storyboard instantiateViewControllerWithIdentifier:@"EEViewTabelaController"];
    
    [self.navigationController pushViewController:tabelaController animated:YES];
    
    [tabelaController setDadosComparacao:arrayVeiculosComparacao];
}
@end
