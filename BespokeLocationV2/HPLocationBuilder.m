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

    // no need to keep the whole dictionary
    // in memory
    // keep only the venue information we get from the server
    NSDictionary *item = [parsedObject valueForDeepKeyLinkingCustom:@"response.venue"];
    

    return item;

}



+ (NSArray *)locationsFromDataBase:(NSData *)objectNotation
                              error:(NSError **)error
{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }

    
    NSArray *array = (NSArray *)parsedObject;
    

    
    
    NSMutableArray *arrayOfInformation = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<[array count]; i++)
    {
        
        NSMutableDictionary *dictionariesInfo = [[NSMutableDictionary alloc] initWithDictionary:@{@"isOnMap":@"NO"}];
        [dictionariesInfo addEntriesFromDictionary:[array objectAtIndex:i]];
        
        [arrayOfInformation addObject:dictionariesInfo];
        
        CGFloat longitude = [[dictionariesInfo valueForKey:@"longitude"]floatValue];
        CGFloat latitude  = [[dictionariesInfo valueForKey:@"latitude"]floatValue];
        
        [dictionariesInfo setValue:[NSString stringWithFormat:@"%.6f",longitude] forKey:@"longitude"];
        [dictionariesInfo setValue:[NSString stringWithFormat:@"%.6f",latitude] forKey:@"latitude"];
        
    }
    
    NSArray *theGreaterOlderDictionary = arrayOfInformation;
    
//    NSLog(@"GREAT ARARY %@",theGreaterOlderDictionary);
    
    return theGreaterOlderDictionary;
    
}

+ (NSDictionary *)answerFrom:(NSData *)objectNotation
                       error:(NSError **)error
{
    
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:objectNotation options:0 error:&localError];
    
    
    if (localError != nil) {
        *error = localError;
        return nil;
    }
    
    
    
    return parsedObject;
    
}


@end
