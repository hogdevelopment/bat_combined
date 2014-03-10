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
#import "RMNSmokeAbilityRatingView.h"
#import "RMNFiltersOperations.h"

//#import "RMNFoursquaredLocationFetcher.h"

@interface RMNMapViewController ()< HPInformationsManagerDelegate,
                                    RMNUserSettingsLefttSideMenuDelegate,
                                    RMNAutocompleteSearchBarTextDelegate>
{

    NSArray *locationsBigAssDictionary;
    NSArray *customFilteredLocationsDictionary;
    
    RMNCustomSearchBar *customSearchBar;
    RMNFiltersScrollView *filtersList;
    RMNLoader *loader;
    
    NSDictionary *currentInfoLocation;

    
    BOOL isSearching;

}

@property NSDictionary *currentInfoLocation;
@property CLLocationCoordinate2D infoViewCoordinate;
@property NSDictionary *justALittleBitOfInfo;
@property NSArray *customFilteredLocationsDictionary;
@property NSArray *locationsBigAssDictionary;
@property BOOL isSearching;

@end

@implementation RMNMapViewController
{
    GMSMapView *mapView_;
}

@synthesize isSearching                         =   isSearching;
@synthesize currentInfoLocation                 =   currentInfoLocation;
@synthesize customFilteredLocationsDictionary   =   customFilteredLocationsDictionary;
@synthesize locationsBigAssDictionary           =   locationsBigAssDictionary;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"2980b9"]];
    
    // init custom search bar
    customSearchBar = [[RMNCustomSearchBar alloc] initWithFrame:CGRectMake(0,0, 220, 40)];
    [customSearchBar setDelegate:self];
    
    
    CLLocationCoordinate2D tempLoc = [RMNLocationController sharedInstance].locationManager.location.coordinate;
    
    // settings needed for autocomplete feature
    [customSearchBar setViewController:self];
    [customSearchBar setLocationCoordinate:tempLoc];
    
    self.navigationItem.titleView = customSearchBar;
    
    
    // start requesting for locations
    HPInformationsManager *manager;
    manager                        = [[HPInformationsManager alloc] init];
    manager.communicator           = [[HPCommunicator alloc] init];
    manager.communicator.delegate  = manager;
    manager.locationsDelegate      = self;
    [manager fetchLocations];



    
    isSearching = YES;
    
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
    


    
    
//    NSLog(@"CERE CU %f si %f",[RMNLocationController sharedInstance].locationManager.location.coordinate.latitude,
//          [RMNLocationController sharedInstance].locationManager.location.coordinate.longitude);
//    
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

    currentInfoLocation =   marker.userData;
    [self performSegueWithIdentifier:@"venueInformationPageSegue" sender:self];
    
    
}

- (UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
{
    UIView *customView;
    
    int contentWidth = 200;
    int contentHeight = 70;
    
    int rating;
    
    NSDictionary *info = marker.userData;
    rating = [[info objectForKey:@"smokingRatingAverage"] intValue];
    
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
    [ratingView updateWithRating:rating andCountRatings:0];
    
    customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, contentWidth + 20, contentHeight)];
    [customView setBackgroundColor:[UIColor whiteColor]];
    customView.layer.borderColor = [UIColor colorWithHexString:@"bab9b9"].CGColor;
    customView.layer.borderWidth = 1.0f;
    
    [customView addSubview:titleLabel];
    [customView addSubview:ratingView];
    
    return customView;
}


- (void)mapView:(GMSMapView *)mapView idleAtCameraPosition:(GMSCameraPosition *)position
{
    [HPMapMarker addMarkersToMap:mapView_
                        withInfo:customFilteredLocationsDictionary
          withSearchingActivated:isSearching];
}

#pragma mark - Google Maps delegate methods
- (void) mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position
{

    // resign the textfield from the search bar if moving the map
    [customSearchBar.searchBarView resignFirstResponder];
}

#pragma mark- JSON parser
- (void) didReceiveLocations:(NSArray *)groups
{
    
    // store the received information in an local array
    
    
    for (int i = 0; i< [groups count]; i++)
    {
        [[[RMNManager sharedManager]locationsBigAssDictionary] addObject:[groups objectAtIndex:i]];
    }
    
    locationsBigAssDictionary           =   groups;
    customFilteredLocationsDictionary   =   groups;
    [HPMapMarker addMarkersToMap:mapView_
                        withInfo:customFilteredLocationsDictionary
          withSearchingActivated:isSearching];
    
    [[RMNManager sharedManager] setLocationsArray:(NSArray *)customFilteredLocationsDictionary];
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


#pragma mark Autocomplete delegate method
- (void)userSearched:(NSString *)searchedString
{
    NSLog(@"Searching %@",searchedString);
    
    isSearching = YES;
    
    
    // if the search bar is empty or has white space
    // there's no need to search
    // just load the visible pins
    if ([searchedString isEqualToString:@" "] ||
        [searchedString length]==0)
    {
        isSearching = NO;
        
        customFilteredLocationsDictionary =  locationsBigAssDictionary;
        [HPMapMarker addMarkersToMap:mapView_
                            withInfo:customFilteredLocationsDictionary
              withSearchingActivated:isSearching];

        return;

    }
    // fetch the information containing the searched strings
    customFilteredLocationsDictionary = [RMNFiltersOperations search:searchedString
                                                             inArray:locationsBigAssDictionary];
    
    // refresh the map with new pins
    [HPMapMarker addMarkersToMap:mapView_
                        withInfo:customFilteredLocationsDictionary
          withSearchingActivated:isSearching];


}

@end
