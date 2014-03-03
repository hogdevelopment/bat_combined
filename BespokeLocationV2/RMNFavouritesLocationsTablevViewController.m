//
//  RMNFavouritesLocationsTablevViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFavouritesLocationsTablevViewController.h"
#import "RMNFavouriteLocationView.h"
#import "CGEnhancedKeyboard.h"


@interface RMNFavouritesLocationsTablevViewController()<CGEnhancedKeyboardDelegate,UISearchBarDelegate,RMNFavouriteLocationDelegate>
{
    CGEnhancedKeyboard  *enhancedToolBar;
    UISearchBar         *navigationSearchBar;
    NSMutableArray      *favouritesLocations;
    NSMutableArray      *favouritesLocationsCoreData;
}

@property NSMutableArray *favouritesLocations;
@end

@implementation RMNFavouritesLocationsTablevViewController

@synthesize favouritesLocations =   favouritesLocations;

static NSString *CellIdentifier = @"Cell";


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupMenuBarButtonItems];
    
    self.navigationItem.title = NSLocalizedString(@"Favourites",nil);

    
    [self.navigationController.navigationBar setBarTintColor:SIDE_MENU_PAGES_NAVBAR_COLOR];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"RMNFavouriteLocationView"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:CellIdentifier];
    
    
    [self.tableView setBackgroundColor:[UIColor colorWithHexString:@"eceaea"]];
    
    [self loadContentInfo];
   
    
}

- (void)loadContentInfo
{
    
    favouritesLocations = [[NSMutableArray alloc]init];
    dispatch_async(kBgQueue, ^{
        
        favouritesLocationsCoreData = [RMNUserInfo fetchFavouriteLocations];
        
        //update table after the data is processed
        dispatch_async(dispatch_get_main_queue(), ^{
            
            favouritesLocations = favouritesLocationsCoreData;
            [self updateContent];
            
        });
        
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 184;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [favouritesLocations count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    RMNFavouriteLocationView *cell = (RMNFavouriteLocationView*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell populateWithInformationFrom:[favouritesLocations objectAtIndex:indexPath.section]];
    [cell setDelegate:self];
    [cell setIndexPathSection:indexPath.section];
    [cell makeItRound];
    return cell;
}


#pragma mark -- Custom navigation bar buttons
// setup custom left/right menu bar buttons
// to fit the design
- (void)setupMenuBarButtonItems
{
    self.navigationItem.rightBarButtonItem  =   [self rightMenuBarButtonItem];
    self.navigationItem.leftBarButtonItem   =   [self leftMenuBarButtonItem];
}

- (UIBarButtonItem *)leftMenuBarButtonItem
{
    
    UIImage*leftyButton = [RMNCustomNavButton customNavButton:RMNCustomNavButtonBackward withTitle:@"Back"];
    
    UIBarButtonItem *lefty = [[UIBarButtonItem alloc]
                              initWithImage:leftyButton
                              style:UIBarButtonItemStyleBordered
                              target:self.navigationController
                              action:@selector(popViewControllerAnimated:)];
    
    [lefty setTintColor:[UIColor whiteColor]];
    return lefty;
}


- (UIBarButtonItem *)rightMenuBarButtonItem {
    
    UIImage*rightyButton = [UIImage imageNamed:@"searchButtonMagnifier"];
    
    UIBarButtonItem *righty = [[UIBarButtonItem alloc]
                               initWithImage:rightyButton
                               style:UIBarButtonItemStyleBordered
                               target:self
                               action:@selector(searchFavouritesLocations)];
    
    [righty setTintColor:[UIColor whiteColor]];
    return righty;
}


#pragma mark CGEnhancedKeyboardTags  delegate
- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType
{
    // get the text field from the search bar and dismiss the keyboard
    UITextField *txfSearchField = [navigationSearchBar valueForKey:@"_searchField"];
    [txfSearchField resignFirstResponder];
    
    
    // if the text field is empty change the navigation bar button
    if ([txfSearchField.text length] == 0)
    {
        self.navigationItem.rightBarButtonItem  =   [self rightMenuBarButtonItem];
        self.navigationItem.title = NSLocalizedString(@"Favourites",nil);

    }
    
}


#pragma mark UISearchBar  delegate

- (void)searchFavouritesLocations
{
    // init the search bar
    navigationSearchBar = [[UISearchBar alloc]init];
    [navigationSearchBar setFrame:CGRectMake(0, 0, 200, 40)];
    [navigationSearchBar setDelegate:self];
    
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil]
     setTextColor:[UIColor colorWithHexString:@"616161"]];
    
    
    
    
    // prepare the toolbar for the keyboard
    enhancedToolBar = [[CGEnhancedKeyboard alloc]init];
    [enhancedToolBar setKeyboardToolbarDelegate:self];
    
    
    // get the textfield associated with the textfield
    UITextField *txfSearchField = [navigationSearchBar valueForKey:@"_searchField"];
    [txfSearchField setInputAccessoryView:[enhancedToolBar getDoneToolbarl]];
    [txfSearchField setBackgroundColor:[UIColor colorWithHexString:@"e9e9e9"]];

    // set the desired color
    [[txfSearchField inputAccessoryView] setTintColor:[UIColor whiteColor]];
    
    // bring the keyboard
    [txfSearchField becomeFirstResponder];
    
    // return the new bar button item with the search bar attached to it
    UIBarButtonItem *searchBarItem = [[UIBarButtonItem alloc] initWithCustomView:navigationSearchBar];
    self.navigationItem.rightBarButtonItem = searchBarItem;
    
    self.navigationItem.title = @"";

    
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    // if the user hasn't typed any character or
    // he deleted everything we must load
    // all the info back again
    if ([searchText length]==0)
    {
        [self reloadInfoAndDisplayIt];
    }
    // search info containing the searched text from
    // the searchbar
    else
    {
        [self searchForString:searchText];
    }
}

- (void) searchForString:(NSString*)stringToSearch
{
    
    
    // create new dispatch queue in background
    dispatch_queue_t queue = dispatch_queue_create("searchFavourites", NULL);
    
    // send initialization of UIActivityViewController in background
    dispatch_async(queue, ^{
        
        
#warning modify here to suit app best
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"(name CONTAINS[cd] %@) OR (localAddress CONTAINS[cd] %@)", stringToSearch,stringToSearch];
        
        NSArray *result         = [NSMutableArray arrayWithArray:
                                   [favouritesLocationsCoreData  filteredArrayUsingPredicate:filterPredicate]];

        favouritesLocations = [NSMutableArray arrayWithArray:result];

        
        // when UIActivityViewController is finally initialized,
        // hide indicator and present it on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });
    
}

#pragma mark - Private helpers
// use this to bring table view back to initial state
// with no searced text
- (void) reloadInfoAndDisplayIt
{
    [self loadContentInfo];
}



// this is called after loading locations from Core Data
// or any other content action related
- (void)updateContent
{
//    NSLog(@"FINISHED bg calculations with %@",favouritesLocations);
    [self.tableView reloadData];
}

#pragma mark- Favourite Location Cell Delegate
- (void)removeFavouriteLocationFromSection:(int)indexPathSection
{
    dispatch_async(kBgQueue, ^{
        
        NSString *key = @"foursquare_id";
        NSDictionary *deletedLocation =
        @{@"idKey"      : key,
          @"valueKey"   : [[favouritesLocations objectAtIndex:indexPathSection]
                           valueForKey:key]};
        
        [RMNUserInfo removeFavouriteLocation:deletedLocation];
        [favouritesLocations removeObjectAtIndex:indexPathSection];
        
        // update table view once the deletion is completed
        // from all sources
        dispatch_async(dispatch_get_main_queue(), ^{

#warning Maybe add animation for deletion of locations
            [self.tableView reloadData];
         
        });
        
    });
    
  
    
    
    
    
}

@end
