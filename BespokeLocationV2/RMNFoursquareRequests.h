//
//  RMNFoursquareRequests.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 26/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMNFoursquareRequests : NSObject

// returns array with photos for a certain venue
-(NSArray*)photosFromSource:(NSDictionary*)sourceVenue;


// returns contact info for a certain venu
- (NSDictionary*)contactInfoFromSource:(NSDictionary*)sourceVenue;
@end
