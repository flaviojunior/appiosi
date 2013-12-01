//
//  EERestUtil.h
//  Mercadauto
//
//  Created by fabiozoroastro on 30/11/13.
//  Copyright (c) 2013 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EERestUtil : NSObject

+(NSDictionary *) requestById:(NSString *) iid url:(NSString *) urlRest;
+(NSDictionary *) request:(NSString *) iid;
+(NSDictionary *) requestGeneric:(NSURL *) urlRest;


@end
