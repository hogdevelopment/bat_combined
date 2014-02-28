//
//  RMNFoursquaredLocationFetcher.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 26/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMNFoursquaredLocation.h"

@protocol RMNFoursquaredLocationFetcher <NSObject>
- (void)finishedWithInfo:(id)locationInfo;
@end
