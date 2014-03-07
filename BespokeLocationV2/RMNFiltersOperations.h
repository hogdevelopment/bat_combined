//
//  RMNFiltersOperations.h
//  BespokeLocationV2
//
//  Created by infodesign on 3/7/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMNFiltersOperations : NSObject

// returns array of dictionaries that contains any of the words from the text sent
+ (NSArray *) search:(NSString *) textToSearch inArray: (NSArray *) listOfDictionaries;

// finds objects from an array that are not contained by another array
+ (NSArray *) returnObjectsFromArray: (NSArray *)array notContainedBy: (NSMutableArray *)mutableArray;

@end
