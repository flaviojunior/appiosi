//
//  EERestUtil.m
//  Mercadauto
//
//  Created by fabiozoroastro on 30/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import "EERestUtil.h"

@implementation EERestUtil

+(NSDictionary *) requestById:(NSString *) iid url:(NSString *) urlRest {
    NSString *stringUrl = [NSString stringWithFormat: @"%@/%@", urlRest, iid];
    NSLog(@"Url: %@", stringUrl);
    NSURL *url = [NSURL URLWithString:stringUrl];
    
    return [self requestGeneric:url];
}

+(NSDictionary *) request:(NSString *)urlRest {
    NSURL *url = [NSURL URLWithString:urlRest];
    
    return [self requestGeneric:url];
}

+ (NSDictionary *)requestGeneric:(NSURL *)url {
    NSError *error;
    NSData *resultado = [NSData dataWithContentsOfURL:url options:NSDataReadingUncached error:&error];
    
    if(error) {
        NSLog(@"Erro HTTP: %@", error.description);
        return nil;
    }
    
    return [NSJSONSerialization JSONObjectWithData:resultado options:kNilOptions error:nil ];

    
    //*respostaJSON = [NSJSONSerialization JSONObjectWithData:resultado options:kNilOptions error:nil ];
    //return [respostaJSON objectForKey:@"data"];
}
@end
