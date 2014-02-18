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
#import "RMNCustomNavButton.h"
#import "UserDataSingleton.h"

static NSString *CellIdentifier = @"CellEditProfile";


@interface RMNEditProfilePageViewController ()<RMNEditProfileCellDelegate>
{
    int currentSection;
    BOOL isEditable;
    NSArray  *sectionsTitles;

}

@property (assign)int   currentSection;
@property NSArray       *sectionsTitles;
@property BOOL isEditable;

@end



@implementation RMNEditProfilePageViewController

@synthesize currentSection  =   currentSection;
@synthesize sectionsTitles  =   sectionsTitles;
@synthesize isEditable      =   isEditable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupMenuBarButtonItems];
    
    
    
}
// setup custom left/right menu bar buttons
// to fit the design
- (void)setupMenuBarButtonItems
{
    self.navigationItem.rightBarButtonItem = [self rightMenuBarButtonItem];
    self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
   
    UIImage*leftyButton = [RMNCustomNavButton customNavButton:RMNCustomNavButtonBackward withTitle:@"Back"];

    UIBarButtonItem *lefty = [[UIBarButtonItem alloc]
                              initWithImage:leftyButton
                              style:UIBarButtonItemStyleBordered
                              target:self.navigationController
                              action:@selector(popViewControllerAnimated:)];
    
    
    return lefty;
}


- (UIBarButtonItem *)rightMenuBarButtonItem {
    
    UIImage*rightyButton = [RMNCustomNavButton customNavButton:RMNCustomNavButtonForward withTitle:@"Save"];
    
    UIBarButtonItem *righty = [[UIBarButtonItem alloc]
                              initWithImage:rightyButton
                              style:UIBarButtonItemStyleBordered
                              target:self
                              action:@selector(saveInformationAndDismissController)];
    
    
    return righty;
}

- (void)saveInformationAndDismissController
{
    
#warning Must save here information about the user in local database
    [self.navigationController popViewControllerAnimated:YES];
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

    
    sectionsTitles = @[@"Name",
                       @"UserName",
                       @"Gender",
                       @"Date of birth",
                       @"E-mail",
                       @"Password"];
    
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0);

     [self.tableView setScrollEnabled:NO];
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
    
    [cell setIndexPathSection:indexPath.row];
    [cell.textFieldInput setPlaceholder:[sectionsTitles objectAtIndex:indexPath.row]];
    [cell setKeyboardDelegate:self];
   
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 220;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sectionsTitles count];
}

- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType
{
    switch (tagType) {
           

        case CGEnhancedKeyboardNextTag:
        {
            currentSection  = (currentSection == [sectionsTitles count]-1) ? 0 : currentSection+1;
            break;
        }
        case CGEnhancedKeyboardPreviousTag:
        {
            currentSection  = (currentSection == 0) ? [sectionsTitles count]-1 : currentSection-1;
            break;
        }
        default:
            break;
    }
    
    [self userTouchedSection:currentSection];

}



- (void)userTouchedSection:(int)section
{

    [self.tableView setScrollEnabled:YES];
    
    currentSection = section;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                            atScrollPosition:UITableViewScrollPositionTop
                                    animated:NO];
    
//    NSLog(@"ESTE LA celula %d",section);
    RMNEditProfileCell * cell = (RMNEditProfileCell*)[self.tableView cellForRowAtIndexPath:indexPath];
   
    [cell.textFieldInput becomeFirstResponder];
    
   
}

- (void)animateToInitialState
{
    currentSection = 0;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:currentSection inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:YES];
    
    [self.tableView setScrollEnabled:NO];
}
@end
