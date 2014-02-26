//
//  HPInformationsManagerDelegate.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HPInformationsManagerDelegate <NSObject>

@optional
- (void)didReceiveLocations:(NSDictionary *)groups;
- (void)didReceiveDetailsForFourSquareLocation:(NSDictionary*)detailedInfo;
- (void)fetchingLocationsFailedWithError:(NSError *)error;

@end
