//
//  RMNFoursquaredLocation.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 26/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMNFoursquaredLocationFetcher.h"

@protocol RMNFoursquaredLocationFetcher;


@interface RMNFoursquaredLocation : NSObject

//init the location
- (id)initFromSource:(NSDictionary*)source;


@property (nonatomic) id<RMNFoursquaredLocationFetcher> delegate;


// the name of the location
@property (strong, nonatomic) NSString *name;

// the description of the location
@property (strong, nonatomic) NSString *description;

// the complete address for the location
@property (strong, nonatomic) NSString *address;

// the postal code of the location
@property (strong, nonatomic) NSString *postalCode;

// locations city
@property (strong, nonatomic) NSString *city;

// locations state
@property (strong, nonatomic) NSString *state;

// locations country
@property (strong, nonatomic) NSString *country;

// opening hours
@property (strong, nonatomic) NSString *hoursOpen;

// days open
@property (strong, nonatomic) NSString *daysOpen;

// custom open time
@property (strong, nonatomic) NSString *openTime;

// stores an array of photos
@property (strong, nonatomic) NSArray        *photos;
@property (strong, nonatomic) NSMutableArray *imagesArray;

// the locations contact phone number
@property (strong, nonatomic) NSString *phoneNumber;

// the locations contact twitter username
@property (strong, nonatomic) NSString *twitterUserName;

// the location url
@property (strong, nonatomic) NSString *locationUrl;

// locations price rating
@property (strong, nonatomic) NSString *price;


// locations attributes
@property (strong, nonatomic) NSArray *attributes;


@end
