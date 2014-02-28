//
//  HPCommunicatorDelegate.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//
// fancy explination

// The Communicator class is responsible for the communication with the
// custom  APIs and fetching the JSON data. It relies on the delegate of
// CommunicatorDelegate to handle the parsing of JSON data. The
// communicator has no idea how the JSON data is handled. Its focus is only on
// creating connection to the custom APIs and fetching the raw JSON result.
//
#import <Foundation/Foundation.h>


typedef enum
{
    RMNRequestLocationDataBase,
    RMNRequestLocationFoursquare,
    RMNRequestUserLogin,
    RMNRequestCheckUsername,
    RMNRequestUserRegister,
    RMNRequestUserChangePassword,
    RMNRequestUserInfoUpdate
}RMNRequestType;




@protocol HPCommunicatorDelegate <NSObject>


- (void)receivedLocationsJSONFromDataBase:(NSData *)objectNotation;
- (void)receivedLocationsJSONFromFoursquare:(NSData *)objectNotation;
- (void)requestAnswer:(NSData*)answer;
- (void)fetchingGroupsFailedWithError:(NSError *)error;
@end

