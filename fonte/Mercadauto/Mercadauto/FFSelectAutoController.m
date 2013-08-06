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

int tipoSelecionado;

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
    
    UIPickerView *pickerMarca = [[UIPickerView alloc]init];
    [pickerMarca setShowsSelectionIndicator:YES];
    
    UIPickerView *pickerModelo = [[UIPickerView alloc]init];
    [pickerModelo setShowsSelectionIndicator:YES];
    
    UIPickerView *pickerAno = [[UIPickerView alloc]init];
    [pickerAno setShowsSelectionIndicator:YES];
    
    _cmbMarca.inputView = pickerMarca;
    _cmbModelo.inputView = pickerModelo;
    _cmbAno.inputView = pickerAno;
    
    pickerMarca.delegate = self;
    pickerModelo.delegate = self;
    pickerAno.delegate = self;
    pickerMarca.dataSource = self;
    pickerModelo.dataSource = self;
    pickerAno.dataSource = self;
    
    switch (tipoSelecionado) {
        case 0:
            _imgTipoSelecionado.image = [UIImage imageNamed:NSLocalizedString(@"moto",@"")];
            break;
        case 1:
            _imgTipoSelecionado.image = [UIImage imageNamed:NSLocalizedString(@"carro",@"")];
            break;
        case 2:
            _imgTipoSelecionado.image = [UIImage imageNamed:NSLocalizedString(@"caminhao",@"")];
            break;
        default:
            break;
    }
    [self carregarPickers];
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

-(id)initWithTipo:(int)tipo {
    if (self = [super init]) {
        tipoSelecionado = tipo;
    }
    return  self;
}

-(void) carregarPickers {
    NSString *pListDados = [[NSBundle mainBundle] pathForResource:@"tabela" ofType:@"plist"];
    NSDictionary *pl = [NSDictionary dictionaryWithContentsOfFile:pListDados];
    
    NSArray *dadosMarcas = [pl objectForKey:@"Marcas0"];
    marcas = [[NSMutableArray alloc] init];
    for (NSDictionary *item in dadosMarcas) {
        [marcas addObject:item];
    }
    
    NSArray *dadosModelos = [pl objectForKey:@"Modelos0"];
    modelos = [[NSMutableArray alloc] init];
    for (NSDictionary *item in dadosModelos) {
        [modelos addObject:item];
    }
    
    NSArray *dadosAno = [pl objectForKey:@"Ano0"];
    anos = [[NSMutableArray alloc] init];
    for (NSDictionary *item in dadosAno) {
        [anos addObject:item];
    }
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if ([pickerView isEqual: _cmbMarca.inputView]) {
        return marcas.count;
    }
    if ([pickerView isEqual: _cmbModelo.inputView]) {
        return modelos.count;
    }
    if ([pickerView isEqual: _cmbAno.inputView]) {
        return anos.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if ([pickerView isEqual: _cmbMarca.inputView]) {
        return [marcas objectAtIndex:row];
    }
    if ([pickerView isEqual: _cmbModelo.inputView]) {
        return [modelos objectAtIndex:row];
    }
    if ([pickerView isEqual: _cmbAno.inputView]) {
        return [anos objectAtIndex:row];
    }
    return @"";
}


- (void)dealloc {
    [_cmbMarca release];
    [_cmbModelo release];
    [_cmbAno release];
    [_imgTipoSelecionado release];
    [super dealloc];
}
@end
