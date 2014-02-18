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

    
    sectionsTitles = @[@"Dummy info",
                       @"Tip locație",
                       @"Nume locație",
                       @"Descriere locație",
                       @"Județ",
                       @"Localitate"];
    
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
    [cell.textFieldInput setText:[sectionsTitles objectAtIndex:indexPath.row]];
    [cell setKeyboardDelegate:self];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 200;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [sectionsTitles count];
}

- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType
{
    switch (tagType) {
           
        case CGEnhancedKeyboardDoneTag:
        {
            [self.tableView reloadData];
        }
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
    
    NSLog(@"ESTE CU %d",currentSection);
    [self userTouchedSection:currentSection];

}

- (void)userTouchedSection:(int)section
{

    currentSection = section;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                            atScrollPosition:UITableViewScrollPositionTop
                                    animated:YES];
    

    RMNEditProfileCell * cell = (RMNEditProfileCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    [cell.textFieldInput becomeFirstResponder];
    
   
}

@end
