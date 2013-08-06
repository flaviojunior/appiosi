//
//  FFSelectAutoController.h
//  Mercadauto
//
//  Created by Flávio Júnior on 02/08/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFSelectAutoController : UIViewController
- (IBAction)btnAnalizar:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *cmbMarca;
@property (retain, nonatomic) IBOutlet UITextField *cmbModelo;
@property (retain, nonatomic) IBOutlet UITextField *cmbAno;

@end
