//
//  FFEmpresa.h
//  CadEmpresaTableView
//
//  Created by Flávio Júnior on 03/08/13.
//  Copyright (c) 2013 FF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FFEmpresa : NSObject {
    NSString *nome;
    NSNumber *quantidade;
}

-(id) initWithNome:(NSString *) nomeEmpresa
     andQuantidade: (NSNumber *) quantidade;

@property (nonatomic, retain) NSString *nomeEmpresa;
@property (nonatomic, retain) NSNumber *quantidade;

@end
