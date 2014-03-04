//
//  RMNDirectionsViewController.h
//  BespokeLocationV2
//
//  Created by infodesign on 3/4/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

typedef enum tagTravelMode
{
    TravelModeDriving,
    TravelModeBicycling,
    TravelModeTransit,
    TravelModeWalking
}TravelMode;


@interface RMNDirectionsViewController : UIViewController <GMSMapViewDelegate, CLLocationManagerDelegate>
{
    GMSMapView *mapView;
    
    CLLocation *startLocation;
    CLLocation *destinationLocation;
    
    GMSPolyline         *polyline;
    GMSMarker           *markerStart;
    GMSMarker           *markerFinish;
    CLLocationManager   *locationManager;
    
    NSString *destinationName;

}

@property CLLocation *startLocation;
@property CLLocation *destinationLocation;
@property NSString   *destinationName;


@end
