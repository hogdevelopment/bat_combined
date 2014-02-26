//
//  HPCommunicator.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "HPCommunicator.h"
#import "NSString+MD5.h"


@implementation HPCommunicator
@synthesize foursquareID;

- (void) doSomeHTTPRequestFor:(RMNLocationSource)type
{
    NSString *searchType;
    
    switch (type)
    {
        case RMNLocationDataBase:
        {
            searchType = @"http://ec2-54-213-195-182.us-west-2.compute.amazonaws.com/location/get/47.37/8.54/1000000";
            break;
        }
            
        case RMNLocationFoursquare:
        {

            NSString *URL                   = @"https://api.foursquare.com/v2/venues/";
            NSString *urlPlusFoursquareID   = [URL stringByAppendingString:self.foursquareID];
            NSString *clientStuff           = [urlPlusFoursquareID stringByAppendingString:@"?client_id=3JMQKES3RGKQC332IYOKEOM0X54VYR3WYPWB2V151VOHEP4H&client_secret=5RZFHTRJRBXRHMU5B0SA4EQSIWKPU3T0JBY0JFPYJU40100O&v=20130815"];

            
            searchType = clientStuff;
            
            
            break;
        }
        default:
            break;
    }

    
    NSString *urlAsString = searchType;
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            [self.delegate fetchingGroupsFailedWithError:error];
        }
        else
        {
            switch (type)
            {
                case RMNLocationDataBase:
                {
                    [self.delegate receivedLocationsJSONFromDataBase:data];
                    break;
                }
                case RMNLocationFoursquare:
                {
                    [self.delegate receivedLocationsJSONFromFoursquare:data];
                    break;
                }
                default:
                    break;
            }

            
        }
        
        
    }];
     
}

@end
