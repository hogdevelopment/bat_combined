//
//  FourSquareResturant.h
//  FourSquareNative
//
//  Created by Joseph caxton-idowu on 16/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface databaseItem : NSObject


@property (nonatomic, retain) NSString *uid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * contactPhone;
@property (nonatomic, retain) NSString * contactTwitter;
@property (nonatomic, retain) NSString * localAddress;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString *crossStreet;
@property (nonatomic, retain) NSString * postCode;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * latitude;
@property (nonatomic, retain) NSString * longitude;
@property (nonatomic, retain) NSString * distance;
@property (nonatomic, retain) NSString * SiteURL;
@property (nonatomic, retain) NSString * Hours;
@property (nonatomic, retain) NSString * Price;
@property (nonatomic, retain) NSString * Rating;
@property (nonatomic, retain) NSString * Description;
@property (nonatomic, assign) bool outsideradius;
@property (nonatomic, retain) NSString *PhotoPrefix;
@property (nonatomic, retain) NSString *PhotoSuffix;
@property (nonatomic, retain) NSString *Categories;
@property (nonatomic, retain) NSString *smokingRatingTotal;
@property (nonatomic, retain) NSString *smokingRatingCount;




@end
