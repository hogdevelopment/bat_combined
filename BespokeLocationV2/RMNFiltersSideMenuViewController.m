//
//  RMNFiltersSideMenuViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 12/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFiltersSideMenuViewController.h"
#import "RMNFilterSideMenuCell.h"

static  NSString *CellIdentifier      = @"LocationsFinderCellIdentifier";


@interface RMNFiltersSideMenuViewController ()
{
    HPSearchBar *searchBar;
    
    NSMutableArray *locationsType;
}

@end




@implementation RMNFiltersSideMenuViewController

@synthesize searchBar                       =   searchBar;
@synthesize customFiltersSearchDelegate     =   customFiltersSearchDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization

    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // add za search bar for friends
    CGRect searchBarFrame = CGRectMake(0, 0, self.tableView.frame.size.width, 44.0);
    searchBar = [[HPSearchBar alloc] initWithFrame:searchBarFrame ofType:SearchLocations];
    [searchBar setSearchDelegate:self];

    
    
    self.tableView.allowsMultipleSelection = YES;

    // register za custom cell class
    [self.tableView registerClass:[RMNFilterSideMenuCell class] forCellReuseIdentifier:CellIdentifier];
    
    
    locationsType = [[NSMutableArray alloc]initWithObjects:
                     @"Locuri de pescuit",
                     @"Magazine de pescuit",
                     @"Ghizi pentru pescari",
                     @"Acostare barci",
                     @"Lansare barci",
                     @"Restaurante",
                     @"Pescuit la musca",
                     @"Salvati Dunarea si Delta",
                     @"Statii de alimentare barci",
                     @"Inchiriere barci",
                     @"Evenimente",
                     @"Hoteluri si pensiuni",
                     @"Distribuitori barci si motoare",
                     @"Cherhanale / Peste proaspat",
                     @"Recorduri personale",
                     @"Cluburi si asociatii",
                     @"Partide pescuit",
                     @"Locurile braconierilor",
                     nil];


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMNFilterSideMenuCell *cell = (RMNFilterSideMenuCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    // Configure the cell...
    if (indexPath.row < [locationsType count])
    {

        
        // apply za text and hope for za best
        [cell.textLabel  setText:[NSString stringWithFormat:@"Celula %d",indexPath.row]];
        
    }
    
    
    
    return cell;

}


- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc]init];
    [footerView setBackgroundColor:[UIColor colorWithHexString:@"01161b"]];
    return  footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return searchBar.frame.size.height+20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return searchBar;
}

#pragma search bar delegate methods
- (void) userHitSearchButton
{
    NSLog(@"AJUNGE IN SIDE MENU CA DELEGAT SI TRIMITE IN ALA MARE");
    //at this point the search button was touched
    // either the user selected types of locations
    // where to search, or not.
    [[self customFiltersSearchDelegate]mustSearchWithFilters];
}

@end
