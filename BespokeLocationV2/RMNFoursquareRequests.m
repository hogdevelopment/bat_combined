//
//  RMNFoursquareRequests.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 26/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFoursquareRequests.h"

@implementation RMNFoursquareRequests

-(NSArray*)photosFromSource:(NSDictionary*)sourceVenue
{
    NSArray *photoArray = [[[[[sourceVenue valueForKey:@"photos"]
                              valueForKey:@"groups"]
                             valueForKey:@"items"]
                            valueForKey:@"user"]
                           valueForKey:@"photo"];
    
    return photoArray;
    
}


- (NSDictionary*)contactInfoFromSource:(NSDictionary*)sourceVenue
{
    NSDictionary *contactInfo = [[sourceVenue valueForKey:@"photos"]
                              valueForKey:@"contact"];
    
    return contactInfo;
}
@end
