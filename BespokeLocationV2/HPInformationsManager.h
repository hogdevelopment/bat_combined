//
//  HPInformationsManager.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "HPInformationsManagerDelegate.h"
#import "HPCommunicatorDelegate.h"
#import "RMNCustomRequestsDelegate.h"
#import "RMNFoursquareInterrogatorDelegate.h"

@class HPCommunicator;




@interface HPInformationsManager : NSObject<HPCommunicatorDelegate>

@property (strong, nonatomic) HPCommunicator *communicator;

@property (nonatomic) id<HPInformationsManagerDelegate>     locationsDelegate;
@property (nonatomic) id<RMNFoursquareInterrogatorDelegate> locationDetailDelegate;
@property (nonatomic) id<RMNCustomRequestsDelegate>         customRequestDelegate;

// fetches the locations from the database
- (void)fetchLocations;

// fetches specific details from foursquare database by an ID
- (void)fetchDetailedInfoForFoursquareID:(NSString*)foursquareID;

// fetches information regarding custom requests
// if all the keys aren't provided an error will be sent to
// the delegate
- (void)fetchAnswerFor:(RMNRequestType)requestType
       withRequestData:(NSDictionary*)requestInfo;
@end
