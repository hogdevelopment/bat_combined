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

#define NUMBER_OF_CELLS                 5

#define ROW_HEIGHT_CELL_IMAGE           200
#define ROW_HEIGHT_CELL_DETAILS         160
#define ROW_HEIGHT_CELL_RATING          80

static CGFloat row_height_cell_Attributes = 60;
static CGFloat row_height_cell_Description = 200;


static NSString *CellImageIdentifier            = @"ImageCellIdentifier";
static NSString *CellDetailsIdentifier          = @"DetailsCellIdentifier";
static NSString *CellAttributesIdentifier       = @"AttributesCellIdentifier";
static NSString *CellDescriptionIdentifier      = @"DescriptionCellIdentifier";
static NSString *CellRatingIdentifier           = @"RatingCellIdentifier";


NSArray *attributesArray;
NSString *descriptionString;

@interface RMNVenueInformationViewController ()

@end

@implementation RMNVenueInformationViewController

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
    
    attributesArray = [[NSArray alloc] initWithObjects:@"attributePlaceHolder", @"attributePlaceHolder", @"attributePlaceHolder", @"attributePlaceHolder", @"attributePlaceHolder", nil];
    
    //calculate height for attributes cell
    int nrOfRows = [attributesArray count]/4 + 1;
    
    if ([attributesArray count]%4 == 0) {
        nrOfRows -=1;
    }
    
    row_height_cell_Attributes = nrOfRows * 50;

    
    //calculate height for description cell
    descriptionString = NSLocalizedString(@"answerFAQs_0",nil);
    CGSize maximumLabelSize = CGSizeMake(310,9999);
    
    CGSize expectedLabelSize = [descriptionString sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]
                                      constrainedToSize:maximumLabelSize
                                          lineBreakMode:NSLineBreakByWordWrapping];
    
    //get the new height needed for label.
    CGFloat newHeight = expectedLabelSize.height;
    
    // calculate height for all the cell
    row_height_cell_Description = newHeight + 110;

    NSLog(@"calculated height for string is : %f", row_height_cell_Description);
    
    
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
    
    infoTable.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            return ROW_HEIGHT_CELL_DETAILS;
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
            
            [cell setImagesArray:[NSArray arrayWithObjects:
                                  @"http://static.comicvine.com/uploads/original/14/145849/2814973-robert_majkut_design_cinema_multikino_velvet_bar.jpg",
                                  @"http://activate.metroactive.com/files/2013/06/silicon-valley-bar-crawl-620x459.jpg",
                                  @"http://www.jeffkorhan.com/images/2012/05/2012.5.3-Crowded-Bar.jpg",
                                  nil]];
            
            break;
        case 1:
            cell = (RMNVenueInformationCell *)[tableView dequeueReusableCellWithIdentifier:CellDetailsIdentifier];
            
            cell.venueTitle.text = @"This is the name of the bar";
            cell.venueAddress.text = @"Str Mare, Nr 4, Bucuresti, Romania";
            [cell setOpeningTimes:@"L - V  10:00 to 02:00"];
            [cell setVenueSmokeRating:39];
            
            break;
        case 2:
            cell = (RMNVenueInformationCell *)[tableView dequeueReusableCellWithIdentifier:CellAttributesIdentifier];
            [cell setAttributesArray:attributesArray];
            
            break;
        case 3:
            cell = (RMNVenueInformationCell *)[tableView dequeueReusableCellWithIdentifier:CellDescriptionIdentifier];
            
            [cell setNewCalculatedHeight:row_height_cell_Description];
            cell.venueDescriptionTitle.text = @"Description";
            cell.venueDescriptionBody.text = descriptionString;
            [cell setPrice:10];

#warning must be able to tap on site
            cell.venueSite.text = @"www.google.com";
            
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



#pragma CellDelegate methods

- (void) userDidPressAddAttribute{
    
    [self performSegueWithIdentifier:@"attributesPageSegue" sender:self];
}


- (void) userDidPressAddRating:(CGFloat)rating{
    
    NSLog(@"your rating is %f", rating);
}

@end
