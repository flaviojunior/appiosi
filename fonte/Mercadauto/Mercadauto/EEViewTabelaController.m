//
//  EEViewTabelaController.m
//  Mercadauto
//
//  Created by Leonardo Freitas da Silva Pereira on 04/12/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EEViewTabelaController.h"

@interface EEViewTabelaController ()

@end

@implementation EEViewTabelaController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    dataArray = [[NSMutableArray alloc] init];
    
    NSMutableString *modelosString = [[NSMutableString alloc]init];
    
    for(NSMutableDictionary *veiculo in modelos)
    {
        if(![modelosString isEqualToString:@""])
            [modelosString appendString:@","];
        
        [modelosString appendString:[veiculo objectForKey:@"Ano"]];
    }
    
    
    NSString *stringUrl = [NSString stringWithFormat:@"http://www.flaviojunior.com.br/mercadauto/json/jsongraph.php?v=%@", modelosString];
    
    NSURL *url = [NSURL URLWithString:stringUrl];
    // Submetendo a requisição sem o NSMutableURLRequest, assim vai com GET.
    NSError *error;
    NSData *resultado = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    
    // Verificando a ocorrência de erros HTTP.
    if(error){
        NSLog(@"Erro HTTP: %@", error.description);
        //return nil;
    }
    
    // Acessando o elemento "data" da estrutura retornada pelo serviço.
    NSDictionary *respostaJSON = [NSJSONSerialization JSONObjectWithData:resultado options:kNilOptions error:nil];
    //NSLog(@"item %d", respostaJSON.count);
    
    NSMutableArray *veiculos = [respostaJSON objectForKey:@"veiculos"];
    meses = [veiculos[0] objectForKey:@"meses"];
    
    
    //NSLog(@"valores %d", veiculos.count);
    
    
    NSMutableString *completo;
    
    for (int y=0; y < 6; y++) {
        
        NSMutableArray *carros = [[NSMutableArray alloc] init];
        
        for(int i=0; i < [veiculos count]; i++){
            
            NSMutableArray *valores = [veiculos[i] objectForKey:@"grafico"];
            
            
            NSString *modelo = [veiculos[i] objectForKey:@"modelo"];
            NSString *ano = [veiculos[i] objectForKey:@"ano_versao"];
            NSMutableString *label = [NSMutableString stringWithString:modelo ];
            [label appendString:@"-"];
            [label appendString:ano];
            
            
            completo = [NSMutableString stringWithString:label];
            [completo appendString:@"      R$ "];
            [completo appendString:[valores[y] objectForKey:@"valor"]];
            
            
            [carros addObject: completo];
            
        }
        
        NSArray *mes = [[NSArray alloc]initWithArray: carros];
        NSDictionary *mesArray = [NSDictionary dictionaryWithObject:mes forKey:@"data"];
        [dataArray  addObject:mesArray];
        
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    //NSLog(@"Secoes: %d", dataArray.count);
    return [dataArray count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    

    return meses[section];
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Get the selected country
    
    NSString *selectedCell = nil;
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    selectedCell = [array objectAtIndex:indexPath.row];
    
    //NSLog(@"%@", selectedCell);
    
    [mainTable deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [dataArray objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:@"data"];
    return [array count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *dictionary = [dataArray objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:@"data"];
    NSString *cellValue = [array objectAtIndex:indexPath.row];
    
    NSArray *arrayString = [cellValue componentsSeparatedByString:@"-"];
    
    cell.textLabel.text = arrayString[0];
    cell.detailTextLabel.text = arrayString[1];
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

-(void) setDadosComparacao:(NSMutableArray *) v{
    
    if (modelos == nil)
    {
        modelos = [[NSMutableArray alloc]init];
    }
    modelos = v;
}

@end
