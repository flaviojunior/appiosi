//
//  EEEscolhaTipoViewController.m
//  Mercadauto
//
//  Created by Fabio Marinho on 23/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EEEscolhaTipoViewController.h"

@interface EEEscolhaTipoViewController ()

@end

@implementation EEEscolhaTipoViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showGenres"]) {
        
    }
}

@end
