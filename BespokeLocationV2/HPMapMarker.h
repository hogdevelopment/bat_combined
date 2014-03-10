//
//  HPMapMarker.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/23/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GoogleMaps/GoogleMaps.h>



@interface HPMapMarker : NSObject

// use this to parse the locations array
// markers from the given array will be
// added to the map. If some markers are already
// on the map, they will be kept
// other markers that aren't in this array
// but are on the map will be removed
+ (void)addMarkersToMap:(GMSMapView*)mapView
               withInfo:(NSArray*)resultArray
 withSearchingActivated:(BOOL)isSearchingActivated;


@end

