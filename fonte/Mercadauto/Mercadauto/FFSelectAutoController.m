//
//  FFSelectAutoController.m
//  Mercadauto
//
//  Created by Flávio Júnior on 02/08/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "FFSelectAutoController.h"
#import "FFMapAutoController.h"

@interface FFSelectAutoController ()

@end

@implementation FFSelectAutoController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIPickerView *picker = [[UIPickerView alloc]init];
    [picker setShowsSelectionIndicator:YES];
    
    _cmbMarca.inputView = picker;
    _cmbModelo.inputView = picker;
    _cmbAno.inputView = picker;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAnalizar:(id)sender {
    FFMapAutoController *mapAuto = [[FFMapAutoController alloc] init];
    [self.navigationController pushViewController:mapAuto animated:YES];
    [mapAuto release];
}
- (void)dealloc {
    [_cmbMarca release];
    [_cmbModelo release];
    [_cmbAno release];
    [super dealloc];
}
@end
