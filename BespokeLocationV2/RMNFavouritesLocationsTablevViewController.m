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


@interface RMNFavouritesLocationsTablevViewController()<CGEnhancedKeyboardDelegate,UISearchBarDelegate>
{
    CGEnhancedKeyboard *enhancedToolBar;
    UISearchBar *navigationSearchBar;
}
@end

@implementation RMNFavouritesLocationsTablevViewController

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
    return 200;
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

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    UITextField *txfSearchField = [searchBar valueForKey:@"_searchField"];
    NSLog(@"za dude is searching for %@",[txfSearchField text]);
}

@end
