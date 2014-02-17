//
//  RMNUserSettingsSideMenuViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNUserSettingsSideMenuViewController.h"
#import "MFSideMenuContainerViewController.h"
#import "RMNUserSettingsSideMenuCell.h"
#import "ViewController.h"
#import "RMNUserPhotoNameView.h"

static  NSString *CellIdentifier            = @"CellReuseIdentifier";
static  NSString *HeaderCellIdentifier      = @"HeaderCellReuseIdentifier";


@interface RMNUserSettingsSideMenuViewController ()
{
    NSArray         *buttonsText;
    NSMutableArray  *imagesForCells;
    RMNSideMenuHeaderButtonsView *headerView;
}

@property (nonatomic, strong) NSArray           *buttonsText;
@property (nonatomic, strong) NSMutableArray    *imagesForCells;
@property (nonatomic, strong) RMNSideMenuHeaderButtonsView *headerView;
@end

@implementation RMNUserSettingsSideMenuViewController

@synthesize headerView          =   headerView;
@synthesize sideMenuDelegate    =   sideMenuDelegate;
@synthesize buttonsText         =   buttonsText;
@synthesize imagesForCells      =   imagesForCells;

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
    
    buttonsText     = @[ @"emptyBecauseTheFirstCellIsCustom",
                         NSLocalizedString(@"Settings",nil),
                         NSLocalizedString(@"Feedback",nil),
                         NSLocalizedString(@"Rate the app",nil),
                         NSLocalizedString(@"Share the app",nil),
                         NSLocalizedString(@"FAQs",nil),
                         NSLocalizedString(@"Privacy",nil),
                         NSLocalizedString(@"Logout",nil)];
    
    NSArray *imagesLocation;
    imagesForCells  =   [[NSMutableArray alloc]init];
    imagesLocation  = @[ @"emptyBecauseTheFirstCellIsCustom",
                         @"settingsAppIcon",
                         @"sendFeedbackIcon",
                         @"rateAppIcon",
                         @"shareAppIcon",
                         @"aboutAppIcon",
                         @"privacyIcon",
                         @"logoutAppIcon",
                         @"emptyBecauseTheFirstCellIsCustom"
                         ];
    
    // preload the images and cache them.
    for (int i = 0; i<[imagesLocation count]; i++)
    {
        UIImage *imageDummy = [UIImage imageNamed:[imagesLocation objectAtIndex:i]];
        [imagesForCells addObject:(imageDummy) ? imageDummy : @""];
        
    }
    
    
    // register za custom cell class
    [self.tableView registerClass:[RMNUserSettingsSideMenuCell class] forCellReuseIdentifier:CellIdentifier];
    
    // hide the default separator
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    [self.tableView setBackgroundColor:CELL_LIGHT_GRAY];
    
    
    headerView = [[[NSBundle mainBundle] loadNibNamed:@"RMNSideMenuHeaderView"
                                                           owner:self
                                                         options:nil]objectAtIndex:0];
    [headerView addInfo];
    [headerView setHeaderViewDelegate:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section %d", section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [buttonsText count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = (indexPath.row == 0) ? HeaderCellIdentifier : CellIdentifier;

    
    RMNUserSettingsSideMenuCell *cell = (RMNUserSettingsSideMenuCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        
        cell = [[RMNUserSettingsSideMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    
    
    if (indexPath.row == 0)
    {
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell addSubview:headerView];

    }
    else
    {
        cell.textLabel.text = [buttonsText objectAtIndex:indexPath.row];
        cell.imageViewHolder.image = [[imagesForCells objectAtIndex:indexPath.row]
                                      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Change the selected background view of the cell. since we will
    // load a different view controller
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // tell the side menu controller what row was touched
    [[self sideMenuDelegate] userDidTouchDown:indexPath.row];
    
    // since we're loading another view controller
    // the side menu must animate to its closed state
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   return  (indexPath.row == 0) ? 90 : SIDE_MENU_ROW_HEIGHT;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 130;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    

    RMNUserPhotoNameView *userHeaderView = [[[NSBundle mainBundle]
                                      loadNibNamed:@"RMNUserPhotoNameView"
                                            owner:self
                                        options:nil]objectAtIndex:0];
    
    [userHeaderView addPic:@"profile"];
    [userHeaderView addName:@"Chiosa Gabi"];
    

    return userHeaderView;
}


#pragma mark Header View Delegate
- (void)userTouched:(RMNSideMenuHeaderButtonType)buttonType
{
    [[self sideMenuDelegate]userDidTouchDown:buttonType + [imagesForCells count]-1];
    
    // since we're loading another view controller
    // the side menu must animate to its closed state
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
}


- (MFSideMenuContainerViewController *)menuContainerViewController {
    return (MFSideMenuContainerViewController *)self.parentViewController;
}


@end
