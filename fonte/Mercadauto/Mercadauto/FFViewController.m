//
//  FFViewController.m
//  Mercadauto
//
//  Created by Flávio Júnior on 02/08/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "FFViewController.h"
#import "FFSelectAutoController.h"

@interface FFViewController ()

@end

@implementation FFViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnMoto:(id)sender {
    FFSelectAutoController *ac = [[FFSelectAutoController alloc] init];
    [self.navigationController pushViewController:ac animated:YES];
    [ac release];
}

- (IBAction)btnCarro:(id)sender {
    FFSelectAutoController *ac = [[FFSelectAutoController alloc] init];
    [self.navigationController pushViewController:ac animated:YES];
    [ac release];
}

- (IBAction)btnCaminhao:(id)sender {
    FFSelectAutoController *ac = [[FFSelectAutoController alloc] init];
    [self.navigationController pushViewController:ac animated:YES];
    [ac release];
}
@end
