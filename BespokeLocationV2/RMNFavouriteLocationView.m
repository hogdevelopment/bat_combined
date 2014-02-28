//
//  RMNFavouriteLocationView.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFavouriteLocationView.h"
#import <QuartzCore/QuartzCore.h>


@implementation RMNFavouriteLocationView

@synthesize delegate;
@synthesize indexPathSection;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // add rouned cornes to the table
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;
        
        
    }
    return self;
}

- (void)makeItRound
{
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}


- (void)populateWithInformationFrom:(NSDictionary*)locationInfo
{
    
    NSString *name          = [locationInfo valueForKey:@"name"];
    NSString *address       = [locationInfo valueForKey:@"localAddress"];
    NSString *smokingStars  = [[locationInfo valueForKey:@"smokingRatingTotal"]stringValue];
    
    
    [self.locationDescriptionLabel setText:name];
    [self.locationAddressLabel setText:address];
    [self.locationStars setText:smokingStars];
}


- (void)removeLocationAction:(UIButton *)sender
{
    NSLog(@"STERGE LOCATIA");
    
    [[self delegate]removeFavouriteLocationFromSection:self.indexPathSection];

    
}
@end
