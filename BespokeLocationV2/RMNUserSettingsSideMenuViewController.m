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

static  NSString *CellIdentifier      = @"UserSettingsIdentifier";

@interface RMNUserSettingsSideMenuViewController ()
{
    NSArray         *buttonsText;
    NSMutableArray  *imagesForCells;
}

@property (nonatomic, strong) NSArray           *buttonsText;
@property (nonatomic, strong) NSMutableArray    *imagesForCells;

@end

@implementation RMNUserSettingsSideMenuViewController

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
    
    buttonsText     = @[ NSLocalizedString(@"Distance(units)",nil),
                         NSLocalizedString(@"Feedback",nil),
                         NSLocalizedString(@"Help Improve",nil),
                         NSLocalizedString(@"Rate the app",nil),
                         NSLocalizedString(@"Share the app",nil),
                         NSLocalizedString(@"About",nil),
                         NSLocalizedString(@"Privacy",nil),
                         NSLocalizedString(@"Terms Of Service",nil)];
    
    NSArray *imagesLocation;
    imagesForCells  =   [[NSMutableArray alloc]init];
    imagesLocation  = @[ @"settingsDummy",
                         @"settingsDummy",
                         @"settingsDummy",
                         @"settingsDummy",
                         @"settingsDummy",
                         @"settingsDummy",
                         @"settingsDummy",
                         @"settingsDummy"
                         ];
    
    // preload the images and cache them.
    for (int i = 0; i<[imagesLocation count]; i++)
    {
        UIImage *imageDummy = [UIImage imageNamed:[imagesLocation objectAtIndex:i]];
        [imagesForCells addObject:imageDummy];
        
    }
    
    
    // register za custom cell class
    [self.tableView registerClass:[RMNUserSettingsSideMenuCell class] forCellReuseIdentifier:CellIdentifier];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    RMNUserSettingsSideMenuCell *cell = (RMNUserSettingsSideMenuCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[RMNUserSettingsSideMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [buttonsText objectAtIndex:indexPath.row];
    [cell.imageViewHolder setImage:[imagesForCells objectAtIndex:indexPath.row]];
    
    
    
    return cell;
}

#pragma mark -
#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //    DemoViewController *demoViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DemoViewController"];
    //    demoViewController.title = [NSString stringWithFormat:@"Demo #%d-%d", indexPath.section, indexPath.row];
    //
    //    UINavigationController *navigationController = self.menuContainerViewController.centerViewController;
    //    NSArray *controllers = [NSArray arrayWithObject:demoViewController];
    //    navigationController.viewControllers = controllers;
    
    [[self sideMenuDelegate] userDidTouchDown:indexPath.row];
    
    
    [self.menuContainerViewController setMenuState:MFSideMenuStateClosed];
    
    
    
    //    ViewController *mainVC=[[ViewController alloc]init];
    //
    //    mainVC=[[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:NULL]
    //            instantiateViewControllerWithIdentifier:@"DemoViewController"];
    //
    //
    //    [mainVC performSegueWithIdentifier:@"testSegue" sender:mainVC];
    
    
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *tempView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 200)];
    [tempView setBackgroundColor:[UIColor greenColor]];
    return tempView;
}


- (MFSideMenuContainerViewController *)menuContainerViewController {
    return (MFSideMenuContainerViewController *)self.parentViewController;
}


@end
