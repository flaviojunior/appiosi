//
//  EEPrincipal.h
//  Mercadauto
//
//  Created by Danilo Oliveira on 30/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EEPrincipal : NSObject{
    NSString *itemMenu;
    NSString *imagemItemMenu;
}

-(id) initWithMenu:(NSString *)menuInicial addImage:(NSString *) imageName ;

@property (nonatomic, retain) NSString *itemMenu;
@property (nonatomic, retain) NSString *imagemItemMenu;


@end
