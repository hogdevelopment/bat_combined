//
//  DirectionsViewController.m
//  GoogleMap
//
//  Created by Joseph caxton-idowu on 21/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "DirectionsViewController.h"
#import "DirectionService.h"
#import "AppDelegate.h"


@interface DirectionsViewController (){
    GMSMapView *mapView_;
    NSMutableArray *waypoints_;
    NSMutableArray *waypointStrings_;
    CLLocationManager *locationManager;
    float Zoom;
}

@end

@implementation DirectionsViewController

@synthesize CurrentLocationlat,CurrentLocationlng,destinationToShow,modeOfTransport,ObjectoToshowFromFourSquare;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UISegmentedControl *driveWalk = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Walk", @"Drive", nil]];
    //[driveWalk setSegmentedControlStyle:UISegmentedControlStyleBar];
    [driveWalk addTarget:self action:@selector(whichMethod:) forControlEvents:UIControlEventValueChanged];
    [driveWalk sizeToFit];
    
    driveWalk.selectedSegmentIndex = 0;
    modeOfTransport = @"walking";
    self.navigationItem.titleView = driveWalk;
    
    Zoom = 14;
    waypoints_ = [[NSMutableArray alloc]init];
    waypointStrings_ = [[NSMutableArray alloc]init];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:CurrentLocationlat
                                                            longitude:CurrentLocationlng
                                                                 zoom:Zoom];
    
    
    mapView_ = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView_.delegate = self;
    mapView_.myLocationEnabled = YES;
    self.view = mapView_;

	
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
    
    
    [locationManager startUpdatingLocation];

}

-(void)refreshMap{
    
    // Lets clean up map first
    [mapView_ clear];
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:CurrentLocationlat
                                                            longitude:CurrentLocationlng
                                                                 zoom:Zoom];
    
    
    [mapView_ setCamera:camera];
    
    // Lets clean up map first
    
    
    // Add the Destination to Map;
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BOOL foursquare = appDelegate.FoursquareAPI;
    
     if(foursquare == TRUE){
         
         CLLocationCoordinate2D destinationPosition = CLLocationCoordinate2DMake([ObjectoToshowFromFourSquare.latitude doubleValue],[ObjectoToshowFromFourSquare.longitude doubleValue]);
         GMSMarker *destinationMarker = [GMSMarker markerWithPosition:destinationPosition];
         destinationMarker.title = ObjectoToshowFromFourSquare.name;
         destinationMarker.snippet = ObjectoToshowFromFourSquare.localAddress;
         
         destinationMarker.map = mapView_;
         
         
         CLLocationCoordinate2D position = CLLocationCoordinate2DMake(CurrentLocationlat,CurrentLocationlng);
         GMSMarker *currentLocationMarker = [GMSMarker markerWithPosition:position];
         //currentLocationMarker.map = mapView_;
         
         // Add the marker to the waypoint array and lat,lng to  waypointStrings array, we would need it later
         [waypoints_ addObject:destinationMarker];
         [waypoints_ addObject:currentLocationMarker];
         
         NSString *positionString0 = [[NSString alloc] initWithFormat:@"%@,%@",ObjectoToshowFromFourSquare.latitude,ObjectoToshowFromFourSquare.longitude];
         [waypointStrings_ addObject:positionString0];
         
         NSString *positionString1 = [[NSString alloc] initWithFormat:@"%f,%f",CurrentLocationlat,CurrentLocationlng];
         
         [waypointStrings_ addObject:positionString1];
         
     }else{
         
    
    
    CLLocationCoordinate2D destinationPosition = CLLocationCoordinate2DMake([destinationToShow.latitude doubleValue],[destinationToShow.longitude doubleValue]);
    GMSMarker *destinationMarker = [GMSMarker markerWithPosition:destinationPosition];
    destinationMarker.title = destinationToShow.name;
    destinationMarker.snippet = destinationToShow.localAddress;
    
    destinationMarker.map = mapView_;

    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(CurrentLocationlat,CurrentLocationlng);
    GMSMarker *currentLocationMarker = [GMSMarker markerWithPosition:position];
    //currentLocationMarker.map = mapView_;
    
    // Add the marker to the waypoint array and lat,lng to  waypointStrings array, we would need it later
    [waypoints_ addObject:destinationMarker];
    [waypoints_ addObject:currentLocationMarker];
    
    NSString *positionString0 = [[NSString alloc] initWithFormat:@"%@,%@",destinationToShow.latitude,destinationToShow.longitude];
    [waypointStrings_ addObject:positionString0];
    
    NSString *positionString1 = [[NSString alloc] initWithFormat:@"%f,%f",CurrentLocationlat,CurrentLocationlng];
         
    [waypointStrings_ addObject:positionString1];
         
     }
    
    NSString *sensor = @"false";
    
    NSArray *parameters;
    NSArray *keys;
    
    if([modeOfTransport isEqualToString:@"walking"]){
        
        NSString *mode = modeOfTransport;
        parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,mode,nil];
        keys = [NSArray arrayWithObjects:@"sensor", @"waypoints",@"mode", nil];

        
    }
        else
        {
            // Google defaults this to driving
            parameters = [NSArray arrayWithObjects:sensor, waypointStrings_,nil];
            keys = [NSArray arrayWithObjects:@"sensor", @"waypoints", nil];

            
        }
    
   
        NSDictionary *query = [NSDictionary dictionaryWithObjects:parameters
                                                      forKeys:keys];

    // Call the service i have created
    DirectionService *mds=[[DirectionService alloc] init];
    SEL selector = @selector(addDirections:);
    [mds setDirectionsQuery:query
               withSelector:selector
               withDelegate:self];
    
    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocation *currentLocation = [locations lastObject];
    CurrentLocationlat = currentLocation.coordinate.latitude;
    CurrentLocationlng = currentLocation.coordinate.longitude;
    
    [self refreshMap];

}

// Draw the path on the map
- (void)addDirections:(NSDictionary *)json {
    
    NSDictionary *routes = [json objectForKey:@"routes"][0];
    
    NSDictionary *route = [routes objectForKey:@"overview_polyline"];
    NSString *overview_route = [route objectForKey:@"points"];
    GMSPath *path = [GMSPath pathFromEncodedPath:overview_route];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:path];
    polyline.strokeColor = [UIColor blueColor];
    polyline.strokeWidth = 2.0f;
    polyline.map = mapView_;
}

- (void) mapView:(GMSMapView *) mapView didChangeCameraPosition:(GMSCameraPosition *)position{
    
    Zoom   = mapView.camera.zoom;
    
}

- (void) whichMethod:(UISegmentedControl *)Sender{
    
    NSInteger selectedIndex = [Sender selectedSegmentIndex];
    
    //NSString *myChoice = [Sender titleForSegmentAtIndex:selectedIndex];
    
    if (selectedIndex == 0){
       
        modeOfTransport = @"walking";
    }
    else {
        
        modeOfTransport = @"driving";
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
