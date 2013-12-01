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
@synthesize botaoCarro, botaoMoto, botaoCaminhao;

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
    [self definirImagensBotoes];
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


-(void) definirImagensBotoes{
    
    UIImage *imgCarro = [UIImage imageNamed:@"carro.png"];
    UIImage *imgMoto = [UIImage imageNamed:@"moto.png"];
    UIImage *imgCaminhao = [UIImage imageNamed:@"caminhao.png"];
    
    [self.botaoCarro setBackgroundImage:[imgCarro stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateNormal];

    [self.botaoMoto setBackgroundImage:[imgMoto stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateNormal];

    [self.botaoCaminhao setBackgroundImage:[imgCaminhao stretchableImageWithLeftCapWidth:1 topCapHeight:1] forState:UIControlStateNormal];

}
@end
