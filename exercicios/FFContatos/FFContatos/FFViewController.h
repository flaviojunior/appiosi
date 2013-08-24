//
//  FFViewController.h
//  FFContatos
//
//  Created by fabiozoroastro on 24/08/13.
//  Copyright (c) 2013 fabiozoroastro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>{

    UITableView *_tabela;
    NSArray *_contatos;

}

@property (retain, nonatomic) IBOutlet UITableView *tabela;
@property (retain, nonatomic) NSArray *contatos;
@end
