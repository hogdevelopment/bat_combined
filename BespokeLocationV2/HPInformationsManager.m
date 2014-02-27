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
   [self.communicator doSomeHTTPRequestFor:RMNRequestLocationDataBase];

}

- (void)fetchDetailedInfoForFoursquareID:(NSString *)foursquareID
{
    [self.communicator setFoursquareID:foursquareID];
    [self.communicator doSomeHTTPRequestFor:RMNRequestLocationFoursquare];
}

- (void) fetchAnswerFor:(RMNRequestType)requestType withRequestData:(NSDictionary *)requestInfo
{
    [self.communicator setRequestInfo:requestInfo];
    [self.communicator  doSomeHTTPRequestFor:requestType];
}

#pragma mark -LocationCommunicatorDelegate


- (void)receivedLocationsJSONFromDataBase:(NSData *)objectNotation
{

    NSError* error;

    
    NSDictionary *groups = [HPLocationBuilder locationsFromDataBase:objectNotation error:&error  ];
    
    if (error != nil)
    {
        if ([self.locationsDelegate respondsToSelector:@selector(fetchingLocationsFailedWithError:)])
        {
            [self.locationsDelegate fetchingLocationsFailedWithError:error];
        }
        else
        {
            NSLog(@">>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>You forgot to bring the delegate method fetchingLocationsFailedWithError>>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>");
        }
        
    } else
    {
        if ([self.locationsDelegate respondsToSelector:@selector(didReceiveLocations:)])
        {
            [self.locationsDelegate didReceiveLocations:groups];
        }
        else
        {
            NSLog(@">>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>You forgot to bring the delegate method didReceiveLocations>>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>");
        }
    }
}


- (void)receivedLocationsJSONFromFoursquare:(NSData *)objectNotation
{
    
    NSError* error;
    
    
    NSDictionary *groups = [HPLocationBuilder locationsFromFoursquare:objectNotation error:&error];
    
    if (error != nil)
    {
        if ([self.locationDetailDelegate respondsToSelector:@selector(fetchingDetailsForLocationFailedWithError:)])
        {
            [self.locationDetailDelegate fetchingDetailsForLocationFailedWithError:error];
        }
        else
        {
            NSLog(@">>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>You forgot to bring the delegate method fetchingDetailsForLocationFailedWithError>>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>");
        }
        
    } else
    {
        if ([self.locationDetailDelegate respondsToSelector:@selector(didReceiveDetailsForFourSquareLocation:)])
        {
            [self.locationDetailDelegate didReceiveDetailsForFourSquareLocation:groups];
        }
        else
        {
            NSLog(@">>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>You forgot to bring the delegate method didReceiveDetailsForFourSquareLocation>>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>");
        }
    }
}



- (void)requestAnswer:(NSData *)answer
{
    
    NSError* error;
    NSDictionary *answerDictionary = [HPLocationBuilder answerFrom:answer
                                                             error:&error];


    
    if (error != nil)
    {
        if ([self.customRequestDelegate respondsToSelector:@selector(requestingFailedWithError:)])
        {
            [self.customRequestDelegate requestingFailedWithError:error];
        }
        else
        {
            NSLog(@">>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>You forgot to bring the delegate method requestingFailedWithError>>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>");
        }
        
    } else
    {
        if ([self.customRequestDelegate respondsToSelector:@selector(didReceiveAnswer:)])
        {
            [self.customRequestDelegate didReceiveAnswer:answerDictionary];
        }
        else
        {
            NSLog(@">>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>You forgot to bring the delegate method didReceiveAnswer>>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>");
        }
    }
}

- (void)fetchingGroupsFailedWithError:(NSError *)error
{
    if ([self.locationsDelegate respondsToSelector:@selector(fetchingLocationsFailedWithError:)])
    {
        [self.locationsDelegate fetchingLocationsFailedWithError:error];
    }
    else
    {
        NSLog(@">>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>You forgot to bring the delegate method fetchingLocationsFailedWithError>>>>>>>>>>>>>>!!!!!!!!>>>>>>>>>>>");
    }
}

@end
