//
//  HPMapDetailView.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/24/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "HPMapDetailView.h"

@implementation HPMapDetailView

@synthesize detailViewDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code

        
    }
    return self;
}


- (IBAction)seeMoreDetails:(id)sender
{
    [[self detailViewDelegate] showDetailViewToALocation];
}

- (void)setTheTextFields
{
    
    
    [[self placeName] setNumberOfLines:0];
    [[self placeName] setAdjustsFontSizeToFitWidth:YES];
    [[self placeName] setMinimumScaleFactor:6];
    
    [[self locationName] setAdjustsFontSizeToFitWidth:YES];
    [[self locationName] setMinimumScaleFactor:6];
    
    [[self locationType] setAdjustsFontSizeToFitWidth:YES];
    [[self locationType] setMinimumScaleFactor:6];
    
    [[self numberOfViews] setAdjustsFontSizeToFitWidth:YES];
    [[self numberOfViews] setMinimumScaleFactor:6];
}

- (void)populateWithInfo:(NSDictionary*)justALittleBitOfInfo
{

    
    NSString*locationTypeText           =   [NSString stringWithFormat:@"Tip locație:%@",
                                             [justALittleBitOfInfo valueForKey:@"type_name"]];
    NSString*locationNameText           =   [justALittleBitOfInfo valueForKey:@"name"];
   
    
    NSDictionary*dictionary             =   [justALittleBitOfInfo valueForKey:@"informatii_specifice"];
    NSString*location                   =   [NSString stringWithFormat:@"Localitate:%@",
                                             [dictionary valueForKey:@"Localitate"]];
   
    
    
    NSString*numberOfViewsText          =   [NSString stringWithFormat:@"Număr vizualizări:%@",
                                             [justALittleBitOfInfo valueForKey:@"views"]];
    
    [[self placeName]       setText:location];
    [[self locationName]    setText:locationNameText];
    [[self locationType]    setText:locationTypeText];
    [[self numberOfViews]   setText:numberOfViewsText];
    

}
@end
