//
//  DetailsViewController.h
//  GoogleMap
//
//  Created by Joseph caxton-idowu on 20/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "databaseItem.h"


@interface DetailsViewController : UIViewController{
    
      databaseItem *ObjectsToShow;
}
@property (nonatomic, retain)  databaseItem *ObjectsToShow;

@property (nonatomic, retain)  UILabel *uid;
@property (nonatomic, retain)  UILabel *name;
@property (nonatomic, retain)  UILabel *contactPhone;
@property (nonatomic, retain)  UILabel *contactTwitter;
@property (nonatomic, retain)  UILabel *localAddress;
@property (nonatomic, retain)  UILabel *crossStreet;
@property (nonatomic, retain)  UILabel *city;
@property (nonatomic, retain)  UILabel *state;


@property (nonatomic, retain)  UILabel *postCode;
@property (nonatomic, retain)  UILabel *country;
@property (nonatomic, retain)  UILabel *latitude;
@property (nonatomic, retain)  UILabel *longitude;
@property (nonatomic, retain)  UILabel *distance;
@property (nonatomic, retain)  UILabel *SiteURL;
@property (nonatomic, retain)  UILabel *Hours;
@property (nonatomic, retain)  UILabel *Price;
@property (nonatomic, retain)  UILabel *Rating;
@property (nonatomic, retain)  UILabel *Description;
@property (nonatomic, retain)  UILabel *flag;
@property (nonatomic, retain)  UILabel *PhotoPrefix;
@property (nonatomic, retain)  UILabel *PhotoSuffix;
@property (nonatomic, retain)  UILabel *Categories;

@property (nonatomic, retain)  UIImage *image;
@property (nonatomic, retain)  UIImageView *imageView;
@property (nonatomic, retain)  UIScrollView* scrollView;

@property (nonatomic, retain)  UIImageView *PlaceImageView;
@property (nonatomic, retain)  UIImage *PlaceImage;


@end
