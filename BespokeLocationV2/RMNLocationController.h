//
//  RMNLocationController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 25/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

// protocol for sending location updates to another view controller
@protocol LocationControllerDelegate
@required
- (void)locationUpdate:(CLLocation*)location;
@end

@interface RMNLocationController : NSObject<CLLocationManagerDelegate>  {
    
    CLLocationManager* locationManager;
    CLLocation* location;
    __weak id delegate;
}

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLLocation* location;
@property (nonatomic, weak) id  delegate;

+ (RMNLocationController*)sharedInstance; // Singleton method

@end