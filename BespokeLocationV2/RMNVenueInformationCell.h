//
//  RMNVenueInformationCell.h
//  BespokeLocationV2
//
//  Created by infodesign on 2/21/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

// delegate
@protocol RMNCellVenueInformationDelegate

// methods sent to delegate
// so we know when a button was pressed
- (void)userDidPressAddAttribute;
- (void)userDidPressAddRating: (CGFloat) rating;
- (void)userDidPressUploadPhoto;
- (void)userDidPressUOnSiteURL;

@end



@interface RMNVenueInformationCell : UITableViewCell <UIScrollViewDelegate>
{
    id <RMNCellVenueInformationDelegate> cellDelegate;
}
@property (nonatomic, strong) id <RMNCellVenueInformationDelegate> cellDelegate;



@property  UIScrollView     *galleryScrollView;
@property  UIPageControl    *pageControl;
@property  NSMutableArray   *arrayWithImages;
@property  UIButton         *uploadPhoto;
@property  UILabel          *noPhotoYetLabel;

@property  UILabel *venueTitle;
@property  UILabel *venueAddress;
@property  UIView  *venueSmokingRatingView;
@property  UILabel *venueOpeningTimes;

@property  UIView  *attributesView;

@property  UILabel  *venueDescriptionTitle;
@property  UILabel  *venueDescriptionBody;
@property  UILabel  *venuePrice;
@property  UIButton *venueSiteButton;

@property  UIView           *smokeRatingView;
@property  ASStarRatingView *ratingStars;

@property  CGFloat cellHeight;

- (void) setImagesArray: (NSArray *) arrayOfImages;
- (void) setAttributesArray: (NSArray *) arrayOfAttributes;
- (void) setOpeningTimes: (NSString *) opening;
- (void) setVenueSmokeRating: (int) rating;
- (void) setPrice: (int) price;
- (void) setVenueURL: (NSString *) urlString;
- (void) setNewCalculatedHeight: (CGFloat) newHeight;


@end
