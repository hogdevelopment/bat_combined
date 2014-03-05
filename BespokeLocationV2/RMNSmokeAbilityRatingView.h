//
//  RMNSmokeAbilityRatingView.h
//  BespokeLocationV2
//
//  Created by infodesign on 3/5/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNSmokeAbilityRatingView : UIView
{
    UILabel  *viewTitle;
    UILabel  *countRating;
    UIView   *starsRating;
}

@property  UILabel  *viewTitle;
@property  UILabel  *countRating;
@property  UIView   *starsRating;

- (void) updateWithRating: (int) newRating andCountRatings: (int) count;

@end
