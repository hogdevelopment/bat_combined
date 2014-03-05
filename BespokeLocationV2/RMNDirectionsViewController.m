//
//  RMNDirectionsViewController.m
//  BespokeLocationV2
//
//  Created by infodesign on 3/4/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNDirectionsViewController.h"
#import "RMNSmokeAbilityRatingView.h"

#define kDirectionsURL @"http://maps.googleapis.com/maps/api/directions/json?"


@interface RMNDirectionsViewController ()

@end

@implementation RMNDirectionsViewController

@synthesize startLocation;
@synthesize destinationLocation  = destinationLocation;
@synthesize destinationName      = destinationName;
@synthesize destinationAddress   = destinationAddress;
@synthesize smokingRatingAverage = smokingRatingAverage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    self.navigationItem.title       =   NSLocalizedString(@"Directions",nil);
    
    if (IS_IOS7)
    {
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    }

    
    
    startLocation = [[CLLocation alloc] initWithLatitude:47.37 longitude:8.54];
    
    // create initial camera
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:startLocation.coordinate.latitude
                                                            longitude:startLocation.coordinate.longitude
                                                                 zoom:10];
    // init the google map view with the map created
    mapView = [GMSMapView mapWithFrame:CGRectMake(0, 65, SCREEN_WIDTH, SCREEN_HEIGHT - 65)
                                 camera:camera];
    mapView.myLocationEnabled = YES;
    
    // set the delegate so we can use it's
    // methods to override the custom detail window
    [mapView setDelegate:self];
    
    // rotating the map will mess up the locations array
    mapView.settings.rotateGestures = NO;
    // set the view
    [self.view addSubview: mapView];
    
    markerStart         = [GMSMarker new];
//    markerStart.title   = @"Start";
    markerStart.icon    = [UIImage imageNamed:@"startLocationMapMarker"];
    markerStart.map     = mapView;
    
    markerFinish         = [GMSMarker new];
    markerFinish.title   = destinationName;
    markerFinish.snippet = destinationAddress;
    markerFinish.icon    = [UIImage imageNamed:@"destinationLocationMapMarker"];
    markerFinish.map     = mapView;

    
    //we need user's current location
    if([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
        
        [locationManager startUpdatingLocation];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error"
                                                     message:@"Enable location service"
                                                    delegate:self
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
        [alert show];
    }
    
    [self showRouteOnMap];
    
}


#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    // find out user's current location
    startLocation = [locations lastObject];
    
#warning debug only!
    startLocation = [[CLLocation alloc] initWithLatitude:47.37 longitude:8.54];

    // stop location manager
    [locationManager stopUpdatingLocation];
    
    // update map
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:startLocation.coordinate.latitude
                                                            longitude:startLocation.coordinate.longitude
                                                                 zoom:10];
    [mapView setCamera:camera];
    
    
    // now that we know where the user is
    // show him the directions
    [self showRouteOnMap];

}



#pragma GMSMap

- (void) mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{
    if (marker == markerFinish) {
        
        [self.navigationController popViewControllerAnimated:YES];
    }

}


- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    
    if (marker == markerStart) {
        return Nil;
    }
    
    
    UIView *customView;
    
    int contentWidth = 200;
    int contentHeight = 70;
    
    // calculate width of the title
    CGSize maximumLabelSize = CGSizeMake(1000,30);
    CGSize expectedLabelSize = [[marker title] sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:19.0f]
                                             constrainedToSize:maximumLabelSize
                                                 lineBreakMode:NSLineBreakByWordWrapping];
    //get the new width needed for label.
    contentWidth = expectedLabelSize.width;
    
    if (contentWidth < 220) {
        contentWidth = 220;
    }
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 3, contentWidth + 10, 30)];
    [titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:19.0f]];
    [titleLabel setTextColor:[UIColor colorWithHexString:@"d65019"]];
    titleLabel.text = [marker title];
    
    RMNSmokeAbilityRatingView *ratingView = [[RMNSmokeAbilityRatingView alloc] initWithFrame:CGRectMake(0, 33, 220, 30)];
    ratingView.countRating.hidden = YES;
    [ratingView updateWithRating:smokingRatingAverage andCountRatings:0];
    
    customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentWidth + 20, contentHeight)];
    [customView setBackgroundColor:[UIColor whiteColor]];
    customView.layer.borderColor = [UIColor colorWithHexString:@"bab9b9"].CGColor;
    customView.layer.borderWidth = 1.0f;
    
    [customView addSubview:titleLabel];
    [customView addSubview:ratingView];
    
    
    return customView;
}


- (void) showRouteOnMap
{
    NSMutableArray *arrayWithCoordinates = [[NSMutableArray alloc] initWithObjects:startLocation, destinationLocation, nil];

//    [mapView clear];
    
    [self createPolylineWithLocations:arrayWithCoordinates travelMode:TravelModeDriving];
    
    
}


- (void) createPolylineWithLocations:(NSArray *)locations travelMode:(TravelMode)travelMode
{
    NSMutableArray *locationStrings = [NSMutableArray new];
    
    for (CLLocation *location in locations)
    {
        [locationStrings addObject:[[NSString alloc] initWithFormat:@"%f,%f", location.coordinate.latitude, location.coordinate.longitude]];
    }
    
    NSString *sensor = @"false";
    NSString *origin = [locationStrings objectAtIndex:0];
    NSString *destination = [locationStrings lastObject];
    NSMutableString *url = [NSMutableString stringWithFormat:@"%@origin=%@&destination=%@&sensor=%@", kDirectionsURL, origin, destination, sensor];

    
    switch (travelMode)
    {
        case TravelModeWalking:
            [url appendString:@"&mode=walking"];
            break;
        case TravelModeBicycling:
            [url appendString:@"&mode=bicycling"];
            break;
        case TravelModeTransit:
            [url appendString:@"&mode=transit"];
            break;
        default:
            [url appendString:@"&mode=driving"];
            break;
    }
    
    url = [NSMutableString stringWithString:[url stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding]];
    
    NSURL *directionsURL = [NSURL URLWithString:url];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:directionsURL];
        
        NSError* error;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        
        if (!error)
        {
            NSArray *routesArray = [json objectForKey:@"routes"];
            
            if ([routesArray count] > 0)
            {
                NSDictionary *routeDict = [routesArray objectAtIndex:0];
                NSDictionary *routeOverviewPolyline = [routeDict objectForKey:@"overview_polyline"];
                NSString *points = [routeOverviewPolyline objectForKey:@"points"];
                GMSPath *path = [GMSPath pathFromEncodedPath:points];
                GMSPolyline *gmsPolyline = [GMSPolyline polylineWithPath:path];

                [self drawRouteFromPolyline:gmsPolyline];
            }
            
        }
        else
        {
            NSLog(@"errororor is %@", error);
        }
    });
    
}


- (void) drawRouteFromPolyline: (GMSPolyline *)gmsPolyline
{
    markerStart.position = startLocation.coordinate;
    
    markerFinish.position   = destinationLocation.coordinate;

    polyline = gmsPolyline;
    polyline.strokeWidth = 3;
    polyline.strokeColor = [UIColor blueColor];
    polyline.map = mapView;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
