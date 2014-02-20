//
//  RMNEditFiltersViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 20/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNEditFiltersViewController.h"
#import "CGEnhancedKeyboard.h"
#import "RMNEditFilterTableViewCell.h"





@interface RMNEditFiltersViewController ()<CGEnhancedKeyboardDelegate,UISearchBarDelegate>
{
    CGEnhancedKeyboard *enhancedToolBar;
    UISearchBar *navigationSearchBar;
    NSMutableArray *filtersArray;
    
    BOOL isFromSearch;
    
    NSMutableArray *coreDataFiltersArray;
    
    
    NSArray *searchedFiltersArray;
}

@property NSMutableArray *filtersArray;

@property NSArray *coreDataFiltersArray;

@property NSArray *searchedFiltersArray;

@property BOOL isFromSearch;
@end

@implementation RMNEditFiltersViewController



@synthesize filtersArray    =   filtersArray;
@synthesize isFromSearch    =   isFromSearch;

@synthesize coreDataFiltersArray    =   coreDataFiltersArray;

@synthesize searchedFiltersArray    =   searchedFiltersArray;


static NSString *CellIdentifier = @"Cell";

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupMenuBarButtonItems];
    
    self.navigationItem.title = NSLocalizedString(@"Edit Filters",nil);
    
    
    [self.navigationController.navigationBar setBarTintColor:SIDE_MENU_PAGES_NAVBAR_COLOR];
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"RMNEditFilterTableViewCell"
                                               bundle:[NSBundle mainBundle]]
         forCellReuseIdentifier:CellIdentifier];
    
    
    [self.tableView setBackgroundColor:[UIColor colorWithHexString:@"eceaea"]];
    
    
#warning fake population
    
    filtersArray            = [[NSMutableArray alloc]init];
    coreDataFiltersArray    = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 100; i++)
    {
        NSDictionary *filters = @{
                                      @"kind"   : [NSString stringWithFormat:@"Filter_kind_%d",i],
                                      @"name"   : [NSString stringWithFormat:@"Filter_%d",i]
                                      };
        
        [coreDataFiltersArray addObject:filters];
    }
    
    filtersArray    =   [NSMutableArray arrayWithArray:coreDataFiltersArray];
    
    isFromSearch = NO;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 71;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    return [filtersArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RMNEditFilterTableViewCell *cell = (RMNEditFilterTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
#warning send the cell the info when we have all the informations
    NSDictionary *infoCell = [filtersArray objectAtIndex:indexPath.row];
    [cell.nameLabel setText:[infoCell valueForKey:@"name"]];
    [cell.kindLabel setText:[infoCell valueForKey:@"kind"]];

    
    return cell;
}



// Override to support conditional editing of the table view.
// This only needs to be implemented if you are going to be returning NO
// for some items. By default, all items are editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        
        [filtersArray removeObjectAtIndex:indexPath.row];
        
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                         withRowAnimation:UITableViewRowAnimationAutomatic];
        

    }
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
        self.navigationItem.title = NSLocalizedString(@"Edit Filters",nil);
        
        filtersArray = [NSMutableArray arrayWithArray:coreDataFiltersArray];
        [self.tableView reloadData];

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
    if ([searchText length]==0) return;
    [self searchForString:searchText];
}



- (void) searchForString:(NSString*)stringToSearch
{
    
    
    // create new dispatch queue in background
    dispatch_queue_t queue = dispatch_queue_create("searchFiltersActivity", NULL);
    
    // send initialization of UIActivityViewController in background
    dispatch_async(queue, ^{
      
        
#warning modify here to suit app best
        NSPredicate *filterPredicate = [NSPredicate predicateWithFormat:@"(name contains[cd] %@) OR (kind contains[cd] %@)", stringToSearch,stringToSearch];
        
        NSArray *result         = [NSMutableArray arrayWithArray:[coreDataFiltersArray  filteredArrayUsingPredicate:filterPredicate]];
        
        filtersArray = nil;
        filtersArray = [NSMutableArray arrayWithArray:result];
        
        
        
        
        // when UIActivityViewController is finally initialized,
        // hide indicator and present it on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    });

}
@end
