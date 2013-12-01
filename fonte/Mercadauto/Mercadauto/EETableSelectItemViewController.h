//
//  EETableSelectItemViewController.h
//  Mercadauto
//
//  Created by Pedro Farias Barbosa on 30/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EEViewSelectAuto.h"

@interface EETableSelectItemViewController : UITableViewController
{
    /*
     ===========================
     Tipo Pesquisa
     ===========================
     0 - Marca
     1 - Modelo
     2 - Ano
     */
    int tipoPesquisa;
    EEViewSelectAuto *viewDeRetorno;
    NSMutableArray *arrayItens;
}

@property (strong, nonatomic) IBOutlet UITableView *tableViewItens;
@property(nonatomic,strong) NSMutableArray *arrayItens;
@property(nonatomic,strong) EEViewSelectAuto *viewDeRetorno;

@property(assign) NSInteger *marca;
@property(assign) NSInteger *modelo;
@property(assign) NSInteger *anoModelo;



-(void)setTipoPesquisa:(int)tipo;
@end
