//
//  RMNAutocompleteManager.h
//  BespokeLocationV2
//
//  Created by infodesign on 3/10/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMNAutocompleteManager : NSObject{
    
    BOOL isSearchingForLocations;
    BOOL isSearchingForFilters;
    
    NSArray *locationsArray;
    NSArray *filtersArray;

}

@property  BOOL isSearchingForLocations;
@property  BOOL isSearchingForFilters;

@property  NSArray *locationsArray;
@property  NSArray *filtersArray;

+ (id)sharedManager;


@end
