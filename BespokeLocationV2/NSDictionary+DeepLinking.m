//
//  NSDictionary+DeepLinking.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 26/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "NSDictionary+DeepLinking.h"

@implementation NSDictionary (DeepLinking)

- (id)valueForDeepKeyLinkingCustom:(NSString *)location
{
    id result;
    
    
    NSArray* keysArray = [location componentsSeparatedByString:@"."];
    
    NSLog(@"ZA KEYS %@",keysArray);
    result = [self valueForKey:[keysArray objectAtIndex:0]];
    
    for (int i = 1; i<[keysArray count]; i++)
    {
        // test if the current result is a dictionary
        if ([result respondsToSelector:@selector(valueForKey:)])
        {
            // test if the result has any value for the current key
            id tempResult = [result valueForKey:[keysArray objectAtIndex:i]];
            if (tempResult)
            {
                // store the result
                result = tempResult;
            }
            else
            {
                NSLog(@"No value for key %@",[keysArray objectAtIndex:i]);
            }
        }
    }
    
    
    // return the last accepted value
    return result;
}

@end
