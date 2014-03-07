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


+ (void)addMarkersToMap:(GMSMapView*)mapView
               withInfo:(NSArray*)resultArray
 withSearchingActivated:(BOOL)isSearchingActivated

{
    
    NSString *searchingMatcherKey = (isSearchingActivated) ? @"YES" : @"NO";

    
     NSMutableArray *whereToSearch      = [[RMNManager sharedManager]markers];
    NSLog(@"AVEM %D",[whereToSearch count]);
    
    if (isSearchingActivated)
    {
    
        // remove the markers that don't have the searched filter
        for (NSMutableDictionary *markerInfo in whereToSearch)
        {
            GMSMarker *marker = [markerInfo objectForKey:@"reference"];
            NSMutableDictionary *info = marker.userData;
            if (![resultArray containsObject:info])
            {
                marker.map = nil;
                [markerInfo setValue:@"YES" forKey:@"mustBeRemoved"];

            }
        }

        // set isOnMap property to NO, for the markers which will be removed from the map
        for (NSMutableDictionary *markerInfo in [[RMNManager sharedManager]locationsBigAssDictionary])
        {
            if (![resultArray containsObject:markerInfo])
            {
                [markerInfo setValue:@"NO" forKey:@"isOnMap"];
                
            }
        }
    }
    
    NSLog(@"ZA KEY %@",searchingMatcherKey);

    CLLocationCoordinate2D northWest    =   mapView.projection.visibleRegion.farLeft;
    CLLocationCoordinate2D southWest    =   mapView.projection.visibleRegion.nearRight;
    
    
    
    
    // find array of pins which souldn't be on the map but are and remove references
    dispatch_async(kBgQueue, ^{
        
        
        // if the pin isn't in the visible region of the map, don't display it
        NSPredicate *predicateWithoutCustomSearch = [NSPredicate predicateWithFormat:@"(mustBeRemoved LIKE %@) OR not ((longitude.floatValue >= %f) AND (longitude.floatValue <= %f) AND (latitude.floatValue <= %f) AND (latitude.floatValue >= %f))",@"YES",northWest.longitude,southWest.longitude,northWest.latitude,southWest.latitude];

        NSArray *resultForMap       = [whereToSearch filteredArrayUsingPredicate:predicateWithoutCustomSearch];
      
        NSArray *resultForReference = [resultArray filteredArrayUsingPredicate:predicateWithoutCustomSearch];
        
        for (NSMutableDictionary* info in resultForReference)
        {
            [info setValue:@"NO"
                    forKey:@"isOnMap"];
            
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (NSMutableDictionary*markerInfo in resultForMap)
            {
                GMSMarker *marker = [markerInfo objectForKey:@"reference"];
                [marker setMap:nil];

                // use this for reusability
                [[[RMNManager sharedManager]markers] removeObject:markerInfo];
            }
            
            
        });
    });

    
    
    // find array of pins which should be on the map but aren't and add them
    dispatch_async(kBgQueue, ^{

        // display only the markers which will be on the visible
        // part of the map
    NSPredicate *predicateWithoutCustomSearch = [NSPredicate predicateWithFormat:@"(hasSearchedText LIKE %@) AND (isOnMap LIKE %@) AND (longitude.floatValue >= %f) AND (longitude.floatValue <= %f) AND (latitude.floatValue <= %f) AND (latitude.floatValue >= %f)",searchingMatcherKey,@"NO",northWest.longitude,southWest.longitude,northWest.latitude,southWest.latitude];

       
        NSArray *result = [resultArray filteredArrayUsingPredicate:predicateWithoutCustomSearch];
        NSLog(@"gaseste %d pe care trebuie sa le puna ",[result count]);


    dispatch_async(dispatch_get_main_queue(), ^{

        for (int i = 0; i<[result count]; i++)
            {
                
                NSMutableDictionary *info = [result objectAtIndex:i];
                
                CGFloat longitude           =   [[info valueForKey:@"longitude"]floatValue];;
                CGFloat latitude            =   [[info valueForKey:@"latitude"]floatValue];;
                
                NSString *name              =   [info valueForKey:@"name"];;
                NSString *locationAddress   =   [info valueForKey:@"localAddress"];
                
                GMSMarker *marker;

                marker = [[GMSMarker alloc] init];

                [info setValue:@"YES" forKey:@"isOnMap"];
                
                
                CLLocationCoordinate2D location =   CLLocationCoordinate2DMake(latitude, longitude);
                marker.position                 =   location;
                marker.appearAnimation          =   YES;
                //                    marker.icon                     =   [UIImage imageNamed:pngLocation];
                marker.map                      =   mapView;
                marker.userData                 =   info;
                marker.title                    =   name;
                marker.snippet                  =   locationAddress;
                

                NSMutableDictionary *markerInfo = [[NSMutableDictionary alloc]initWithDictionary:
                                            @{@"reference":marker,
                                              @"longitude":[NSString stringWithFormat:@"%f",longitude],
                                              @"latitude" :[NSString stringWithFormat:@"%f",latitude],
                                              @"mustBeRemoved":@"NO"}];
                
                
                [[[RMNManager sharedManager]markers] addObject:markerInfo];

            }

        });
    });
    
    
    

}




@end
