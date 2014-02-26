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
@synthesize phoneNumber,photos,photoSize;

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

            //update the delegate view controller the data is filtered
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.delegate finishedWithInfo:self];
            });
            
        });
        
        
    }
    
    return self;
}

@end
