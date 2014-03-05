//
//  RMNSmokeAbilityRatingView.m
//  BespokeLocationV2
//
//  Created by infodesign on 3/5/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNSmokeAbilityRatingView.h"

@implementation RMNSmokeAbilityRatingView

@synthesize viewTitle, starsRating, countRating;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self createSubviews];
    }
    return self;
}

- (void) createSubviews
{
    viewTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    [viewTitle setTextAlignment:NSTextAlignmentLeft];
    [viewTitle setTextColor:[UIColor colorWithHexString:@"818181"]];
    [viewTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f]];
    [viewTitle setText:@"Smoke Ability"];
    
    starsRating = [[UIView alloc] initWithFrame:CGRectMake(119, 7, 100, 20)];
    [self createStars];
    
    countRating = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 100, 30)];
    [countRating setTextAlignment:NSTextAlignmentLeft];
    [countRating setTextColor:[UIColor colorWithHexString:@"818181"]];
    [countRating setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f]];
    [countRating setText:@"(ratings)"];
    
    [self addSubview:viewTitle];
    [self addSubview:starsRating];
    [self addSubview:countRating];
}


- (void) createStars
{
    for (int i = 0; i<5; i++) {
        
        UIImageView *star = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"empty_star"]];
        
        [star setFrame:CGRectMake(i * 18, 0, 18, 17)];
        [star setTag:(i+1)];
        
        [starsRating addSubview:star];
    }
}

- (void) updateWithRating: (int) newRating andCountRatings: (int) count
{
    for (UIImageView *star in [starsRating subviews]) {
        
        if (star.tag > newRating) {
            
            [star setImage:[UIImage imageNamed:@"empty_star"]];
        }
        else{
            [star setImage:[UIImage imageNamed:@"full_star"]];
        }
    }
    
    [countRating setText:[NSString stringWithFormat:@"(%u ratings)", count]];

}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
