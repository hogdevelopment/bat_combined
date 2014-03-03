//
//  RMNVenueInformationViewController.m
//  BespokeLocationV2
//
//  Created by infodesign on 2/20/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNVenueInformationViewController.h"
#import "RMNVenueInformationCell.h"
#import "RMNAttributesKeyViewController.h"
#import "RMNFoursquaredLocation.h"
#import "HPInformationsManager.h"
#import "HPCommunicator.h"
#import "RMNUserInfo.h"
#import "TSTCoreData.h"
#import "DirectionsViewController.h"

#define NUMBER_OF_CELLS                 5

#define ROW_HEIGHT_CELL_IMAGE           200
#define ROW_HEIGHT_CELL_RATING          80

static CGFloat row_height_cell_Details      = 160;
static CGFloat row_height_cell_Attributes   = 60;
static CGFloat row_height_cell_Description  = 200;

static NSString *CellImageIdentifier            = @"ImageCellIdentifier";
static NSString *CellDetailsIdentifier          = @"DetailsCellIdentifier";
static NSString *CellAttributesIdentifier       = @"AttributesCellIdentifier";
static NSString *CellDescriptionIdentifier      = @"DescriptionCellIdentifier";
static NSString *CellRatingIdentifier           = @"RatingCellIdentifier";


NSArray *attributesArray;
NSString *descriptionString;

@interface RMNVenueInformationViewController ()<RMNFoursquaredLocationFetcher,RMNFoursquareInterrogatorDelegate>
{
    NSDictionary *venueInfo;
    RMNFoursquaredLocation *foursquareLocation;
    
    NSArray *attributes;
    NSArray  *images;
    NSString *openingTime;
    NSString *price;
    NSString *phoneNumber;
    
    NSString *locationURL;
    
}

@property NSString  *locationURL;
@property NSArray   *attributes;
@property NSArray   *images;
@property NSString  *openingTime;
@property NSString  *price;
@property NSString  *phoneNumber;
@property NSString  *openTime;


@property RMNFoursquaredLocation *foursquareLocation;
@end


@implementation RMNVenueInformationViewController


@synthesize infoTable           =   infoTable;
@synthesize locationURL         =   locationURL;
@synthesize images              =   images;
@synthesize attributes          =   attributes;
@synthesize phoneNumber         =   phoneNumber;
@synthesize price               =   price;
@synthesize openingTime         =   openingTime;
@synthesize foursquareLocation  =   foursquareLocation;
@synthesize venueInfo           =   venueInfo;

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
    
    self.navigationItem.title       =   NSLocalizedString(@"Details",nil);
    UIBarButtonItem *anotherButton  =   [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"favouriteButton"]
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(favouriteButtonAction:)];
    
    self.navigationItem.rightBarButtonItem = anotherButton;
    
    
    
    // use this for custom requests for the server
    HPInformationsManager *locationManager;
    locationManager                        = [[HPInformationsManager alloc] init];
    locationManager.communicator           = [[HPCommunicator alloc] init];
    locationManager.communicator.delegate  = locationManager;
    locationManager.locationDetailDelegate = self;
    
    NSString *foursquareID = [venueInfo valueForKey:@"foursquare_id"];
    [locationManager fetchDetailedInfoForFoursquareID:foursquareID];
    
    
    descriptionString   =   NSLocalizedString(@"Loading description ...",nil);
    phoneNumber         =   NSLocalizedString(@"Loading phone number ...",nil);
    price               =   NSLocalizedString(@"Loading price ...",nil);
    openingTime         =   NSLocalizedString(@"Loading opening time ...",nil);
    locationURL         =   NSLocalizedString(@"Loading url ...",nil);
    
    attributesArray = @[];
    images = @[@""];

    
    // Calculate height for all cells
    [self calculateHeightForAllCells];
    
    // set up tableView
    infoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [infoTable setDelegate:self];
    [infoTable setDataSource:self];
    [infoTable setBackgroundColor:[UIColor whiteColor]];
    [infoTable setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    // register identifiers
    [infoTable registerClass:[RMNVenueInformationCell class] forCellReuseIdentifier:CellImageIdentifier];
    [infoTable registerClass:[RMNVenueInformationCell class] forCellReuseIdentifier:CellDetailsIdentifier];
    [infoTable registerClass:[RMNVenueInformationCell class] forCellReuseIdentifier:CellAttributesIdentifier];
    [infoTable registerClass:[RMNVenueInformationCell class] forCellReuseIdentifier:CellDescriptionIdentifier];
    [infoTable registerClass:[RMNVenueInformationCell class] forCellReuseIdentifier:CellRatingIdentifier];
    
    [self.view addSubview:infoTable];
    
    infoTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 60)];
    
    
    // arrange buttons
    
    self.callButt.layer.cornerRadius = 6.0;
    self.callButt.layer.borderColor = [UIColor grayColor].CGColor;
    self.callButt.layer.borderWidth = 2.0;
    [self.callButt setTitle:NSLocalizedString(@"Call",nil) forState:UIControlStateNormal];
    [self.callButt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    self.getThereButt.layer.cornerRadius = 6.0;
    self.getThereButt.layer.borderColor = [UIColor colorWithHexString:@"cf5117"].CGColor;
    self.getThereButt.layer.borderWidth = 2.0;
    [self.getThereButt setTitle:NSLocalizedString(@"Get there",nil) forState:UIControlStateNormal];
    [self.getThereButt setTitleColor:[UIColor colorWithHexString:@"cf5117"] forState:UIControlStateNormal];
    
    self.bgUnderButtons.layer.borderColor = [UIColor grayColor].CGColor;
    self.bgUnderButtons.layer.borderWidth = 1.0;
    
    [self.view bringSubviewToFront:self.bgUnderButtons];
    [self.view bringSubviewToFront:self.callButt];
    [self.view bringSubviewToFront:self.getThereButt];

    if (!IS_IPHONE_5) {
        
        CGRect frame = self.bgUnderButtons.frame;
        frame.origin.y -= 86;
        [self.bgUnderButtons setFrame:frame];
        
        frame = self.callButt.frame;
        frame.origin.y -=86;
        [self.callButt setFrame:frame];
        
        frame = self.getThereButt.frame;
        frame.origin.y -=86;
        [self.getThereButt setFrame:frame];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) calculateHeightForAllCells
{
    // details cell
    if ([foursquareLocation.openTime rangeOfString:@"null"].location != NSNotFound) {
        
        row_height_cell_Details = 107;
    }
    
    
    // height for attributes cell
    if ([attributes count] > 0) {
        
        int nrOfRows = [attributes count]/4 + 1;
        
        if ([attributes count]%4 == 0) {
            nrOfRows -=1;
        }
        
        row_height_cell_Attributes = nrOfRows * 50;
    }
    else{
        row_height_cell_Attributes = 0;
    }
    
//    NSLog(@"attributes  = %@", attributes);
    
    // height for description cell
    if (descriptionString.length > 0) {
        
        CGSize maximumLabelSize = CGSizeMake(310,9999);
        
        CGSize expectedLabelSize = [descriptionString sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]
                                                 constrainedToSize:maximumLabelSize
                                                     lineBreakMode:NSLineBreakByWordWrapping];
        
        //get the new height needed for label.
        CGFloat newHeight = expectedLabelSize.height;
        
        // calculate height for all the cell
        row_height_cell_Description = newHeight + 110;
    }
    else{
        row_height_cell_Description = 80;
    }
    
    if (price.length == 0) {
        row_height_cell_Description -= 40;
    }
    
    if (locationURL.length == 0) {
        row_height_cell_Description -= 40;
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return NUMBER_OF_CELLS;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
            return ROW_HEIGHT_CELL_IMAGE;
            break;
        case 1:
            return row_height_cell_Details;
            break;
        case 2:
            return row_height_cell_Attributes;
            break;
        case 3:
            return row_height_cell_Description;
            break;
        case 4:
            return ROW_HEIGHT_CELL_RATING;
            break;
        default:
            break;
    }
    
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMNVenueInformationCell *cell;
    
    switch (indexPath.row) {
        case 0:
            cell = (RMNVenueInformationCell *)[tableView dequeueReusableCellWithIdentifier:CellImageIdentifier];
            
            [cell setImagesArray:images];
            
            break;
        case 1:
            cell = (RMNVenueInformationCell *)[tableView dequeueReusableCellWithIdentifier:CellDetailsIdentifier];
            
            cell.venueTitle.text    = [venueInfo valueForKey:@"name"];
            cell.venueAddress.text  = [venueInfo valueForKey:@"localAddress"];
            [cell setOpeningTimes:openingTime];
            [cell setVenueSmokeRating:[[venueInfo valueForKey:@"smokingRatingTotal"]intValue]];
            
            break;
        case 2:
            cell = (RMNVenueInformationCell *)[tableView dequeueReusableCellWithIdentifier:CellAttributesIdentifier];
            [cell setAttributesArray:attributes];
            
            break;
        case 3:
            cell = (RMNVenueInformationCell *)[tableView dequeueReusableCellWithIdentifier:CellDescriptionIdentifier];
            
            [cell setNewCalculatedHeight:row_height_cell_Description];
            
            if (cell.venueDescriptionBody.text.length != 0) {
                cell.venueDescriptionTitle.text = @"Description";
                cell.venueDescriptionBody.text = descriptionString;
            }
            else{
                cell.venueDescriptionTitle.alpha = 0;
                cell.venueDescriptionBody.alpha = 0;
            }
            
            [cell setPrice:price.intValue];
            [cell setVenueURL:locationURL];
            
            break;
        case 4:
            cell = (RMNVenueInformationCell *)[tableView dequeueReusableCellWithIdentifier:CellRatingIdentifier];
            break;
        default:
            break;
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    [cell setCellDelegate:self];
    
    return cell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    //    if (section < 3)
    //    {
    //        CGRect frame = [self frame];
    //        PALAddPhotosSideMenuFooterView *footerView = [[PALAddPhotosSideMenuFooterView alloc]initWithFrame:frame];
    //        return footerView;
    //    }
    return nil;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // say hello with page selected to the
    // delegate
    
    
    
}

#pragma mark UIButtons action
- (void) favouriteButtonAction:(id)sender
{
    if ([TSTCoreData checkIfVenueIsAlreadySavedInFavouritesWithName:[venueInfo valueForKey:@"name"] andLocalAddress:[venueInfo valueForKey:@"localAddress"]]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Nil
                                                        message:NSLocalizedString(@"This venue has been added to your favourites",nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"Dismiss",nil) 
                                              otherButtonTitles:Nil, nil
                              ];
        [alert show];
        
    }
    else{
        NSLog(@"- saving venue to favourites");
        [RMNUserInfo saveLocationToFavourites:venueInfo];
    }

}

- (IBAction)callAction:(id)sender {
    
    NSString *telNumber = [NSString stringWithFormat:@"tel:%@", phoneNumber];
    
    NSLog(@"phone nr should be like tel:130-032-2837  and yours is: %@", telNumber);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:telNumber]];

}

- (IBAction)getThereAction:(id)sender {
 
}

#pragma CellDelegate methods

- (void) userDidPressAddAttribute{
    
    [self performSegueWithIdentifier:@"attributesPageSegue" sender:self];
}


- (void) userDidPressAddRating:(CGFloat)rating{
    
    NSLog(@"your rating is %f", rating);
}

- (void) userDidPressUploadPhoto{
    
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select source for profile photo:"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:
                            @"Take a new photo",
                            @"Load photo from Camera Roll",
                            nil];
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (void) userDidPressUOnSiteURL
{
    // navigate to locationURL
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:locationURL]];
}

#pragma mark - Foursquare request delegate methods
- (void)fetchingDetailsForLocationFailedWithError:(NSError *)error
{
    NSLog(@"Error receivein information from foursquare");
}

- (void)didReceiveDetailsForFourSquareLocation:(NSDictionary *)detailedInfo
{
    
    foursquareLocation = [[RMNFoursquaredLocation alloc]initFromSource:detailedInfo];
    [foursquareLocation setDelegate:self];
}


#pragma mark - Foursquared Location delegate methods
- (void)finishedWithInfo:(id)locationInfo
{
    
    //    descriptionString = foursquareLocation.;
    
    descriptionString   =   foursquareLocation.description;
    phoneNumber         =   foursquareLocation.phoneNumber;
    price               =   foursquareLocation.price;
    
    locationURL         =   foursquareLocation.locationUrl;
    openingTime         =   foursquareLocation.openTime;
    images              =   foursquareLocation.imagesArray;
    attributes          =   foursquareLocation.attributes;
    
    phoneNumber = [venueInfo objectForKey:@"contactPhone"];
    
    NSLog(@"phoneNumber ESTE %@",phoneNumber);

    if ([phoneNumber isEqualToString:@""]) {
        
        // hide call button
        self.callButt.hidden = YES;
        
        // move button to center
        CGRect frame = self.getThereButt.frame;
        frame.origin.x = (SCREEN_WIDTH - self.getThereButt.frame.size.width)/2;
        [self.getThereButt setFrame:frame];
    }
    
    [self calculateHeightForAllCells];
    
    [infoTable reloadData];
}



#pragma Mark -  UIActionSheet delegate methods

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    switch (buttonIndex) {
        case 0:
        {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
        case 1:
        {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        default:
            break;
    }
    
    [self presentViewController:picker animated:YES completion:nil];
    
}

#pragma Mark - UIImagePickerController delegate methods

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];;
    
    [activityIndicator setFrame:CGRectMake(0, 100, 320, 100)];
    [activityIndicator setHidden:NO];
    [activityIndicator startAnimating];
    
    // create new dispatch queue in background
    dispatch_queue_t queue = dispatch_queue_create("resizeImage", NULL);
    
    // send resizing of imge from picker controller in background
    dispatch_async(queue, ^{
        
# warning Do something with the image!
        
        UIImage *tempImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        tempImage = [[tempImage scaleToMaxSize:CGSizeMake(200, 200)]roundedImage];
        
        // when resizing finished,
        // hide indicator and present the image on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [activityIndicator setHidden:YES];
            [activityIndicator stopAnimating];
            
            NSLog(@"thank you for the photo.");
            
        });
    });
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}


@end


