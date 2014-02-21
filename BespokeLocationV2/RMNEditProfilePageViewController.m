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


@interface RMNEditProfilePageViewController ()  <RMNEditProfileCellDelegate,
                                                UIActionSheetDelegate,
                                                UIImagePickerControllerDelegate,
                                                UINavigationControllerDelegate>
{
    int currentSection;
    BOOL isEditable;
    NSMutableArray  *sectionsTitles;
    NSArray         *placeHolders;

}

@property (assign)int           currentSection;
@property NSMutableArray        *sectionsTitles;
@property NSArray               *placeHolders;
@property BOOL                  isEditable;

@end



@implementation RMNEditProfilePageViewController

@synthesize currentSection  =   currentSection;
@synthesize sectionsTitles  =   sectionsTitles;
@synthesize isEditable      =   isEditable;
@synthesize placeHolders    =   placeHolders;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupMenuBarButtonItems];
    
    self.navigationItem.title = NSLocalizedString(@"Edit Profile",nil);

    [self.navigationController.navigationBar setBarTintColor:SIDE_MENU_PAGES_NAVBAR_COLOR];
    
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
    
    [lefty setTintColor:[UIColor whiteColor]];
    
    return lefty;
}


- (UIBarButtonItem *)rightMenuBarButtonItem {
    
    UIImage*rightyButton = [RMNCustomNavButton customNavButton:RMNCustomNavButtonForward withTitle:@"Save"];
    
    UIBarButtonItem *righty = [[UIBarButtonItem alloc]
                              initWithImage:rightyButton
                              style:UIBarButtonItemStyleBordered
                              target:self
                              action:@selector(saveInformationAndDismissController)];
    
    [righty setTintColor:[UIColor whiteColor]];
    
    return righty;
}

- (void)saveInformationAndDismissController
{
    
    [RMNUserInfo updateProfileDataWith:sectionsTitles];
#warning Must save here information about the user in local database
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    

    

    // load custom profile image
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
    dispatch_async(kBgQueue, ^{
        
        // get the profile image
       UIImage *profileImage = [[RMNUserInfo profileImage]roundedImage];
        
        // get the users name
        NSString *userNameText = [[RMNManager sharedManager]userNameText];
        
        
        // get the joined date
        NSDate *joiningDate = [[RMNManager sharedManager]usersJoiningDate];
        NSString *joiningText = [NSString stringWithFormat:@"memeber since %@",[joiningDate monthYearification]];
        

                dispatch_async(dispatch_get_main_queue(), ^{
                    
                     // set the profile image
                    [[self profileImageHolder]setImage:profileImage];
                    
                    
                    // set the users name
                    [self.userName setText:userNameText];
                    
                    // set the joininig date
                    [self.usersJoiningDate setText:joiningText];
                    
                    
                    [self.activityIndicator setHidden:YES];
                    [self.activityIndicator stopAnimating];
                });

    });



    dispatch_async(kBgQueue, ^{
   
        
        sectionsTitles = [NSMutableArray arrayWithArray:[RMNUserInfo profileData]];
        
        dispatch_async(dispatch_get_main_queue(), ^{

            [self.tableView reloadData];
        });
        
    });

    
    
   

    // add rouned cornes to the table
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    
    // add the table view delegates
    [self.tableView setDataSource:self];
    [self.tableView setDelegate:self];
    
    
    // register za custom cell class
    [self.tableView registerClass:[RMNEditProfileCell class] forCellReuseIdentifier:CellIdentifier];

    
    placeHolders    = @[@"Name",
                       @"UserName",
                       @"Gender",
                       @"Date of birth",
                       @"E-mail",
                       @"Password"];
    
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0);

    
    // disable the tables scrolling feature
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
    [cell.textFieldInput setPlaceholder:[placeHolders objectAtIndex:indexPath.row]];
    if (sectionsTitles)
    {
        NSString *cellText;
        cellText = (indexPath.row == 3) ? [[sectionsTitles objectAtIndex:indexPath.row]dayMonthYearification]:
                                            [sectionsTitles objectAtIndex:indexPath.row];
        
        if ([cellText length]>0)
        {
            [cell.textFieldInput setText:cellText];
        }
    }
    [cell setKeyboardDelegate:self];
   
    if (indexPath.row == 2 ||
        indexPath.row == 3)
    {
        [cell addPickerStuff];
    }
    
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


- (void)updateSection:(int)section
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:section inSection:0];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionTop
                                  animated:NO];
    
    //    NSLog(@"ESTE LA celula %d",section);
    RMNEditProfileCell * cell = (RMNEditProfileCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    [sectionsTitles replaceObjectAtIndex:section withObject:cell.textFieldInput.text];

}

- (IBAction)changePicture:(id)sender
{
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select source for profile photo:"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                         destructiveButtonTitle:nil
                                              otherButtonTitles:
                            @"Take a new photo",
                            @"Load photo from Camera Roll",
                            nil];
    [popup showInView:[UIApplication sharedApplication].keyWindow];
    
    

}

#pragma Mark -  UIActionSheet delegate methods

- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    
    switch (buttonIndex) {
            case 0:
            {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            }
            case 1:
            {
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            }
            default:
                break;
        }

    [self presentViewController:picker animated:YES completion:nil];

}

#pragma Mark - UIImagePickerController delegate methods

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];

}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
    // create new dispatch queue in background
    dispatch_queue_t queue = dispatch_queue_create("resizeImage", NULL);
    
    // send resizing of imge from picker controller in background
    dispatch_async(queue, ^{
     
        UIImage *tempImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        tempImage = [[tempImage scaleToMaxSize:CGSizeMake(200, 200)]roundedImage];
        
        
        [tempImage saveImageToPhone];
        // when resizing finished,
        // hide indicator and present the image on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
           
            [self.activityIndicator setHidden:YES];
            [self.activityIndicator stopAnimating];
            self.profileImageHolder.image = tempImage;
            
        });
    });

    [picker dismissViewControllerAnimated:YES completion:nil];
    
  
    

}
@end
