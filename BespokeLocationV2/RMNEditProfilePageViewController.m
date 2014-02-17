//
//  RMNEditProfilePageViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNEditProfilePageViewController.h"
#import "UIImage+Effects.h"
#import "NSDate+Stringifier.h"
#import <QuartzCore/QuartzCore.h>
#import "RMNEditProfileCell.h"

static NSString *CellIdentifier = @"CellEditProfile";


@interface RMNEditProfilePageViewController ()
{
}
@end

@implementation RMNEditProfilePageViewController

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
    
    NSLog(@"ajunge la did load din edit profile");
    
    // set the users name
    [[self userName]setText:[[RMNManager sharedManager]userNameText]];
    
    // add the image
    UIImage *profileImage = [[UIImage imageNamed:[[RMNManager sharedManager]profileImageLocation]] roundedImage];
    [[self profileImageHolder]setImage:profileImage];
    
    // set the joined date
    NSDate *joiningDate = [[RMNManager sharedManager]usersJoiningDate];
    NSString *joiningText = [NSString stringWithFormat:@"memeber since %@",[joiningDate monthYearification]];
    
    [self.usersJoiningDate setText:joiningText];

    // add rouned cornes to the table
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    
    // add the table view delegates
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    
    // register za custom cell class
    [self.tableView registerClass:[RMNEditProfileCell class] forCellReuseIdentifier:CellIdentifier];

    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    RMNEditProfileCell *cell = (RMNEditProfileCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[RMNEditProfileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textField setText:@"dummy"];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

@end
