//
//  HPLocationBuilder.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "HPLocationBuilder.h"

@implementation HPLocationBuilder

+ (NSDictionary *)locationsFromFoursquare:(NSData *)objectNotation
                                    error:(NSError **)error
{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:NSJSONReadingAllowFragments error:&localError];
    
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }

    NSDictionary *item = [[parsedObject objectForKey: @"response"] objectForKey: @"venue"];
    

    return item;

}



+ (NSDictionary *)locationsFromDataBase:(NSData *)objectNotation
                              error:(NSError **)error
{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:NSJSONReadingAllowFragments error:&localError];
    
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }

    
    return parsedObject;
    
}


@end
