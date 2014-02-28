//
//  RMNLocationController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 25/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNLocationController.h"



static RMNLocationController* sharedCLDelegate = nil;

@implementation RMNLocationController
@synthesize locationManager, location, delegate;

- (id)init
{
    self = [super init];
    if (self != nil) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        [self.locationManager startUpdatingLocation];
    }
    return self;
}

#pragma mark -
#pragma mark CLLocationManagerDelegate Methods
- (void)locationManager:(CLLocationManager*)manager
    didUpdateToLocation:(CLLocation*)newLocation
           fromLocation:(CLLocation*)oldLocation
{
    /* ... */
}

- (void)locationManager:(CLLocationManager*)manager
       didFailWithError:(NSError*)error
{
    /* ... */
    
}

+ (RMNLocationController *)sharedInstance
{
    static RMNLocationController *sharedLocationControllerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedLocationControllerInstance = [[self alloc] init];
    });
    return sharedLocationControllerInstance;
}

@end