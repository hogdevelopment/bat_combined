//
//  RMNFoursquareInterrogatorDelegate.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 27/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RMNFoursquareInterrogatorDelegate <NSObject>
@required
- (void)fetchingDetailsForLocationFailedWithError:(NSError *)error;
- (void)didReceiveDetailsForFourSquareLocation:(NSDictionary*)detailedInfo;
@end
