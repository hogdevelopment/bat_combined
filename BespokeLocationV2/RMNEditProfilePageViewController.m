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


#import "HPInformationsManager.h"
#import "HPCommunicator.h"

static NSString *CellIdentifier = @"CellEditProfile";


@interface RMNEditProfilePageViewController ()  <RMNEditProfileCellDelegate,
                                                UIActionSheetDelegate,
                                                UIImagePickerControllerDelegate,
                                                UINavigationControllerDelegate,
                                                RMNCustomRequestsDelegate>
{
    int currentSection;
    BOOL isEditable;
    NSMutableArray  *sectionsTitles;
    NSArray         *placeHolders;
    
    int requestStatusCount;

}

@property (assign)int           currentSection;
@property NSMutableArray        *sectionsTitles;
@property NSArray               *placeHolders;
@property BOOL                  isEditable;
@property int                   requestStatusCount;
@end



@implementation RMNEditProfilePageViewController

@synthesize delegate            =   delegate;
@synthesize requestStatusCount  =   requestStatusCount;
@synthesize currentSection      =   currentSection;
@synthesize sectionsTitles      =   sectionsTitles;
@synthesize isEditable          =   isEditable;
@synthesize placeHolders        =   placeHolders;

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
    

    // update server stuff
    HPInformationsManager *manager;
    manager                        = [[HPInformationsManager alloc] init];
    manager.communicator           = [[HPCommunicator alloc] init];
    manager.communicator.delegate  = manager;
    manager.customRequestDelegate  = self;
    
    
    HPInformationsManager *managerPassword;
    managerPassword                        = [[HPInformationsManager alloc] init];
    managerPassword.communicator           = [[HPCommunicator alloc] init];
    managerPassword.communicator.delegate  = managerPassword;
    managerPassword.customRequestDelegate  = self;
    
    
//    sectionsTitles
    
    
    /// send server request with the username and password
    NSDictionary *requestInfo = @{@"userID"   : [[RMNManager sharedManager]userUniqueId],
                                  @"username" : [sectionsTitles objectAtIndex:1],
                                  @"password" : [sectionsTitles objectAtIndex:5],
                                  @"lastName" : @" ",
                                  @"firstName": [sectionsTitles objectAtIndex:0],
                                  @"email"    : [sectionsTitles objectAtIndex:4],
                                  @"gender"   : [sectionsTitles objectAtIndex:2] };
    
    [managerPassword fetchAnswerFor:RMNRequestUserChangePassword
                    withRequestData:requestInfo];
    
  
    [manager fetchAnswerFor:RMNRequestUserInfoUpdate
            withRequestData:requestInfo];
    
    
    [RMNUserInfo updateProfileDataWith:sectionsTitles];
    
    // tell the delegate that the user updated his profile info
    [self.delegate userUpdatedProfile];

    
}

#pragma mark - Custom Request delegate methods
- (void)didReceiveAnswer:(NSDictionary *)answer
{
    NSLog(@"a primit %@",answer);
    if ([[answer valueForKey:@"status"] isEqualToString:@"ok"])
    {
        NSLog(@"update ok");
        requestStatusCount ++;
        if (requestStatusCount == 2)
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    else
    {
        NSLog(@"EROARE ! CU RĂspunsul %@",[answer valueForKey:@"status"]);
    }
}
- (void)requestingFailedWithError:(NSError *)error
{
    NSLog(@"EROARE CU %@",error);
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    

    [self.profileHeaderLabel setText:NSLocalizedString(@"Profile", nil)];
    

    // load custom profile image
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];
    
    // update users name, date of registration and pic
    
    dispatch_async(kBgQueue, ^{
        
        // get the profile image
       UIImage *profileImage = [[RMNUserInfo profileImage]roundedImage];
        
        // get the users name
        NSString *userNameText = [[RMNManager sharedManager]userNameText];


         sectionsTitles = [NSMutableArray arrayWithArray:[RMNUserInfo profileData]];
        
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                     // set the profile image
                    [[self profileImageHolder]setImage:profileImage];
                    
                    
                    // set the users name
                    [self.userName setText:userNameText];
                    
                    
                    NSDate *registration = [sectionsTitles lastObject];
                  
                    NSString *joiningText = [NSString stringWithFormat:@"memeber since %@",[registration monthYearification]];
                    
                    
                    // set the joininig date
                    [self.usersJoiningDate setText:joiningText];
                    
                    // update the rest of the info from the table view
                    [self.tableView reloadData];
                    
                    
                    
                    
                    [self.activityIndicator setHidden:YES];
                    [self.activityIndicator stopAnimating];
                });

    });



    
   if (!IS_IPHONE_5)
   {
       CGRect frame     = self.tableView.frame;
       frame.origin.y   = 9;
       [self.tableView setFrame:frame];
   }

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
        cellText = [sectionsTitles objectAtIndex:indexPath.row];
        
        if ([cellText length]>0 && ![cellText isEqualToString:@" "])
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

    [cell configureExtraAccessory];
    
    if (indexPath.row == 5)
    {
        [cell.textFieldInput setSecureTextEntry:YES];
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
    return [placeHolders count];
}


#pragma mark - keyboard toolbar delegate methods
- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType
{
    int max = [sectionsTitles count]-2;
    
    switch (tagType) {
           

        case CGEnhancedKeyboardNextTag:
        {
            currentSection  = (currentSection == max) ? 0 : currentSection+1;
            break;
        }
        case CGEnhancedKeyboardPreviousTag:
        {
            currentSection  = (currentSection == 0) ? max : currentSection-1;
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

#pragma mark - interface builder methods
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
            
            [self.delegate userUpdatedProfile];

        });
    });

    [picker dismissViewControllerAnimated:YES completion:nil];
    
  
    

}
@end
