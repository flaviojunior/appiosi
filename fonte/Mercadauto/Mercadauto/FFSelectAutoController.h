//
//  FFSelectAutoController.h
//  Mercadauto
//
//  Created by Flávio Júnior on 02/08/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFSelectAutoController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    NSMutableArray *marcas;
    NSMutableArray *modelos;
    NSMutableArray *anos;
}
- (IBAction)btnAnalizar:(id)sender;
- (id)initWithTipo:(int) tipo;
@property (retain, nonatomic) IBOutlet UITextField *cmbMarca;
@property (retain, nonatomic) IBOutlet UITextField *cmbModelo;
@property (retain, nonatomic) IBOutlet UITextField *cmbAno;
@property (retain, nonatomic) IBOutlet UIImageView *imgTipoSelecionado;

@end
