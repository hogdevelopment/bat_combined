//
//  RMNFoursquaredLocation.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 26/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFoursquaredLocation.h"


@implementation RMNFoursquaredLocation

@synthesize delegate;
@synthesize phoneNumber;
@synthesize photos;
@synthesize description;
@synthesize name;

- (id)initFromSource:(NSDictionary*)source
{
    self = [super init];
    
    if (self)
    {
       // do the population in bg mode
        dispatch_async(kBgQueue, ^{

            
            self.photos             = [source valueForDeepKeyLinkingCustom:@"photos.groups.items.user.photo"];
            self.phoneNumber        = [source valueForDeepKeyLinkingCustom:@"contact.formattedPhone"];
            self.twitterUserName    = [source valueForDeepKeyLinkingCustom:@"contact.twitter"];
            self.name               = [source valueForDeepKeyLinkingCustom:@"name"];
            self.description        = [source valueForDeepKeyLinkingCustom:@"description"];
            self.address            = [source valueForDeepKeyLinkingCustom:@"location.address"];
            self.postalCode         = [source valueForDeepKeyLinkingCustom:@"location.postalCode"];
            self.city               = [source valueForDeepKeyLinkingCustom:@"location.city"];
            self.state              = [source valueForDeepKeyLinkingCustom:@"location.state"];
            self.country            = [source valueForDeepKeyLinkingCustom:@"location.country"];
            self.hoursOpen          = [source valueForDeepKeyLinkingCustom:@"hours.timeframes.open.renderedTime"];
            self.daysOpen           = [source valueForDeepKeyLinkingCustom:@"hours.timeframes.days"];
            self.locationUrl        = [source valueForDeepKeyLinkingCustom:@"url"];
            self.price              = [source valueForDeepKeyLinkingCustom:@"price"];
            self.attributes         = [source valueForDeepKeyLinkingCustom:@"attributes.groups"];

            //update the delegate view controller the data is filtered
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.delegate finishedWithInfo:self];
            });
            
        });
        
    }
    
    return self;
}
@end
