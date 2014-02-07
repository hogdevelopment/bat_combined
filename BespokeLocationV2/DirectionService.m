//
//  DirectionService.m
//  GoogleMap
//
//  Created by Joseph caxton-idowu on 21/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "DirectionService.h"

@implementation DirectionService{
@private
    BOOL _sensor;
    BOOL _alternatives;
    NSURL *_directionsURL;
    NSArray *_waypoints;
}

static NSString *kMDDirectionsURL = @"http://maps.googleapis.com/maps/api/directions/json?";

- (void)setDirectionsQuery:(NSDictionary *)query withSelector:(SEL)selector
              withDelegate:(id)delegate{
    NSArray *waypoints = [query objectForKey:@"waypoints"];
    NSString *origin = [waypoints objectAtIndex:0];
    NSInteger waypointCount = [waypoints count];
    NSInteger destinationPos = waypointCount -1;
    NSString *destination = [waypoints objectAtIndex:destinationPos];
    NSString *sensor = [query objectForKey:@"sensor"];
    NSString *mode = [query objectForKey:@"mode"];
    NSString *url;
    if (mode == nil) {
        // This means user is driving which is the default setting on googlemap
        
        url = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=%@",kMDDirectionsURL,origin,destination,sensor];
    }
    
    else{
        // User is walking
        url = [NSString stringWithFormat:@"%@&origin=%@&destination=%@&sensor=%@&mode=%@",kMDDirectionsURL,origin,destination,sensor,mode];
    
    }

    

   /* if(waypointCount>2) {
        [url appendString:@"&waypoints=optimize:true"];
        int wpCount = waypointCount-2;
        for(int i=1;i<wpCount;i++){
            [url appendString: @"|"];
            [url appendString:[waypoints objectAtIndex:i]];
        }
    } */
    url = [url stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    _directionsURL = [NSURL URLWithString:url];
    [self retrieveDirections:selector withDelegate:delegate];
}

- (void)retrieveDirections:(SEL)selector withDelegate:(id)delegate{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSData* data =
        [NSData dataWithContentsOfURL:_directionsURL];
        [self fetchedData:data withSelector:selector withDelegate:delegate];
    });
}

- (void)fetchedData:(NSData *)data withSelector:(SEL)selector withDelegate:(id)delegate{
    
    NSError* error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    [delegate performSelector:selector withObject:json];
}


@end
