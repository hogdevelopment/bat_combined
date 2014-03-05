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
@synthesize openTime;
@synthesize imagesArray;

- (id)initFromSource:(NSDictionary*)source
{
    self = [super init];
    
    if (self)
    {
       // do the population in bg mode
        dispatch_async(kBgQueue, ^{

            
            self.photos             = [source valueForDeepKeyLinkingCustom:@"photos.groups.items"];
            self.phoneNumber        = [source valueForDeepKeyLinkingCustom:@"contact.formattedPhone"];
            self.twitterUserName    = [source valueForDeepKeyLinkingCustom:@"contact.twitter"];
            self.name               = [source valueForDeepKeyLinkingCustom:@"name"];
            self.description        = [source valueForDeepKeyLinkingCustom:@"description"];
            //description
            self.address            = [source valueForDeepKeyLinkingCustom:@"location.address"];
            self.postalCode         = [source valueForDeepKeyLinkingCustom:@"location.postalCode"];
            self.city               = [source valueForDeepKeyLinkingCustom:@"location.city"];
            self.state              = [source valueForDeepKeyLinkingCustom:@"location.state"];
            self.country            = [source valueForDeepKeyLinkingCustom:@"location.country"];
            self.hoursOpen          = [[[source valueForDeepKeyLinkingCustom:@"hours.timeframes.open.renderedTime"]lastObject]lastObject];
            self.daysOpen           = [[source valueForDeepKeyLinkingCustom:@"hours.timeframes.days"]lastObject];
            self.locationUrl        = [source valueForDeepKeyLinkingCustom:@"url"];
            self.price              = [source valueForDeepKeyLinkingCustom:@"price.tier"];
            self.attributes         = [source valueForDeepKeyLinkingCustom:@"attributes.groups"];

            
            self.openTime = [NSString stringWithFormat:@"%@ - %@",self.daysOpen,self.hoursOpen];
            
            self.imagesArray = [[NSMutableArray alloc]init];
            
            NSLog(@"gaseste %@",self.description);
            
            
            for (NSDictionary *info in self.photos)
            {
                NSArray *infoSuffix = [info valueForKey:@"suffix"];
                NSArray *infoPreffix = [info valueForKey:@"prefix"];
                for (int i = 0; i<[infoSuffix count];i++)
                {
                    
                
                
                NSString *prefix    = [infoPreffix objectAtIndex:i];
                NSString *suffix    = [infoSuffix   objectAtIndex:i];
                
                NSString *imageUrl  = [NSString stringWithFormat:@"%@480x400%@",prefix,suffix];
                
                [self.imagesArray addObject:imageUrl];
                
                    
                }
            }
            
            
            //update the delegate view controller the data is filtered
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.delegate finishedWithInfo:self];
            });
            
        });
        
    }
    
    return self;
}
@end
