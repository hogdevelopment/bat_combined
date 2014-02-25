//
//  RMNVenueInformationCell.h
//  BespokeLocationV2
//
//  Created by infodesign on 2/21/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNVenueInformationCell : UITableViewCell <UIScrollViewDelegate>

@property  UIScrollView *galleryScrollView;
@property  UIPageControl *pageControl;

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

- (void) setImagesArray: (NSArray *) arrayOfImages;
- (void) setOpeningTimes: (NSString *) opening;
- (void) setVenueSmokeRating: (int) rating;
- (void) setPrice: (int) price;

@end
