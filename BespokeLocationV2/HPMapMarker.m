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


+ (void)addMarkersToMap:(GMSMapView*)mapView withInfo:(NSArray*)resultArray

{
    
    CLLocationCoordinate2D northWest    =   mapView.projection.visibleRegion.farLeft;
    CLLocationCoordinate2D southWest    =   mapView.projection.visibleRegion.nearRight;
    
    
    // find array of pins which souldn't be on the map but are and remove references
    dispatch_async(kBgQueue, ^{
        
        
        // if the pin isn't in the visible region of the map, don't display it
        NSPredicate *predicateWithoutCustomSearch = [NSPredicate predicateWithFormat:@"not ((longitude.floatValue >= %f) AND (longitude.floatValue <= %f) AND (latitude.floatValue <= %f) AND (latitude.floatValue >= %f))",northWest.longitude,southWest.longitude,northWest.latitude,southWest.latitude];
        
               NSArray *whereToSearch      = [[RMNManager sharedManager]markers];
        NSArray *resultForMap       = [whereToSearch filteredArrayUsingPredicate:predicateWithoutCustomSearch];
        NSArray *resultForReference = [resultArray filteredArrayUsingPredicate:predicateWithoutCustomSearch];
        NSLog(@"ZICE CA SUNT %d pentru harta si %d pentru referinta",[resultForMap count],[resultForReference count]);
        
        for (NSMutableDictionary* info in resultForReference)
        {
            [info setValue:@"NO" forKey:@"isOnMap"];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            for (NSDictionary*markerInfo in resultForMap)
            {
                GMSMarker *marker = [markerInfo objectForKey:@"reference"];
                [marker setMap:nil];
                [[[RMNManager sharedManager]markers] removeObject:markerInfo];
             
            }
            
        });
    });

    
    
    
    // find array of pins which should be on the map but aren't and add them
    dispatch_async(kBgQueue, ^{

        // display only the markers which will be on the visible
        // part of the map
    NSPredicate *predicateWithoutCustomSearch = [NSPredicate predicateWithFormat:@"(isOnMap LIKE %@) AND (longitude.floatValue >= %f) AND (longitude.floatValue <= %f) AND (latitude.floatValue <= %f) AND (latitude.floatValue >= %f)",@"NO",northWest.longitude,southWest.longitude,northWest.latitude,southWest.latitude];
    

    NSArray *result = [resultArray filteredArrayUsingPredicate:predicateWithoutCustomSearch];
    
    NSLog(@"ZICE CA SUNT %d in plus de pus",[result count]);
        
    dispatch_async(dispatch_get_main_queue(), ^{
        
            for (NSMutableDictionary *info in result)
            {
                
                CGFloat longitude           =   [[info valueForKey:@"longitude"]floatValue];;
                CGFloat latitude            =   [[info valueForKey:@"latitude"]floatValue];;
                
                NSString *name              =   [info valueForKey:@"name"];;
                NSString *locationAddress   =   [info valueForKey:@"localAddress"];;
                GMSMarker *marker           =   [[GMSMarker alloc] init];

                [info setValue:@"YES" forKey:@"isOnMap"];
                
                CLLocationCoordinate2D location =   CLLocationCoordinate2DMake(latitude, longitude);
                marker.position                 =   location;
                marker.appearAnimation          =   YES;
                //                    marker.icon                     =   [UIImage imageNamed:pngLocation];
                marker.map                      =   mapView;
                marker.userData                 =   info;
                marker.title                    =   name;
                marker.snippet                  =   locationAddress;
                
                
                NSDictionary *markerInfo = @{@"reference":marker,
                                             @"longitude":[NSString stringWithFormat:@"%f",longitude],
                                             @"latitude" :[NSString stringWithFormat:@"%f",latitude]};
                [[[RMNManager sharedManager]markers] addObject:markerInfo];
                
            }

        });
    });
    
    
}



+ (void)removeMarkersFrom:(GMSMapView*)mapView
               withString:(NSString*)filterString
              currentInfo:(NSArray*)filtersDictionary
{

    
    
    NSString *searchingHero = filterString;
    NSArray *myFilters = [searchingHero componentsSeparatedByCharactersInSet:
                        [NSCharacterSet characterSetWithCharactersInString:@"-/, "]
                        ];

    
    NSLog(@"FILTRE %@",myFilters);
    NSArray *searchTerms = @[ @"Bahnhofstr", @"Bahnhofstr" ];

    // OR ANY name LIKE %@ OR ANY postcode LIKE %@
//    NSString *str = @"Bahnhofstr";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"((SELF.localAddress CONTAINS[cd] %@) OR (SELF.city CONTAINS[cd] %@) OR (SELF.country CONTAINS[cd] %@))",searchTerms,searchTerms,searchTerms];
    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"subquery(self.@allValues, $av, $av contains %@).@count > 0",str];
   
    
//    
    NSPredicate *predicate = [NSPredicate predicateWithBlock:^ (id evaluatedObject, NSDictionary *bindings) {
        for (NSString *searchTerm in searchTerms) {
            
          NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF CONTAINS[cd] %@",searchTerm];
            
            for (id valueString in [evaluatedObject allValues])
            {
                NSLog(@"ESTE LAAAA %@",valueString);
                if (![valueString isKindOfClass:[NSString class]])
                {
                    NSLog(@"DE TIP ALTCEVA %@ MAI EXACT %@",valueString,[NSString class]);
                    break;
                }
                else
                {
                  
//                    NSArray *myCustomVars = [valueString componentsSeparatedByCharactersInSet:
//                                          [NSCharacterSet characterSetWithCharactersInString:@"-/,"]
//                                          ];
                    NSArray *myCustomVars = [valueString componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                    myCustomVars = [myCustomVars filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF != ''"]];
                    
                    
                    
                    
                    NSArray *result = [myCustomVars filteredArrayUsingPredicate:pred];
                    NSLog(@"CAUTA IN %@ si are %d elemente",myCustomVars, [myCustomVars count]);
                    NSLog(@"gaseste rezultat %@",result);
                }
            }
            
//            NSArray *resultArray = [evaluatedObject  filteredArrayUsingPredicate:pred];
            
//            NSLog(@"GASESTE %@ IN %@",searchTerm,evaluatedObject);
//            if ([resultArray count] > 0) {
//                return YES;
//            }
        }
        return NO;
    }];
    
    
//    NSArray *resultArray = [filtersDictionary filteredArrayUsingPredicate:pred];

    
    
    NSArray *result = [filtersDictionary filteredArrayUsingPredicate:predicate];
    
    NSLog(@"ARE CA REZULTAT %@",result);
    
    
    dispatch_async(kBgQueue, ^{
        
        // filter locations
//        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.localAddress contains[cd] %@", @"Gessner-Allee"];
        
//        NSArray *resultArray = [filtersDictionary  filteredArrayUsingPredicate:predicate];
        
//
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
//            NSLog(@"A GASIT %@",resultArray);
//            for (NSDictionary *info in resultArray)
//            {
//                
//                CGFloat longitude;
//                CGFloat latitude;
//                NSString *name;
//                NSString *locationAddress;
//                
//                
//                
//                GMSMarker *marker       =   [[GMSMarker alloc] init];
//                
//                
//                
//                longitude           =   [[info valueForKey:@"longitude"]floatValue];
//                latitude            =   [[info valueForKey:@"latitude"]floatValue];
//                locationAddress     =   [info valueForKey:@"localAddress"];
//                name                =   [info valueForKey:@"name"];
//                
//                CLLocationCoordinate2D location =   CLLocationCoordinate2DMake(latitude, longitude);
//                marker.position                 =   location;
//                marker.appearAnimation          =   YES;
//                //                    marker.icon                     =   [UIImage imageNamed:pngLocation];
//                marker.map                      =   mapView;
//                marker.userData                 =   info;
//                marker.title                    =   name;
//                marker.snippet                  =   locationAddress;
//                
//            }
            
        });
        
    });

    
}


@end
