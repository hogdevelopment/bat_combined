//
//  HPMapMarker.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/23/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "HPMapMarker.h"
#import "HPLocationInfo.h"

@implementation HPMapMarker

+ (void)addMarkersToMap:(GMSMapView *)mapView
             withDetail:(NSDictionary*)info
{
    
    // in the dictionary we receive
    // we have longitude/latitude/title/description
    
    GMSMarker *marker   =   [[GMSMarker alloc] init];
    CGFloat longitude   =   [[info valueForKey:@"gps_long"]floatValue];
    CGFloat latitude    =   [[info valueForKey:@"gps_lat"]floatValue];
    
    
    CLLocationCoordinate2D location =   CLLocationCoordinate2DMake(latitude, longitude);
    marker.position                 =   location;
    marker.appearAnimation          =   YES;
    marker.icon                     =   [UIImage imageNamed:@"pinRestaurants"];
    marker.map                      =   mapView;
    marker.userData                 =   [info valueForKey:@"zoom_level"];
    
    // offset the info window anchor
    // so it looks nice
    //    marker.infoWindowAnchor = CGPointMake(0.98f, 0.3f);
    
    // set the title/description for the view
    //    marker.title    =   [info valueForKey:@"title"];
    //    marker.snippet  =   [info valueForKey:@"snippet"];
    
}

+ (void)addMarkersToMap:(GMSMapView*)mapView withInfo:(NSDictionary *)resultArray

{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        for (NSDictionary *info in resultArray)
        {
            
            CGFloat longitude;
            CGFloat latitude;
            NSString *name;
            NSString *locationAddress;
            GMSMarker *marker       =   [[GMSMarker alloc] init];



            longitude           =   [[info valueForKey:@"longitude"]floatValue];
            latitude            =   [[info valueForKey:@"latitude"]floatValue];
            locationAddress     =   [info valueForKey:@"localAddress"];
            name                =   [info valueForKey:@"name"];
                
            CLLocationCoordinate2D location =   CLLocationCoordinate2DMake(latitude, longitude);
            marker.position                 =   location;
            marker.appearAnimation          =   YES;
            //                    marker.icon                     =   [UIImage imageNamed:pngLocation];
            marker.map                      =   mapView;
            marker.userData                 =   info;
            marker.title                    =   name;
            marker.snippet                  =   locationAddress;
            
        }

    });
    
}

@end
