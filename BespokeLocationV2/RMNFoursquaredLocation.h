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


// size for the photos
@property (assign) CGSize photoSize;


// stores an array of photos of a pre set size
// the size is set in photoSize variable
// if it's not set a defaul value of 320x200 will be set
@property (strong, nonatomic) NSArray*photos;

// the locations contact phone number
@property (strong, nonatomic) NSString*phoneNumber;

// the locations contact twitter username
@property (strong, nonatomic) NSString*twitterUserName;

@end
