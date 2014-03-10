//
//  RMNAutocompleteManager.m
//  BespokeLocationV2
//
//  Created by infodesign on 3/10/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNAutocompleteManager.h"

@implementation RMNAutocompleteManager

@synthesize isSearchingForLocations     =    isSearchingForLocations;
@synthesize isSearchingForFilters       =    isSearchingForFilters;
@synthesize locationsArray              =    locationsArray;
@synthesize filtersArray                =    filtersArray;



+ (id)sharedManager {
    static RMNAutocompleteManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}


- (id)init {
    if (self = [super init])
    {
        isSearchingForLocations = NO;
        isSearchingForFilters   = NO;
        
        locationsArray          = [[NSArray alloc] init];
        filtersArray            = [[NSArray alloc] init];

    }
    return self;
}



@end
