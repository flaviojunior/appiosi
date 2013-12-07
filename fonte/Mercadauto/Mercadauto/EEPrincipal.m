//
//  EEPrincipal.m
//  Mercadauto
//
//  Created by Danilo Oliveira on 30/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EEPrincipal.h"

@implementation EEPrincipal
@synthesize itemMenu;
@synthesize imagemItemMenu;


-(id) initWithMenu:(NSString *)menuInicial addImage:(NSString *) imageName {
    
    if ((self = [super init])) {
        self.itemMenu = menuInicial;
        self.imagemItemMenu = imageName;

    }
    return self;
}

-(void) dealloc {
    
}

@end

