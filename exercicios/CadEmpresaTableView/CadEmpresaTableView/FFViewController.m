//
//  FFViewController.m
//  CadEmpresaTableView
//
//  Created by Flávio Júnior on 03/08/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "FFViewController.h"
#import "FFEmpresa.h"

@interface FFViewController ()

@end

@implementation FFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self carregarEmpresas];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) carregarEmpresas {
    NSString *pListEmpresas = [[NSBundle mainBundle] pathForResource:@"Empresas" ofType:@"plist"];
    NSDictionary *pl = [NSDictionary dictionaryWithContentsOfFile:pListEmpresas];
    NSArray *dados = [pl objectForKey:@"empresas"];
    
    empresas = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in dados) {
        NSString *nome = [item objectForKey:@"nome"];
        NSNumber *quantidade = [item objectForKey:@"quantidade"];
        
        FFEmpresa *e = [[FFEmpresa alloc] initWithNome:nome andQuantidade:quantidade];
        [empresas addObject:e];
        
        [e release];
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return empresas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CelulaEmpresaCacheID = @"CelulaEmpresaID";
    UITableViewCell * cell = [self.tabelaEmpresas dequeueReusableCellWithIdentifier:CelulaEmpresaCacheID];
    
    if(!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CelulaEmpresaCacheID] autorelease];
    }

FFEmpresa *empresa = [empresas objectAtIndex:indexPath.row];
cell.textLabel.text = empresa.nome;

return cell;
}

- (void) tableView: (UITableView *)tableView didSelectRowAtIndexPath: (NSIndexPath *)indexPath {
    FFEmpresa *empresa = [empresas objectAtIndex: indexPath.row];
    NSString *msg = [NSString stringWithFormat:@"Nome: %@\nQtde Funcs.: %@", empresa.nome, empresa.quantidade ];
    UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"Empresa" message:msg delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil] autorelease];
    [alert show];
    [self.tabelaEmpresas deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)dealloc {
    [_tabelaEmpresas release];
    [super dealloc];
}
@end
