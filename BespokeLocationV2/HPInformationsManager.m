//
//  HPInformationsManager.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "HPInformationsManager.h"
#import "HPLocationBuilder.h"
#import "HPCommunicator.h"

@implementation HPInformationsManager

- (void)fetchLocations
{
   [self.communicator doSomeHTTPRequestFor:RMNLocationDataBase];

}

- (void)fetchDetailedInfoForFoursquareID:(NSString *)foursquareID
{
    [self.communicator setFoursquareID:foursquareID];
    [self.communicator doSomeHTTPRequestFor:RMNLocationFoursquare];
}

#pragma mark -LocationCommunicatorDelegate


- (void)receivedLocationsJSONFromDataBase:(NSData *)objectNotation
{

    NSError* error;

    
    NSDictionary *groups = [HPLocationBuilder locationsFromDataBase:objectNotation error:&error  ];
    
    if (error != nil)
    {
        [self.delegate fetchingLocationsFailedWithError:error];
        
    } else
    {
        [self.delegate didReceiveLocations:groups];
    }
}


- (void)receivedLocationsJSONFromFoursquare:(NSData *)objectNotation
{
    
    NSError* error;
    
    
    NSDictionary *groups = [HPLocationBuilder locationsFromFoursquare:objectNotation error:&error];
    
    if (error != nil)
    {
        [self.delegate fetchingLocationsFailedWithError:error];
        
    } else
    {
        [self.delegate didReceiveDetailsForFourSquareLocation:groups];
    }
}


- (void)fetchingGroupsFailedWithError:(NSError *)error
{
    [self.delegate fetchingLocationsFailedWithError:error];
}

@end
