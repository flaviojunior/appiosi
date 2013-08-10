//
//  FFEmpresa.m
//  CadEmpresaTableView
//
//  Created by Flávio Júnior on 03/08/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "FFEmpresa.h"

@implementation FFEmpresa
@synthesize  nome, quantidade;

- (id)initWithNome:(NSString *)nomeEmpresa andQuantidade:(NSNumber *)qtde {
    if (self = [super init]) {
        self.nome = nomeEmpresa;
        self.quantidade = qtde;
    }
    
    return  self;
}

- (void)dealloc {
    [nome release];
    [quantidade release];
    [super dealloc];
}

@end
