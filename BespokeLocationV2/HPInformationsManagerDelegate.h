//
//  HPInformationsManagerDelegate.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HPInformationsManagerDelegate <NSObject>

//- (void)fetchingLocationsFailedWithError:(NSError *)error;
//- (void)didReceiveDetailsForFourSquareLocation:(NSDictionary*)detailedInfo;

- (void)didReceiveLocations:(NSDictionary *)groups;
- (void)fetchingLocationsFailedWithError:(NSError *)error;






//- (void)requestingFailedWithError:(NSError *)error;
//- (void)didReceiveAnswer:(NSDictionary*)answer;

@end
