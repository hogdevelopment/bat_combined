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

+ (void)addMarkersToMap:(GMSMapView *)mapView
             withDetail:(NSDictionary*)info;


// use this to parse the locations array
// for the needed locations
// (the needed locations are the ones which
// are nested in the visible region of the map)

+ (void)addMarkersToMap:(GMSMapView*)mapView
               withInfo:(NSDictionary*)resultArray;
@end
