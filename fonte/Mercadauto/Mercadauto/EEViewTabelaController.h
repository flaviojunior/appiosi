//
//  EEViewTabelaController.h
//  Mercadauto
//
//  Created by Leonardo Freitas da Silva Pereira on 04/12/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EEViewTabelaController : UITableViewController
{
    IBOutlet UITableView *mainTable;
    NSMutableArray *dataArray;
    NSMutableArray *modelos;
    NSArray *meses;
}

@property(nonatomic,strong) NSMutableArray *modelos;


-(void) setDadosComparacao:(NSMutableArray *) modelosPesquisa;
@end
