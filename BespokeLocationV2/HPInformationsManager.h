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

@class HPCommunicator;



@interface HPInformationsManager : NSObject<HPCommunicatorDelegate>

@property (strong, nonatomic) HPCommunicator *communicator;
@property (nonatomic) id<HPInformationsManagerDelegate> delegate;

// fetches the locations from the database
- (void)fetchLocations;

// fetches specific details from foursquare database by an ID
- (void)fetchDetailedInfoForFoursquareID:(NSString*)foursquareID;
@end
