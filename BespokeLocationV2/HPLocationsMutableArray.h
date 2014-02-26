//
//  HPLocationsMutableArray.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 05/12/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPLocationsMutableArray : NSObject


// use this array to keep all the information for
// the location, which will be used through out
// the app
+ (NSMutableArray *) locationsArray;


// use this array to keep all the information for
// the friends, which will be used through out
// the app
+ (NSMutableArray *) friendsArray;

// keep a reference to the searched array of locations
// this is usefull when switching from the map to the
// location table view controller
+ (NSMutableArray *) searchedLocationsArray;

// use location types for custom search
+ (NSMutableArray *) locationsType;

+ (NSMutableArray*) searchString;

// save zoom position to use when navigating
// to map from detail view
+ (NSMutableArray*)coordinateToZoomTo;

+ (NSMutableArray*)dummyForCrapWork;

@end
