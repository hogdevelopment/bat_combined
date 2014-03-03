//
//  RMNLoginViewController.m
//  BespokeLocationV2
//
//  Created by infodesign on 2/14/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNLoginViewController.h"
#import "UserDataSingleton.h"
#import "TSTCoreData.h"
#import "HPInformationsManager.h"
#import "HPCommunicator.h"

UserInformationKeyValues selectedService;

@interface RMNLoginViewController ()<RMNCustomRequestsDelegate>
{
     HPInformationsManager *manager;
}

@property  HPInformationsManager *manager;
@end

@implementation RMNLoginViewController

@synthesize manager =   manager;

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
    
    
    
    // set NSLocalizedString for all labels
    [self setLocalizedStringsForAllTexts];
    
    // hide password text when typing
    [self.passwordTF setSecureTextEntry:YES];
    
    [self.emailTF    setDelegate:self];
    [self.passwordTF setDelegate:self];
    
    selectedService = 0;
    
    if (!IS_IPHONE_5) {
        
        CGRect frameView = self.socialView.frame;
        frameView.origin.y -= 85;
        
        [self.socialView setFrame:frameView];
    }
    
    
   
    
    manager                        = [[HPInformationsManager alloc] init];
    manager.communicator           = [[HPCommunicator alloc] init];
    manager.communicator.delegate  = manager;
    manager.customRequestDelegate  = self;

    



    
}

- (void)viewWillAppear:(BOOL)animated
{
    
    // change navigation bar aspect
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"2980b9"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


# pragma Usefull methods

- (void) setLocalizedStringsForAllTexts
{
    // screen title
    [self.navigationItem setTitle:NSLocalizedString(@"Sign in",nil)];
    
    // labels
    self.titleAppLabel.text     = NSLocalizedString(@"Where to Smoke",nil);
    self.loginSocialLabel.text  = NSLocalizedString(@"or Login with",nil);

    
    // placeholders for textFields
    self.emailTF.placeholder      = NSLocalizedString(@"Email",nil);
    self.passwordTF.placeholder   = NSLocalizedString(@"Password",nil);

    
    // buttons title
    [self.loginButt      setTitle:NSLocalizedString(@"Login",nil) forState:UIControlStateNormal];
    [self.forgotPassButt setTitle:NSLocalizedString(@"Forgot Password?",nil) forState:UIControlStateNormal];

}


- (BOOL) checkIfLoginIsOk
{
    BOOL foundUser = NO;
    
    if ([self.emailTF.text isEqualToString:@""] && [self.passwordTF.text isEqualToString:@""])
    {
        // check in database user registered with social service
        foundUser = [TSTCoreData checkIfIsSavedInCoreDataUserWithUsername:[UserDataSingleton userSingleton].userName andIsRegisteredWithSocialService:selectedService];
    }
    else{
        // check in database user registered with password
        [UserDataSingleton userSingleton].email = self.emailTF.text;
        foundUser = [TSTCoreData checkIfIsSavedInCoreDataUserWithEmail:self.emailTF.text andPassword:self.passwordTF.text];
    }
    
    
    
    return foundUser;
}

- (void)didReceiveAnswer:(NSDictionary *)answer
{
    NSString *status = [answer valueForKey:@"status"];
    if ([status isEqualToString:@"ok"])
    {
        NSLog(@"Este pe server, și-l putem autentifica!");
        
        // must save users information
        
        
        NSString *ageVerification   = [answer valueForDeepKeyLinkingCustom:@"userData.ageVerification"];
        NSString *gender            = [answer valueForDeepKeyLinkingCustom:@"userData.gender"];
        NSString *firstName         = [answer valueForDeepKeyLinkingCustom:@"userData.first_name"];;
        NSString *lastName          = [answer valueForDeepKeyLinkingCustom:@"userData.last_name"];;
        NSString *userId            = [answer valueForDeepKeyLinkingCustom:@"user_id"];;
        
        NSDate *dateOfRegistration = [NSDate date];
        
        NSDictionary *userInfo = @{@"userAgeVerification" : ageVerification,
                                   @"userGender" : gender,
                                   @"userFirstName" : firstName,
                                   @"userLastName" : lastName,
                                   @"userId" : userId,
                                   @"userNameText" : self.emailTF.text,
                                   @"registrationDate" : dateOfRegistration};
        
        NSLog(@"info %@",userInfo);
        [RMNManager  updateUsersWith:userInfo];
        
        
        [[RMNManager sharedManager] setCurrentUserEmail:self.emailTF.text];
        [[RMNManager sharedManager] setUserNameText:self.emailTF.text];
        
        [[RMNManager sharedManager] setUsersJoiningDate:dateOfRegistration];
        [[RMNManager sharedManager] setUserAgeVerification:ageVerification];
        [[RMNManager sharedManager] setUserFirstName:firstName];
        [[RMNManager sharedManager] setUserGender:gender];
        [[RMNManager sharedManager] setUserLastName:lastName];
        [[RMNManager sharedManager] setUserUniqueId:userId];
        
        
        NSDictionary *infoUser = @{@"email"  : @" ",
                                   @"gender" : gender,
                                   @"firstName" : firstName,
                                   @"lastName" : lastName,
                                   @"username" : self.emailTF.text,
                                   @"password" : self.passwordTF.text,
                                   @"registrationDate" : dateOfRegistration,
                                   @"dateOfBirth" : dateOfRegistration};

        [TSTCoreData addInformation:infoUser ofType:TSTCoreDataUser];
        
        [self loadNextScreen];
    }
    else
    {
        // couldn't find user in database
        [self showMessageTitle:NSLocalizedString(@"Error",nil)
                   withMessage:NSLocalizedString(@"There is no user registered with this informations.",nil) ];
    }
}

- (void)requestingFailedWithError:(NSError *)error
{
    NSLog(@"error %@",error);
}
- (void) loadNextScreen
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"isLoggedIn"];
    
    // get the email
    NSString *theEmail = [TSTCoreData returnEmailForUserWithUsername:[UserDataSingleton userSingleton].userName andSocialService:selectedService];
    
    // save the current email to user defaults
    [defaults setObject:theEmail forKey:@"currentLoggedInUserEmail"];
    [defaults synchronize];
    
    [[RMNManager sharedManager] setIsLoggedIn:YES];
    [[RMNManager sharedManager] setCurrentUserEmail:theEmail];
    
    [self dismissViewControllerAnimated:YES completion:NO];
}


//This is used to show alert views
-(void)showMessageTitle: (NSString *) title withMessage:(NSString *) message
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:title message:message
                                                 delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    
}


#pragma mark - Login with social service
//when different providers selected gigya framework will access the providers account from device,
//if user is already signed in on the device or show sign in page.

-(void)loginWithProvider: (NSString *)provider
{
    if (![Gigya session])
    {
        [Gigya loginToProvider:provider parameters:Nil completionHandler:^(GSUser *user, NSError *error)
         {
             if (!error)
             {
                 [self getUserInfoToClass];
             }
             else
                 NSLog(@"Cancelled %@", error);
         }];
    }
    else
    {
        [self logoutFromSocialService];
        
        [self loginWithProvider:provider];
    }
    
}

- (void) logoutFromSocialService
{
    [Gigya logout];
    [Gigya setSession:Nil];
    [Gigya setSessionDelegate:nil];
}

#pragma mark - Getting user information
-(void)getUserInfoToClass
{
    GSRequest *request = [GSRequest requestForMethod:@"socialize.getUserInfo"];
    
    [request sendWithResponseHandler:^(GSResponse *response, NSError *error)
     {
         if (!error)
         {
             [UserDataSingleton userSingleton].userName   = response[ @"nickname"];
             [UserDataSingleton userSingleton].email      = response[ @"email"];

             NSLog(@"Hello, %@    %@", [UserDataSingleton userSingleton].email, [UserDataSingleton userSingleton].userName);
             
             self.emailTF.text      = @"";
             self.passwordTF.text   = @"";
             
            
             
             
             if (![self checkIfLoginIsOk])
             {
                 // couldn't find user in database
                 [self showMessageTitle:NSLocalizedString(@"Error",nil)
                            withMessage:NSLocalizedString(@"There is no user registered with this informations.",nil) ];
             }
             else{
                 // the login is ok.
                 [self loadNextScreen];
             }
         }
         else
         {
             NSLog(@"Error while trying to fetch user details");
         }
     }];
}




#pragma UIButtons methods

- (IBAction)loginAction:(id)sender {

    if ([self.emailTF text].length == 0 &&
        [self.passwordTF text].length == 0)
    {
        [self showMessageTitle:NSLocalizedString(@"Error",nil)
                   withMessage:NSLocalizedString(@"All fields are mandatory",nil) ];
        return;

    }

    
    /// send server request with the username and password
    NSDictionary *requestInfo = @{@"userID"   : @"1",
                                  @"username" : self.emailTF.text,
                                  @"password" : self.passwordTF.text,
                                  @"lastName" : @"ultimul",
                                  @"firstName": @"primul",
                                  @"email"    : @"chiosa0@gmail.com",
                                  @"gender"   : @"male"};
    
    [manager.communicator setRequestInfo:requestInfo];
    [manager fetchAnswerFor:RMNRequestUserLogin withRequestData:requestInfo];


}


- (IBAction)sendPasswordOnEmail:(id)sender {
    
    // check if account with the provided email is stored in database with a password
    
    NSString *password = [TSTCoreData findPasswordForUserRegisteredWithEmail:self.emailTF.text];
    
    if (password.length > 0) {

#warning This needs to be done!
        // here we have to send an email with the password found
        [self showMessageTitle:NSLocalizedString(@"Done",nil)
                   withMessage:NSLocalizedString(@"An email was sent to this address.",nil) ];
        
    }
    else{
        // couldn't find email in database
        [self showMessageTitle:NSLocalizedString(@"Error",nil)
                   withMessage:NSLocalizedString(@"There is no user registered with this email.",nil) ];
    }
    
}


- (IBAction)registerWithSocialService:(UIButton *)sender {
    
    NSString *providerName = @"";
    
    switch (sender.tag) {
        case 1:
            providerName = @"facebook";
            selectedService = UserIsUsingFacebook;
            break;
        case 2:
            providerName = @"twitter";
            selectedService = UserIsUsingTwitter;
            break;
        case 3:
            providerName = @"googleplus";
            selectedService = UserIsUsingGoogle;
            break;
        case 4:
            providerName = @"foursquare";
            selectedService = UserIsUsingFoursquare;
            break;
        default:
            break;
    }
    
    [self loginWithProvider:providerName];
}




#pragma mark - TextField Delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField.textColor isEqual:[UIColor redColor]])
        [textField setTextColor:[UIColor blackColor]];
    
    [textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
}

@end
