//
//  FFEmpresa.m
//  CadEmpresaTableView
//
//  Created by Flávio Júnior on 03/08/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import "FFEmpresa.h"

@implementation FFEmpresa
@synthesize  nomeEmpresa, quantidade;

- (id)initWithNome:(NSString *)nomeEmpresa andQuantidade:(NSNumber *)quantidade {
    if (self = [super init]) {
        self.nomeEmpresa = nomeEmpresa;
        self.quantidade = quantidade;
    }
    
    return  self;
}

- (void)dealloc {
    [nome release];
    [quantidade release];
    [super dealloc];
}

@end
