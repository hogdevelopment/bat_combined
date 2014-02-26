//
//  NSDictionary+DeepLinking.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 26/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (DeepLinking)

// custom deep linking using
// structure: KEY.KEY. ... KEY. VALUE
// MUST use separator "."
- (id) valueForDeepKeyLinkingCustom:(NSString*)location;

@end
