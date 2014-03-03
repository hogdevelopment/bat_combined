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

- (void) doSomeHTTPRequestFor:(RMNRequestType)type
{
    NSString *searchType;
    NSString *post=@"";
    
    switch (type)
    {
            // it requiers the longitude, latitude and radius to retrieve locations found in that area
        case RMNRequestLocationDataBase:
        {
            
            NSString *latitude      = @"47.37";
            NSString *longitude     = @"8.54";
            NSString *radius        = @"1000000";
            NSString *urlBody       = @"http://ec2-54-213-195-182.us-west-2.compute.amazonaws.com/location/get/";
            searchType              = [NSString stringWithFormat:@"%@%@/%@/%@",urlBody,latitude,longitude,radius];
            NSLog(@"search type %@",searchType);
            break;
        }
            // it requiers onlty the foursquare ID
        case RMNRequestLocationFoursquare:
        {

            NSString *URL                   = @"https://api.foursquare.com/v2/venues/";
            NSString *urlPlusFoursquareID   = [URL stringByAppendingString:self.foursquareID];
            NSString *clientStuff           = [urlPlusFoursquareID stringByAppendingString:@"?client_id=3JMQKES3RGKQC332IYOKEOM0X54VYR3WYPWB2V151VOHEP4H&client_secret=5RZFHTRJRBXRHMU5B0SA4EQSIWKPU3T0JBY0JFPYJU40100O&v=20130815"];

            
            searchType = clientStuff;
            
            
            break;
        }
            // it requiers the email and password
        case RMNRequestUserLogin:
        {
            
            NSString*password   = [self.requestInfo valueForKey:@"password"];
            NSString*username   = [self.requestInfo valueForKey:@"username"];
            
            searchType = @"http://ec2-54-213-195-182.us-west-2.compute.amazonaws.com/user/login";
            post = [NSString stringWithFormat:@"username=%@&password=%@",username,password];
            break;
        }
            // it requiers only the username
        case RMNRequestCheckUsername:
        {

            NSString*username       = [self.requestInfo valueForKey:@"username"];
            NSLog(@"USERUL %@",username);
            searchType = @"http://ec2-54-213-195-182.us-west-2.compute.amazonaws.com/user/usernamecheck";
            post = [NSString stringWithFormat:@"username=%@",username];
            NSLog(@"username check");
            break;
        }
            // it requiers the username, password, email, first name, last name and the gender
        case RMNRequestUserRegister:
        {

         

            
            NSString*username   = [self.requestInfo valueForKey:@"username"];
            NSString*password   = [self.requestInfo valueForKey:@"password"];
            NSString*email      = [self.requestInfo valueForKey:@"email"];
            NSString*firstName  = [self.requestInfo valueForKey:@"firstName"];
            NSString*lastName   = [self.requestInfo valueForKey:@"lastName"];
            NSString*gender     = [self.requestInfo valueForKey:@"gender"];
            
            
               NSLog(@"ESTE CU %@ si %@  - %@ -   %@ - %@ -  %@",username,password,email,firstName,lastName,gender);
            
            searchType = @"http://ec2-54-213-195-182.us-west-2.compute.amazonaws.com/user/register";
            post = [NSString stringWithFormat:@"username=%@&password=%@&email=%@&first_name=%@&last_name=%@&gender=%@",username,password,email,firstName,lastName,gender];
            
            break;
        }
            // it requiers the users id and the password
        case RMNRequestUserChangePassword:
        {

            NSString*userID     = [self.requestInfo valueForKey:@"user_id"];
            NSString*password   = [self.requestInfo valueForKey:@"password"];
            
            searchType = @"http://ec2-54-213-195-182.us-west-2.compute.amazonaws.com/user/passwordchange";
            post = [NSString stringWithFormat:@"user_id=%@&password=%@",userID,password];
            break;
        }
            // it requiers the users ID, email, first name, last name and the gender
        case RMNRequestUserInfoUpdate:
        {

            NSString*userID     = [self.requestInfo valueForKey:@"userID"];
            NSString*email      = [self.requestInfo valueForKey:@"email"];
            NSString*firstName  = [self.requestInfo valueForKey:@"firstName"];
            NSString*lastName   = [self.requestInfo valueForKey:@"lastName"];
            NSString*gender     = [self.requestInfo valueForKey:@"gender"];
            
            NSLog(@"ESTE CU %@ si %@  - %@ -   %@ - %@ -  %@",userID,email,email,firstName,lastName,gender);

            
            searchType = @"http://ec2-54-213-195-182.us-west-2.compute.amazonaws.com/user/register";
            post = [NSString stringWithFormat:@"user_id=%@&email=%@&first_name=%@&last_name=%@&gender=%@",userID,email,firstName,lastName,gender];
            break;
        }
        case RMNRequestUserRatingAction:
        {
            searchType = @"http://ec2-54-213-195-182.us-west-2.compute.amazonaws.com/locations/addrating";
            NSString*userID         = [self.requestInfo valueForKey:@"userID"];
            NSString*locationID     = [self.requestInfo valueForKey:@"locationID"];
            NSString*rating         = [self.requestInfo valueForKey:@"rating"];
            
            post = [NSString stringWithFormat:@"user_id=%@&location_id=%@&rating=%@",userID,locationID,rating];
            
            break;
        }

            
        default:
            break;
    }

    NSString *urlAsString = searchType;
    
    // build the url from the gathered information
    NSURL *url = [NSURL URLWithString:urlAsString];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:url];
    
    if (type != RMNRequestLocationDataBase &&
        type != RMNRequestLocationFoursquare)
    {
        NSLog(@"este pentru usercheck");
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSString *postLength = [NSString stringWithFormat:@"%d", [postData length]];
        
        // build the request
        [request setHTTPMethod:@"POST"];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:postData];

    }
  
    
    

    
    
    [self httpForRequest:request withType:type];
    

}

- (void)httpForRequest:(NSMutableURLRequest*)request withType:(RMNRequestType)type
{
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:
     ^(NSURLResponse *response, NSData *data, NSError *error)
     {
         
         if (error) {
             
             // tell tell the delegate an error appeared
             // and the request couldn't complete
              [self.delegate fetchingGroupsFailedWithError:error];
         
         } else {
             
             
            
             switch (type)
             {
                // parse the data depending on the request
                     
                     // build a dictionary with locations from the database
                 case RMNRequestLocationDataBase:
                 {
                     [self.delegate receivedLocationsJSONFromDataBase:data];
                     break;
                 }
                     // build a dictionary with detailed info for a location using foursquare
                 case RMNRequestLocationFoursquare:
                 {
                     [self.delegate receivedLocationsJSONFromFoursquare:data];
                     break;
                 }
                     // builds answer for certain requests
                 case RMNRequestUserLogin:
                 case RMNRequestCheckUsername:
                 case RMNRequestUserChangePassword:
                 case RMNRequestUserInfoUpdate:
                 case RMNRequestUserRegister:
                 {
                      NSLog(@"za result %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
                     [self.delegate requestAnswer:data];
                     break;
                 }
                 default:
                     break;
             }

             
         }
     }];
}



@end
