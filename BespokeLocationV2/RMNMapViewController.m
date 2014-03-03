//
//  RMNMapViewController.m
//
//  Created by Chiosa Gabi on 9/5/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "RMNMapViewController.h"
#import "MFSideMenuContainerViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "HPMapMarker.h"
#import "HPInformationsManager.h"
#import "HPCommunicator.h"
#import "HPMapDetailView.h"
#import "RMNCustomSearchBar.h"
#import "RMNFiltersScrollView.h"
#import "RMNUserSettingsSideMenuViewController.h"
#import "AppDelegate.h"
#import "UIColor+HexRecognition.h"
#import "DetailsTableViewViewController.h"
#import "RMNLoader.h"
#import "RMNVenueInformationViewController.h"

//#import "RMNFoursquaredLocationFetcher.h"



@interface RMNMapViewController ()< HPInformationsManagerDelegate,
                                    RMNUserSettingsLefttSideMenuDelegate>
{

    NSDictionary *locationsBigAssDictionary;
    
    RMNCustomSearchBar *customSearchBar;
    RMNFiltersScrollView *filtersList;
    RMNLoader *loader;
    
    NSDictionary *currentInfoLocation;

}

@property NSDictionary *currentInfoLocation;
@property CLLocationCoordinate2D infoViewCoordinate;
@property NSDictionary *justALittleBitOfInfo;
@end

@implementation RMNMapViewController
{
    GMSMapView *mapView_;
}

@synthesize currentInfoLocation =   currentInfoLocation;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"2980b9"]];
    
    // init custom search bar
    customSearchBar = [[RMNCustomSearchBar alloc] initWithFrame:CGRectMake(0,0, 220, 40)];
    self.navigationItem.titleView = customSearchBar;
    
    
    // start requesting for locations
    HPInformationsManager *manager;
    manager                        = [[HPInformationsManager alloc] init];
    manager.communicator           = [[HPCommunicator alloc] init];
    manager.communicator.delegate  = manager;
    manager.locationsDelegate      = self;
    [manager fetchLocations];


    
    
    [Gigya logoutWithCompletionHandler:^(GSResponse *response, NSError *error)
     {
         if (!error)
         {
             [Gigya setSessionDelegate:nil];
             [self dismissViewControllerAnimated:YES completion:nil];
         }
         else
         {
             NSLog(@"error");
         }
     }];
	
    
    
    CGFloat yForFilsters = 0;
    
    // adjust y of list of filters for each iOS version
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
        self.automaticallyAdjustsScrollViewInsets = NO;
        yForFilsters = self.view.frame.size.height - 50;
    }
    else{
        yForFilsters = self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height - 50;
    }


    yForFilsters = SCREEN_HEIGHT - 50;
    filtersList = [[RMNFiltersScrollView alloc] initWithFrame:CGRectMake(0, yForFilsters, 320, 50)];
    [self.view addSubview:filtersList];
	
    [(RMNUserSettingsSideMenuViewController*)[[self menuContainerViewController]leftMenuViewController] setSideMenuDelegate:self];
    
    
    
    
    // settings needed for autocomplete feature
    [customSearchBar setViewController:self];
    [customSearchBar setLocationCoordinate:[RMNLocationController sharedInstance].locationManager.location.coordinate];
    
    CGFloat heightForMap = filtersList.frame.origin.y - 65;

    
    // create initial camera
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:47.37
                                                            longitude:8.54
                                                                 zoom:10];
    // init the google map view with the map created
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 65, 320, heightForMap)
                                 camera:camera];
    mapView_.myLocationEnabled = YES;
    
    // set the delegate so we can use it's
    // methods to override the custom detail window
    [mapView_ setDelegate:self];
    
    // rotating the map will mess up the locations array
    mapView_.settings.rotateGestures = NO;
    // set the view
    [self.view addSubview: mapView_];
    

    loader = [[[NSBundle mainBundle] loadNibNamed:@"RMNLoader"
                                            owner:self
                                          options:nil]objectAtIndex:0];
    
    [loader animate];
}



- (void)viewWillAppear:(BOOL)animated
{

    [self.navigationItem.leftBarButtonItem  setTintColor:[UIColor whiteColor]];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    if ([[RMNManager sharedManager] menuShouldBeOpened])
    {
        [[self menuContainerViewController] toggleLeftSideMenuCompletion:nil];
        [[RMNManager sharedManager] setMenuShouldBeOpened:NO];
    }
    
    if (![[RMNManager sharedManager]isLoggedIn])
    {
        [self performSegueWithIdentifier:@"loginSegue" sender:self];
        
    }
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"2980b9"]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
//{
//    HPMapDetailView *view = [[[NSBundle mainBundle] loadNibNamed:@"HPMapDetailView"
//                                                           owner:self
//                                                         options:nil]objectAtIndex:0];
//    
//    return view;
//}


- (void) mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *)marker
{

//        RMNVenueInformationViewController *detailsViewController = [[RMNVenueInformationViewController alloc] init];
//        detailsViewController.ObjectsToShow = dbaseItem;
    
    currentInfoLocation =   marker.userData;
    [self performSegueWithIdentifier:@"venueInformationPageSegue" sender:self];
    
    
}


#pragma mark- JSON parser
- (void) didReceiveLocations:(NSDictionary *)groups
{

   // populate fake favourites locations
//    for (NSDictionary *dict in groups)
//    {
//         [RMNUserInfo saveLocationToFavourites:dict];
//    }
    
    // store the received information in an local array
    locationsBigAssDictionary = groups;
    [HPMapMarker addMarkersToMap:mapView_
                        withInfo:locationsBigAssDictionary];
  }


- (void)fetchingLocationsFailedWithError:(NSError *)error
{
    NSLog(@"Error %@; %@", error, [error localizedDescription]);
}



#pragma mark -
#pragma mark - UIBarButtonItem Callbacks

- (MFSideMenuContainerViewController *)menuContainerViewController {
    return (MFSideMenuContainerViewController *)self.navigationController.parentViewController;
}

- (IBAction)showLeftMenuPressed:(id)sender {
    [self.menuContainerViewController toggleLeftSideMenuCompletion:nil];
}

- (IBAction)showRightMenuPressed:(id)sender {
    [self.menuContainerViewController toggleRightSideMenuCompletion:nil];
}

- (void) userDidTouchDown:(RMNUserSettingsSideMenuCellType)menuType
{
    
    NSString *segueIdentifier;
    switch (menuType)
    {
            
        case RMNUserSettingsSideMenuSettings:
        {
            segueIdentifier = @"distancePageSegue";
            break;
        }
        case RMNUserSettingsSideMenuFeedback:
        {
            segueIdentifier = @"mailPageSegue";
            break;
        }
        case RMNUserSettingsSideMenuRateTheApp:
        {
            segueIdentifier = @"rateAppSegue";
            break;
        }
        case RMNUserSettingsSideMenuShareTheApp:
        {
            segueIdentifier = @"shareAppSegue";
            break;
        }
        case RMNUserSettingsSideMenuPrivacy:
        {
            segueIdentifier = @"privacyPageSegue";
            break;
        }
        case RMNUserSettingsSideMenuFAQs:
        {
            segueIdentifier = @"faqsSegue";
            break;
        }
        case RMNUserSettingsSideMenuLogout:
        {
            segueIdentifier = @"loginSegue";
            break;
        }
        case RMNUserSettingsSideMenuFavourites:
        {
            segueIdentifier = @"favouritesLocationSegue";
            break;
        }
        case RMNUserSettingsSideMenuFilters:
        {
            segueIdentifier = @"editFiltersPageSegue";
            break;
        }
        case RMNUserSettingsSideMenuEditProfile:
        {
            segueIdentifier = @"editProfilePageSegue";
            break;
        }
        case RMNUserSettingsSideMenuAbout:
        {
            segueIdentifier = @"aboutPageSegue";
            break;
        }
        case RMNUserSettingsSideMenuUserFilters:
        {
            NSLog(@"AJUNGE AICI, dar nu mai știu ce e cu ea");
            break;
        }
            
        default:
            break;
    }
    
    
    // this will make the main view controller animate to open state
    // when the user presses back button from a page loaded from the
    // side menu controller buttons
    [[RMNManager sharedManager] setMenuShouldBeOpened:YES];
    
    if (segueIdentifier)
    {
        @try
        {
            [self performSegueWithIdentifier:segueIdentifier sender:self];
        }
        @catch (NSException *exception) {
            NSLog(@"Segue not found: %@ with segue %@", exception,segueIdentifier);
        }
        
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"venueInformationPageSegue"]) {
        RMNVenueInformationViewController* detailVenue = [segue destinationViewController];
        detailVenue.venueInfo                          =  currentInfoLocation;
    }
}

@end
