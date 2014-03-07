//
//  RMNFiltersOperations.m
//  BespokeLocationV2
//
//  Created by infodesign on 3/7/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFiltersOperations.h"

@implementation RMNFiltersOperations


+ (NSArray *) search:(NSString *) textToSearch inArray: (NSArray *) listOfDictionaries
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    NSMutableArray *allKeyss = [[NSMutableArray alloc] init];
    
    // get all the words
    NSArray *myFilters = [textToSearch componentsSeparatedByCharactersInSet:
                          [NSCharacterSet characterSetWithCharactersInString:@"-/., "]
                          ];
    
    // extract from the dictionaries keys only the keys that have string values
    for (id akey in [[listOfDictionaries objectAtIndex:0] allKeys]) {
        
        if ([[[listOfDictionaries objectAtIndex:0] objectForKey:akey] isKindOfClass:[NSString class]]) {
            
            [allKeyss addObject:akey];
        }
    }
    
    
    // for each key, create predicate and then apply it to array
    for (id myKey in allKeyss) {
        
        NSMutableArray *arrayOfArguments = [[NSMutableArray alloc] initWithObjects:myKey, [myFilters objectAtIndex:0], nil];
        
        NSString *formatForPredicate = @"%K CONTAINS[cd] %@";
        
        // create format and array of arguments for predicate
        for (int i = 1; i<[myFilters count]; i++) {
            
            [arrayOfArguments addObject:myKey];
            [arrayOfArguments addObject:[myFilters objectAtIndex:i]];
            formatForPredicate = [formatForPredicate stringByAppendingString:@" OR %K CONTAINS[cd] %@"];
            
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:formatForPredicate argumentArray:arrayOfArguments];
        
        // apply predicate to array of dictionaries
        NSArray *filteredArray = [listOfDictionaries filteredArrayUsingPredicate:predicate];
        
        // if any string was found , add dictionaries to result, only if they were not already added
        if ([filteredArray count] ) {
            
            [result addObjectsFromArray:[self returnObjectsFromArray:filteredArray notContainedBy:result]];
        }
    }
    
    return result;
}


+ (NSArray *) returnObjectsFromArray: (NSArray *)array notContainedBy: (NSMutableArray *)mutableArray
{
    NSMutableArray *copyAr = [[NSMutableArray alloc] initWithArray:array];
    
    for (id object in array) {
        if ([mutableArray containsObject:object]) {
            [copyAr removeObject:object];
        }
    }
    
    return copyAr;
}


@end
