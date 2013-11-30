//
//  EETableSelectItemViewController.m
//  Mercadauto
//
//  Created by Pedro Farias Barbosa on 30/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EETableSelectItemViewController.h"
#import "EERestUtil.h"

@interface EETableSelectItemViewController ()

@end

@implementation EETableSelectItemViewController
@synthesize viewDeRetorno, arrayItens;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (arrayItens == nil)
        arrayItens = [[NSMutableArray alloc]init];
    
    /*
     ===========================
     Tipo Pesquisa
     ===========================
     0 - Marca
     1 - Modelo
     2 - Ano
     */
    
    if (tipoPesquisa == 0)
    {
        [self generateArrayFromMarca];
        self.title = @"Marcas";
    }
    else
        if (tipoPesquisa == 1)
        {
            [self generateArrayFromModelo];
            self.title = @"Modelos";
        }
        else
            if (tipoPesquisa == 2)
            {
                [self generateArrayFromAno];
                 self.title = @"Anos";
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Erro" message:@"Erro ao identificar o tipo do filtro" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
            }
    
    [_tableViewItens reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrayItens.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }
    
    cell.textLabel.text = [[arrayItens objectAtIndex:indexPath.row] objectForKey:@"descricao"];
    cell.tag = [[[arrayItens objectAtIndex:indexPath.row] objectForKey:@"id"] intValue];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *value = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    NSInteger *idValue = [tableView cellForRowAtIndexPath:indexPath].tag;
    [viewDeRetorno setValueCellFiltro:tipoPesquisa valueCell:value :idValue ];
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setTipoPesquisa:(int)tipo
{
    tipoPesquisa = tipo;
}

-(void)generateArrayFromMarca
{
    arrayItens = [self buscarMarcas];
    [_tableViewItens reloadData];
}
-(void)generateArrayFromModelo
{
    arrayItens = [self buscarModelosPorMarca];
    [_tableViewItens reloadData];
}
-(void)generateArrayFromAno
{
    arrayItens = [self buscarAnosModelosPorModelo];
    [_tableViewItens reloadData];
}



- (NSMutableArray *) buscarMarcas{
    
    //NSDictionary *dicItem = (NSDictionary*) _detailItem;
    NSString *urlList = @"http://www.flaviojunior.com.br/mercadauto/json/jsonmarcas.php";
    NSMutableArray *marcas = [EERestUtil request:urlList];
    return marcas;
}


- (NSMutableArray *) buscarModelosPorMarca {
    
    //NSDictionary *dicItem = (NSDictionary*) _detailItem;
    NSString *urlList = [NSString stringWithFormat:@"http://www.flaviojunior.com.br/mercadauto/json/jsonmodelos.php?m=%d", _marca];
    NSMutableArray *modelos = [EERestUtil request:urlList];
    return modelos;
}


- (NSMutableArray *)  buscarAnosModelosPorModelo{
    
    //NSDictionary *dicItem = (NSDictionary*) _detailItem;
    NSString *urlList =[NSString stringWithFormat:@"http://www.flaviojunior.com.br/mercadauto/json/jsonanosmodelo.php?m=%d",_modelo];
    NSMutableArray *anosModelos = [EERestUtil request:urlList];
    return anosModelos;
    
}
@end
