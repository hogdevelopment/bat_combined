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
// for the needed locations
+ (void)addMarkersToMap:(GMSMapView*)mapView
               withInfo:(NSArray*)resultArray;


@end

