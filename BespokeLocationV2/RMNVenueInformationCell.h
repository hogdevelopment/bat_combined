//
//  RMNVenueInformationCell.h
//  BespokeLocationV2
//
//  Created by infodesign on 2/21/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

// delegate
@protocol RMNCellVenueInformationDelegate

// methods sent to delegate
// so we know when a button was pressed
- (void)userDidPressAddAttribute;
- (void)userDidPressAddRating;

@end



@interface RMNVenueInformationCell : UITableViewCell <UIScrollViewDelegate>
{
    id <RMNCellVenueInformationDelegate> cellDelegate;
}
@property (nonatomic, strong) id <RMNCellVenueInformationDelegate> cellDelegate;



@property  UIScrollView *galleryScrollView;
@property  UIPageControl *pageControl;
@property  NSMutableArray *arrayWithImages;

@property  UILabel *venueTitle;
@property  UILabel *venueAddress;
@property  UIView  *venueSmokingRatingView;
@property  UILabel *venueOpeningTimes;

@property  UIView  *attributesView;

@property  UILabel *venueDescriptionTitle;
@property  UILabel *venueDescriptionBody;
@property  UILabel *venuePrice;
@property  UILabel *venueSite;

@property  UIView *smokeRatingView;

@property  CGFloat cellHeight;

- (void) setImagesArray: (NSArray *) arrayOfImages;
- (void) setAttributesArray: (NSArray *) arrayOfAttributes;
- (void) setOpeningTimes: (NSString *) opening;
- (void) setVenueSmokeRating: (int) rating;
- (void) setPrice: (int) price;

@end
