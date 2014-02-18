//
//  RMNFavouritesLocationsTablevViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFavouritesLocationsTablevViewController.h"
#import "RMNFavouriteLocationView.h"




@implementation RMNFavouritesLocationsTablevViewController

static NSString *CellIdentifier = @"Cell";


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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

    
    
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

//    RMNFavouriteLocationView *cell = (RMNFavouriteLocationView*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
//    
//    
    
    RMNFavouriteLocationView *cell = (RMNFavouriteLocationView*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    [cell makeItRound];
    return cell;
}


@end
