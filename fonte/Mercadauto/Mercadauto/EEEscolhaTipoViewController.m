//
//  EEEscolhaTipoViewController.m
//  Mercadauto
//
//  Created by Fabio Marinho on 23/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EEEscolhaTipoViewController.h"
#import "EEPrincipal.h"
#import "EEViewSelectAuto.h"

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
    //[self definirImagensBotoes];
    [self loadMenu];

    self.view.backgroundColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]]colorWithAlphaComponent:1.0f];
    
    self.tabelaPrincipal.rowHeight = 50;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
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

-(void) loadMenu {
    
    NSString *plistCaminho = [[NSBundle mainBundle]
                              pathForResource:@"Principal"  ofType:@"plist"];
    NSDictionary *pl = [NSDictionary
                        dictionaryWithContentsOfFile:plistCaminho];
    NSArray *dados = [pl objectForKey:@"menu"];
    menu = [[NSMutableArray alloc] init];
    
    for (NSDictionary *item in dados) {
        NSString *nome = [item objectForKey:@"nome"];
        NSString *img = [item objectForKey:@"imagem"];
        EEPrincipal *c = [[EEPrincipal alloc] initWithMenu:nome addImage:img];
        [menu addObject:c];
    }
}

-(NSInteger)tableView:(UITableView *)tableView
numberOfRowsInSection:(NSInteger)section {
    return menu.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CelulaPrincipalCacheID = @"CelulaPrincipalCacheID";
	UITableViewCell *cell = [self.tabelaPrincipal dequeueReusableCellWithIdentifier:CelulaPrincipalCacheID];
    
	if (!cell) {
		cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CelulaPrincipalCacheID];
	}
	
	EEPrincipal *principal = [menu objectAtIndex:indexPath.row];
	cell.textLabel.text = principal.itemMenu;
    
    [cell setBackgroundColor:[UIColor colorWithRed:((float)0 / 0.0f) green:((float)61 / 255.0f) blue:((float)0 / 0.0f) alpha:0.0f]];
    cell.textLabel.textColor = [UIColor blackColor];
    cell.imageView.image = [UIImage imageNamed:principal.imagemItemMenu];
    cell.textLabel.font = [UIFont fontWithName:@"NimbusSansBeckerPUltLig" size:43];

	return cell;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EEViewSelectAuto * viewauto = (EEViewSelectAuto *)[self.storyboard instantiateViewControllerWithIdentifier:@"EEViewSelectAuto"];
    [self.navigationController pushViewController:viewauto animated:YES];
    
    [self.tabelaPrincipal deselectRowAtIndexPath:indexPath animated:YES];
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
