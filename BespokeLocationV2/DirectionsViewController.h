//
//  DirectionsViewController.h
//  GoogleMap
//
//  Created by Joseph caxton-idowu on 21/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "databaseItem.h"
#import "FourSquareResturant.h"

@interface DirectionsViewController : UIViewController <CLLocationManagerDelegate,GMSMapViewDelegate>
    

@property (nonatomic, assign)  double CurrentLocationlat;
@property (nonatomic, assign) double CurrentLocationlng;
@property (nonatomic, retain)  databaseItem *destinationToShow;
@property (nonatomic, retain)  FourSquareResturant *ObjectoToshowFromFourSquare;
@property (nonatomic, retain)  NSString *modeOfTransport;
//@property (nonatomic, assign)  double destinationLocationlat;
//@property (nonatomic, assign) double destinationLocationlng;

@end
