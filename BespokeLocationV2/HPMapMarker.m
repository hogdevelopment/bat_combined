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
