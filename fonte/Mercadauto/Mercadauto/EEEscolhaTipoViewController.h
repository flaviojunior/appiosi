//
//  EEEscolhaTipoViewController.h
//  Mercadauto
//
//  Created by Fabio Marinho on 23/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EEEscolhaTipoViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
    
    NSMutableArray *menu;
}
@property (weak, nonatomic) IBOutlet UIButton *botaoCarro;
@property (weak, nonatomic) IBOutlet UIButton *botaoMoto;
@property (weak, nonatomic) IBOutlet UIButton *botaoCaminhao;

@property (weak, nonatomic) IBOutlet UITableView *tabelaPrincipal;

@end
