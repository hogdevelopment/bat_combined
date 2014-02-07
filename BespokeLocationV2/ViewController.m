//
//  ViewController.m
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 30/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "ViewController.h"
#import "SBJson.h"
#import "databaseItem.h"
#import "SecondView.h"
#import "DetailsViewController.h"
#import "DetailsTableViewViewController.h"
#import "AppDelegate.h"
#import "FourSquareResturant.h"
// TRAutoCompletes
#import "TRAutocompleteView.h"
#import "TRGoogleMapsAutocompleteItemsSource.h"
#import "TRTextFieldExtensions.h"
#import "TRGoogleMapsAutocompletionCellFactory.h"



@interface ViewController ()

@end

@implementation ViewController{
    
    CLLocationManager *locationManager;
    GMSMapView *mapView_;
    
    TRAutocompleteView *_autocompleteView;

}
@synthesize GetData,URL,jsonData,strData,LocationObjects,CurrentLocationlat,CurrentLocationlng,HUD,clctionDetials,pgviewDetails,SearchBar,MenuButton,CollectionDetails ;



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor whiteColor],NSForegroundColorAttributeName,
                                    [UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    
    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:209.0/255.0 green:82.0/255.0 blue:23.0/255.0 alpha:0.9]];

       //self.title = @"Map";

   
    MenuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [MenuButton setBackgroundImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
    MenuButton.frame= CGRectMake(0.0, 0.0, 40.0, 38.0);
    [MenuButton addTarget:self action:@selector(OpenDraw:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *menu = [[UIBarButtonItem alloc] initWithCustomView:MenuButton];
    self.navigationItem.leftBarButtonItem = menu;
    
    
    
     clctionDetials.backgroundColor =[UIColor grayColor];
   // pgviewDetails = [[UIPageControl alloc] initWithFrame:CGRectMake(141, 407, 37, 37)];
    
    // CollectionView
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    CollectionDetails = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 600, 700, 50) collectionViewLayout:layout];
    [CollectionDetails setDataSource:self];
    [CollectionDetails setDelegate:self];
    [CollectionDetails registerClass:[CollectionViewCe class] forCellWithReuseIdentifier:@"Cell"];
    [CollectionDetails setBackgroundColor:[UIColor grayColor]];
    
   // [pgviewDetails addSubview:CollectionDetails];
    [self.view addSubview:CollectionDetails];

    SearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0, 220, 40)];
    SearchBar.delegate = self;
    SearchBar.showsCancelButton = YES;
    SearchBar.placeholder = @"Search";
   /*UIView *searchBarView = [[UIView alloc] initWithFrame:[SearchBar bounds]];
    [searchBarView addSubview:SearchBar];
    self.navigationItem.titleView = searchBarView;*/
    // with this the cancel button is not showing
    self.navigationItem.titleView = SearchBar;
    
    
    
    
    //Location Manager checks for the user current location. this is IOS api
    if([CLLocationManager locationServicesEnabled])
    {
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters; // 100 m
        
        
        [locationManager startUpdatingLocation];
    }
    else
    {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Enable locatioin service" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    
    
    
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
	
}

-(void)LoadMap{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BOOL foursquare = appDelegate.FoursquareAPI;
    
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:CurrentLocationlat
                                                            longitude:CurrentLocationlng
                                                                 zoom:14];
    
    
   /* GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:51.511214
                                                            longitude:-0.119824
                                                                 zoom:15]; */
    
    mapView_ = [GMSMapView mapWithFrame:CGRectMake(0, 65, 320, 340) camera:camera];
    mapView_.myLocationEnabled = YES;
    //self.view = mapView_;
    [self.view addSubview:mapView_];
    
    mapView_.delegate = self;
    
    for (int i = 0; i< LocationObjects.count; i++) {
        
        if(foursquare == TRUE){
            
            FourSquareResturant *r = [LocationObjects objectAtIndex:i];
            GMSMarker *marker = [[GMSMarker alloc] init];
            marker.position = CLLocationCoordinate2DMake([r.latitude doubleValue],[r.longitude doubleValue]);
            marker.title = r.name;
            marker.snippet = r.localAddress;
            marker.userData = r;
            
            marker.map = mapView_;

        }
        else{
            
        databaseItem *r = [LocationObjects objectAtIndex:i];
        
            GMSMarker *marker = [[GMSMarker alloc] init];
            
            
            marker.position = CLLocationCoordinate2DMake([r.latitude doubleValue],[r.longitude doubleValue]);
            
            // NSLog(@"%.2f", marker.position.latitude);
            
            marker.title = r.name;
            marker.snippet = r.localAddress;
            marker.userData = r;
            
            marker.map = mapView_;
            
            // NSLog(@"lat = %.4f, lng = %.4f  title = %@ , snippet = %@", marker.position.latitude, marker.position.longitude, r.name,r.localAddress);

        }
        
    }
    
    [self StopActivity];
    
    // Creates a marker in the center of the map.
    /*GMSMarker *marker = [[GMSMarker alloc] init];
     marker.position = CLLocationCoordinate2DMake(-33.86, 151.20);
     marker.title = @"Sydney";
     marker.snippet = @"Australia";
     marker.map = mapView_;*/
    
    // Get the textField from the Searchbar
    // Now listen up.. the guy that wrote this googleplaces wrapper did not implement
    // the users current location. I have had to add that here. Check the updates I made in the
    
    CLLocationCoordinate2D mylocation;
    mylocation.latitude = CurrentLocationlat;
    mylocation.longitude = CurrentLocationlng;
    
                                                                       
    UITextField *txtSearchField = [SearchBar valueForKey:@"_searchField"];
    _autocompleteView = [TRAutocompleteView autocompleteViewBindedTo:txtSearchField usingSource:[[TRGoogleMapsAutocompleteItemsSource alloc]
                                                                                                 initWithMinimumCharactersToTrigger:1 apiKey:@"AIzaSyAMkoHHFPdaA3ocQmQtWm0LAaIze-V-NUk"
                                                                                                 location:mylocation] cellFactory:[[TRGoogleMapsAutocompletionCellFactory alloc]
                                                                                                                         initWithCellForegroundColor:[UIColor whiteColor]
                                                                                                                         fontSize:14]
                                                        presentingIn:self];
    
    _autocompleteView.topMargin = -5;
    _autocompleteView.backgroundColor = [UIColor colorWithRed:209.0/255.0 green:82.0/255.0 blue:23.0/255.0 alpha:0.9];
    
    _autocompleteView.didAutocompleteWith = ^(id<TRSuggestionItem> item)
    {
        NSLog(@"Autocompleted with: %@", item.completionText);
        
    };
    

    
}


-(void)GetDataFromDatabase{
    
  AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	 BOOL foursquare = appDelegate.FoursquareAPI;
    
    if(foursquare == TRUE){
        
        NSString *Location = [NSString stringWithFormat:@"%f,%f" , CurrentLocationlat,CurrentLocationlng ];
        
        URL = @"https://api.foursquare.com/v2/venues/explore?client_id=3JMQKES3RGKQC332IYOKEOM0X54VYR3WYPWB2V151VOHEP4H&client_secret=5RZFHTRJRBXRHMU5B0SA4EQSIWKPU3T0JBY0JFPYJU40100O&v=20130815&ll=";
        NSString *urlPlusLocation = [URL stringByAppendingString: Location];
        NSString *urlPlusIntent = [urlPlusLocation stringByAppendingString:@"&intent=browse"];
        //NSString *urlPlusLimit = [urlPlusIntent stringByAppendingString:@"&venuePhotos=1" ]; // This still returns photos created by the public not the venue
        
        NSString *urlPlusLimit = [urlPlusIntent stringByAppendingString:@"&limit=100" ];
        //NSString *urlPlusQuery = [urlPlusLocation stringByAppendingString:@"&query=" ];
        //NSString *UrlQueryAdd  = [urlPlusQuery stringByAppendingString:Query];
        
        //NSLog(@"%@",urlPlusIntent);
        
        NSURL *url = [NSURL URLWithString:urlPlusLimit];
        
        
        [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            
            if (error) {
                //[self.delegate fetchingGroupsFailedWithError:error];
                NSLog(@"there has been an error");
            } else {
                
                // NSError *error = nil;
                
                jsonData = data;

                SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
                
                strData = [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding];
                
                //NSLog(@"Spew out data %@", strData );
                
                NSDictionary *dictVenues = [jsonParser objectWithString:strData  error: nil];
                NSDictionary *items = [[[[dictVenues objectForKey: @"response"] objectForKey: @"groups"] objectAtIndex: 0] objectForKey: @"items"];
                
                //NSLog(@"Spew out data %@", items);
                
                LocationObjects = [[NSMutableArray alloc] init];
                
                
                for (NSDictionary *venue in items)
                {
                    
                    
                    NSString *Uid = [[venue objectForKey:@"venue"]objectForKey: @"id"];
                    NSString *name = [[venue objectForKey: @"venue"]objectForKey: @"name"];
                    NSString *ContactPhone = [[[venue objectForKey:@"venue"] objectForKey:@"contact"] objectForKey: @"phone"];
                    NSString *ContactTwitter = [[[venue objectForKey:@"venue"] objectForKey:@"contact"] objectForKey: @"twitter"];
                    NSString *LocationAddress = [[[venue objectForKey:@"venue"] objectForKey:@"location"] objectForKey: @"address"];
                    NSString *CrossStreet = [[[venue objectForKey:@"venue"] objectForKey:@"location"] objectForKey: @"crossStreet"];
                    
                    NSString *City = [[[venue objectForKey:@"venue"] objectForKey:@"location"] objectForKey: @"city"];
                    NSString *State = [[[venue objectForKey:@"venue"] objectForKey:@"location"] objectForKey: @"state"];
                    NSString *PostCode = [[[venue objectForKey:@"venue"] objectForKey:@"location"] objectForKey: @"postalCode"];
                    NSString *Country = [[[venue objectForKey:@"venue"] objectForKey:@"location"] objectForKey: @"country"];
                    
                    
                    NSString *latitude = [[[venue objectForKey: @"venue"] objectForKey: @"location"] objectForKey: @"lat"];
                    NSString *longitude = [[[venue objectForKey: @"venue"] objectForKey: @"location"] objectForKey: @"lng"];
                    NSString *Distance = [[[venue objectForKey: @"venue"] objectForKey: @"location"] objectForKey: @"distance"];
                    NSString *SiteURL = [[venue objectForKey:@"venue"]objectForKey: @"url"];
                    NSString *Hours = [[[venue objectForKey:@"venue"] objectForKey:@"hours"] objectForKey: @"status"];
                    NSString *Price = [[[venue objectForKey:@"venue"] objectForKey:@"price"] objectForKey: @"tier"];
                    NSString *Rating = [[venue objectForKey:@"venue"]objectForKey: @"rating"];
                    NSString *Description = [venue objectForKey:@"description"];
                    NSString *Flag = [[venue objectForKey:@"flags"]objectForKey: @"outsideRadius"];
                    // We could only get photo of the venue from users not under venue something has to be done about this if not, no photos
                    NSString *PhotoPrefix = [[[[venue objectForKey: @"venue"] objectForKey:@"photos"]objectForKey: @"group"]objectForKey: @"prefix"];
                    NSString *PhotoSuffix = [[[[venue objectForKey: @"venue"] objectForKey:@"photos"]objectForKey: @"group"]objectForKey: @"suffix"];
                    //NSString *PhotoPrefix = [[[[[venue objectForKey: @"tips"]  objectAtIndex:0] objectForKey:@"user"]objectForKey: @"photo"]objectForKey: @"prefix"];
                    //NSString *PhotoSuffix = [[[[[venue objectForKey: @"tips"]  objectAtIndex:0] objectForKey:@"user"]objectForKey: @"photo"]objectForKey: @"suffix"];
                    NSString *Categories = [[[[venue objectForKey:@"venue"]objectForKey: @"categories"] objectAtIndex:0] objectForKey:@"name"];
                    
                    //NSString *address = [[venue objectForKey: @"location"] objectForKey: @"address"];
                    
                    //CGFloat latitude = [[[venue objectForKey: @"location"] objectForKey: @"lat"] floatValue];
                    //CGFloat longitude = [[[venue objectForKey: @"location"] objectForKey: @"lng"] floatValue];
                    
                     FourSquareResturant *f = [[FourSquareResturant alloc] init];
                     f.uid = Uid;
                     f.name = name;
                     f.contactPhone = ContactPhone;
                     f.contactTwitter = ContactTwitter;
                     f.localAddress = LocationAddress;
                     f.crossStreet = CrossStreet;
                     f.city = City;
                     f.state =State ;
                     f.postCode = PostCode;
                     f.country = Country;
                     f.latitude = latitude;
                     f.longitude = longitude;
                     f.distance = Distance;
                     f.SiteURL = SiteURL;
                     f.Hours = Hours;
                     f.Price = Price;
                     f.Rating = Rating;
                     f.Description = Description;
                     if ([Flag isEqualToString:@"true"] ){
                     
                     f.Flag = true;
                     }
                     f.PhotoPrefix = PhotoPrefix;
                     f.PhotoSuffix = PhotoSuffix;
                     f.Categories = Categories;
                     
                     [LocationObjects addObject:f];
                    
                    
                    
                    //NSLog(@"Uid = %@ name = %@  ContactPhone = %@ ContactTwitter = %@, LocationAddress = %@", Uid,name,ContactPhone,ContactTwitter,LocationAddress);
                    //NSLog(@"City = %@ PostCode = %@  Country = %@ latitude = %@, longitude = %@", City,PostCode,Country,latitude,longitude);
                    //NSLog(@"Distance = %@ SiteURL = %@  Hours = %@ Price = %@, Rating = %@", Distance,SiteURL,Hours,Price,Rating);
                    
                }
                
                // Google Map muast be loaded from the UIThread
                if(![NSThread isMainThread])
                {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [self LoadMap];
                        
                    });
                }

                
            }
        }];
        
        

        
    }
    else{

    
    // For now we only have data for this location.
    // URl/get/lat/lng/How_many_records_do_you_want/start_from_record
    // or url can be
    // URl/all
    // to get all records
    
    
    
    URL =@"http://hwwmobileapp.cloudapp.net:3000/location/get/47.37/8.54/10/0";
    //URL =@"http://hwwmobileapp.cloudapp.net:3000/all";
    NSURL *url = [NSURL URLWithString:URL];
    
    
    [NSURLConnection sendAsynchronousRequest:[[NSURLRequest alloc] initWithURL:url] queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        if (error) {
            //[self.delegate fetchingGroupsFailedWithError:error];
            
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Cannot connect to server, try later" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            NSLog(@"there has been an error");
        } else {
            
            // NSError *error = nil;
            
            jsonData = data;
            
            
            //jsonArray = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
            //NSLog(@"Spew out data %@", jsonArray);
            //[self.delegate receivedGroupsJSON:data];
            
            SBJsonParser *jsonParser = [[SBJsonParser alloc] init];
            
            strData = [[NSString alloc] initWithData: jsonData encoding: NSUTF8StringEncoding];
            
            // NSLog(@"Spew out data %@", strData );
            
            NSDictionary *dicLocations = [jsonParser objectWithString:strData  error: nil];
            NSDictionary *items = [dicLocations objectForKey:@"data"];
            
            //NSLog(@"Spew out data %@", items);
            
            LocationObjects = [[NSMutableArray alloc] init];
            
            
            for (NSDictionary *venue in items)
            {
                
                
                databaseItem *f = [[databaseItem  alloc] init];
                
                // Ok here we go. I am counting the number of properities in the f object
                // So i can dynamically populate them
                /*unsigned int propertiesCount;
                 objc_property_t *classPropertiesArray = class_copyPropertyList([f class], &propertiesCount);
                 
                 
                 for(int i = 0; i < propertiesCount; i++){
                 
                 objc_property_t property = classPropertiesArray[i];
                 NSString *name = [[NSString alloc] initWithUTF8String:property_getName(property)];
                 NSString *attributesString = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
                 //NSLog(@"Property %@ attributes: %@", name, attributesString);
                 
                 [f setValue:[venue objectForKey:name] forKey:name];
                 
                 }
                 
                 free(classPropertiesArray); */
                
                //
                
                
                f.uid =[venue objectForKey:@"id"];
                f.name = [venue objectForKey: @"name"];
                f.contactPhone = [venue objectForKey: @"contactPhone"];
                f.contactTwitter = [venue objectForKey: @"contactTwitter"];
                f.localAddress = [venue objectForKey: @"localAddress"];
                f.crossStreet = [venue  objectForKey: @"crossStreet"];
                
                f.city = [venue objectForKey: @"city"];
                f.state = [venue objectForKey: @"state"];
                f.postCode = [venue objectForKey: @"postCode"];
                f.country = [venue objectForKey: @"country"];
                
                
                f.latitude = [venue objectForKey: @"latitude"];
                f.longitude = [venue objectForKey: @"longitude"];
                f.distance = [venue objectForKey: @"distance"];
                f.SiteURL = [venue objectForKey: @"SiteURL"];
                f.Hours = [venue objectForKey: @"Hours"];
                f.Price = [venue objectForKey: @"Price"];
                f.Rating = [venue objectForKey: @"Rating"];
                f.Description = [venue objectForKey:@"Description"];
                
                NSString *flag = [venue objectForKey: @"outsideradius"];
                
                if ([flag integerValue] == 1 ){
                    
                    f.outsideradius = true;
                }
                else{
                    
                    f.outsideradius = false;
                    
                }
                
                
                f.PhotoPrefix = [venue objectForKey:@"PhotoPrefix"];
                f.PhotoSuffix = [venue objectForKey:@"PhotoSuffix"];
                f.Categories = [venue  objectForKey:@"Categories"];
                f.smokingRatingTotal =[venue  objectForKey:@"smokingRatingTotal"];
                f.smokingRatingCount =[venue  objectForKey:@"smokingRatingCount"];
                
                
                
                
                
                
                [LocationObjects  addObject:f];
                
                
            }
            
            // Google Map muast be loaded from the UIThread
            if(![NSThread isMainThread])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [self LoadMap];
                    
                });
            }
            
            
            
            
        }
    }];
    
    }
}

/*-(void)toNextScreen:(id)sender{
 
 
 if(![NSThread isMainThread])
 {
 dispatch_async(dispatch_get_main_queue(), ^{
 SecondView *sv = [[SecondView  alloc] initWithStyle:UITableViewStyleGrouped];
 
 //sv.ObjectsToShow = ResturantsObjects;
 sv.Dump = strData;
 [self.navigationController pushViewController:sv animated:YES];
 });
 }
 
 
 
 
 
 }*/


- (void)viewWillAppear:(BOOL)animated {
    
    // Check if we need to start directing user
    
    
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    if (!error)
    {
        //[self LoadFromFourSquare];
        [self startActivity];
    }
    else if ([error code] ==1)
    {
        UIAlertView * alert=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Cannot connect..." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}


- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    // Our Current Location is updated there.
    // If we want to continous update then remove the if statement
    // Don't forget you may reach the max daily calls the foursquare api.
    if (CurrentLocationlat < .0001) {
        CLLocation *currentLocation = [locations lastObject];
        // TODO : make this from a defined variable
        CurrentLocationlat = currentLocation.coordinate.latitude;
        CurrentLocationlng = currentLocation.coordinate.longitude;
        [self GetDataFromDatabase];
    }
    
}


-(void) startActivity{
    
    if(!HUD){
        
        HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
        
    }
	[self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
    [HUD show:YES];
    
    
}

-(void) StopActivity{
    
    [HUD hide:TRUE];
}

- (BOOL) mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *) 	marker{
    
    
    
    return false;
}

- (void) mapView:(GMSMapView *)mapView didTapInfoWindowOfMarker:(GMSMarker *) 	marker{
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BOOL foursquare = appDelegate.FoursquareAPI;
    
    if(foursquare == TRUE){
        
        FourSquareResturant *dbaseItem = marker.userData;
        DetailsTableViewViewController *dv = [[DetailsTableViewViewController alloc] init];
        dv.ObjectoToshowFromFourSquare = dbaseItem;
        [self.navigationController pushViewController:dv animated:YES];

    }
    else {
    
    databaseItem *dbaseItem = marker.userData;
    
    
   // DetailsViewController *dv = [[DetailsViewController  alloc] initWithNibName:nil bundle:nil];
    
   // dv.ObjectsToShow = dbaseItem;
    
    DetailsTableViewViewController *dv = [[DetailsTableViewViewController alloc] init];
    dv.ObjectsToShow = dbaseItem;
    [self.navigationController pushViewController:dv animated:YES];
    
    }
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    CollectionViewCe *cell          = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.imgCollectionCell.image = [UIImage imageNamed:@"place_details"];
    
    
    return cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    return CGSizeMake(50, 50);
}



-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if([searchText isEqualToString:@""]){
        
        _autocompleteView.hidden = true;
        
        //UITextField *txtSearchField = [SearchBar valueForKey:@"_searchField"];
        [SearchBar  resignFirstResponder];
        
    }
    else {
        
        if (_autocompleteView.hidden == true){
            
            _autocompleteView.hidden = false;
            
        }
    }
    
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    
    return true;

}


- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    SearchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];

}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
   
    
}
- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    
     NSLog(@"Cancel");
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

-(void)OpenDraw:(id)sender{
    
    SecondView *SecondVC = [[SecondView alloc] init];
    
    
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs insertObject:SecondVC atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}


@end
