//
//  EEViewSelectAuto.h
//  Mercadauto
//
//  Created by Pedro Farias Barbosa on 24/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EEViewSelectAuto : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableFiltro;
@property (weak, nonatomic) IBOutlet UITableView *tableResult;

@property(assign) NSInteger *marca;
@property(assign) NSInteger *modelo;
@property(assign) NSInteger *anoModelo;


-(void)setValueCellFiltro:(int)tipo valueCell:(NSString *)value :(NSInteger*)idValue;
@end
