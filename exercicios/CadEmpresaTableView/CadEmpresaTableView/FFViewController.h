//
//  FFViewController.h
//  CadEmpresaTableView
//
//  Created by Flávio Júnior on 03/08/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFViewController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *empresas;

}
@property (retain, nonatomic) IBOutlet UIBarButtonItem *botaoEditar;
@property (retain, nonatomic) IBOutlet UITableView *tabelaEmpresas;
- (IBAction)botaoEditar:(id)sender;


@end
