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
    NSMutableArray *resultArray = [[NSMutableArray alloc] init];
    NSMutableArray *allKeyss = [[NSMutableArray alloc] init];
    
    // get all the words
    textToSearch = [textToSearch lowercaseString];
    NSArray *myFilters = [textToSearch componentsSeparatedByCharactersInSet:
                          [NSCharacterSet characterSetWithCharactersInString:@"-/., "]
                          ];
    
    NSMutableArray *arrayOfWordsToSearch = [[NSMutableArray alloc] initWithArray:myFilters];
    
    for (NSString *word in myFilters) {
        
        if ([word isEqualToString:@""]) {
            
            [arrayOfWordsToSearch removeObject:word];
        }
    }
    
    
    // extract from the dictionaries keys only the keys that have string values
    for (id akey in [[listOfDictionaries objectAtIndex:0] allKeys]) {
        
        if ([[[listOfDictionaries objectAtIndex:0] objectForKey:akey] isKindOfClass:[NSString class]]) {
            
            [allKeyss addObject:akey];
        }
    }
    
    
    // for each key, create predicate and then apply it to array
    for (id myKey in allKeyss) {
        
        NSMutableArray *arrayOfArguments = [[NSMutableArray alloc] initWithObjects:myKey, [arrayOfWordsToSearch objectAtIndex:0], nil];
        
        NSString *formatForPredicate = @"%K CONTAINS[cd] %@";
        
        // create format and array of arguments for predicate
        for (int i = 1; i<[arrayOfWordsToSearch count]; i++) {
            
            [arrayOfArguments addObject:myKey];
            [arrayOfArguments addObject:[arrayOfWordsToSearch objectAtIndex:i]];
            formatForPredicate = [formatForPredicate stringByAppendingString:@" OR %K CONTAINS[cd] %@"];
            
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:formatForPredicate argumentArray:arrayOfArguments];
        
        // apply predicate to array of dictionaries
        NSArray *filteredArray = [listOfDictionaries filteredArrayUsingPredicate:predicate];
        
        // if any string was found , add dictionaries to result, only if they were not already added
        if ([filteredArray count] ) {
            
            [resultArray addObjectsFromArray:[self returnObjectsFromArray:filteredArray notContainedBy:resultArray]];
        }
    }
    
    
    // optimization - move to the beginning results that have words exactly like the words sent
    // check if words from text to search are matching with words from result array, not just contained by them
    NSMutableArray *arrayWithNumbersOfMatchingResults = [[NSMutableArray alloc] init];

    NSPredicate *matchingWordsPredicate = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        
        int countWords = 0;
        
        for (id myKey in allKeyss)
        {
            // get all the words from the value of the key
            NSString *stringValue = [[evaluatedObject objectForKey:myKey] lowercaseString];
            NSArray *words = [stringValue componentsSeparatedByCharactersInSet:
                              [NSCharacterSet characterSetWithCharactersInString:@"-/., "]
                              ];
            
            // check each word
            for (int i = 0; i<[arrayOfWordsToSearch count]; i++) {

                if ([words containsObject:[arrayOfWordsToSearch objectAtIndex:i]]) {
                    countWords ++;
                }
            }
        }
        
        BOOL found = NO;
        
        if (countWords > 0) {
            
            [arrayWithNumbersOfMatchingResults addObject:[NSNumber numberWithInt:countWords]];
            found = YES;
        }
        
        return found;
    }];
    

    
    // array that contains only the dictionaries that have matching words
    NSMutableArray *resultWithMatchingWords = [[NSMutableArray alloc] initWithArray:[resultArray filteredArrayUsingPredicate:matchingWordsPredicate]];
    
    // array that will hold all the results, but with the matching results at the beginning
    NSMutableArray *arrangedResultArray = [[NSMutableArray alloc] initWithArray:resultArray];
    
    // max value for matching results - the dictionary with the most matching words found
    int maxMatches = [[arrayWithNumbersOfMatchingResults valueForKeyPath:@"@max.self"] intValue];
    
    
    // from 1 to maxMatches we move the objects at the beginning
    // when it's done, the dictionaries that have the most words, will be at the beginning
    for (int i = 1; i <= maxMatches; i++) {
        
        for (int j = 0; j< [arrayWithNumbersOfMatchingResults count]; j++) {
            
            if ([[arrayWithNumbersOfMatchingResults objectAtIndex:j] intValue] == i) {
                
                NSDictionary *dictToBeMoved = [resultWithMatchingWords objectAtIndex:j];
                
                [arrangedResultArray removeObject:dictToBeMoved];
                [arrangedResultArray insertObject:dictToBeMoved atIndex:0];
            }
        }
    }

    //Bahnhofstr // and // Winterthur
//    NSLog(@"allResults %@", arrayWithNumbersOfMatchingResults);

    return arrangedResultArray;
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
