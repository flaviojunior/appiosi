//
//  FFViewController.m
//  FFContatos
//
//  Created by fabiozoroastro on 24/08/13.
//  Copyright (c) 2013 fabiozoroastro. All rights reserved.
//

#import "FFViewController.h"
#import "AddressBook/AddressBook.h"


@interface FFViewController ()

@end



@implementation FFViewController

@synthesize tabela = _tabela;
@synthesize contatos = _contatos;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self carregarFonteDados:nil];
    
}


/**
 * Carrega a fonte de dados da app
 */
- (void) carregarFonteDados:(id) sender{
    
    ABAddressBookRef addressBook = ABAddressBookCreate();
    ABRecordRef copiaAddressBok = ABAddressBookCopyDefaultSource(addressBook);
    
    self.contatos = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeopleInSourceWithSortOrdering(addressBook, copiaAddressBok, kABPersonSortByLastName);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    id selected = [ self.contatos objectAtIndex:indexPath.row ];
    
    NSString *objSelecionado = ABRecordCopyValue(selected, kABPersonFirstNameProperty);

    
    NSString *msgFmt = [NSString stringWithFormat:@"Nome: %@", objSelecionado];
    
    UIAlertView *alerta = [[[UIAlertView alloc]initWithTitle:@"Contato" message:msgFmt delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]autorelease];
    
    [alerta show];
    [self.tabela deselectRowAtIndexPath:indexPath animated:YES];
}


/**
 * Retorna a celula(cacheada)
 */
-(UITableViewCell * ) tableView:(UITableView *) tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if( cell == nil ){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];//autorelease]
    }
    cell.textLabel.text = (__bridge NSString *) ABRecordCopyValue((__bridge ABRecordRef)[self.contatos objectAtIndex:indexPath.row], kABPersonFirstNameProperty);
    
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contatos.count;
}

- (void)dealloc {
    [self.tabela release];
    [self.contatos release];
    [super dealloc];
}
@end
