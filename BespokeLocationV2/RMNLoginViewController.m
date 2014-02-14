//
//  RMNLoginViewController.m
//  BespokeLocationV2
//
//  Created by infodesign on 2/14/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNLoginViewController.h"
#import "UserDataSingleton.h"

@interface RMNLoginViewController ()
{
}

@end

@implementation RMNLoginViewController

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
    
    // change navigation bar aspect
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"2980b9"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // set NSLocalizedString for all labels
    [self setLocalizedStringsForAllTexts];
    
    // hide password text when typing
    [self.passwordTF setSecureTextEntry:YES];
    
    [self.emailTF    setDelegate:self];
    [self.passwordTF setDelegate:self];
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
    
    if ([self.emailTF.text isEqualToString:@""] && [self.passwordTF.text isEqualToString:@""]) {
        
        // check in database user registered with social service
        
        
    }
    else{
        // check in database user registered with password
    }
    
    
    return foundUser;
}


- (void) loadNextScreen
{
    
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
        NSLog(@"You are already signed in using %@",[Gigya session].lastLoginProvider);
    }
}



#pragma mark - Getting user information
-(void)getUserInfoToClass
{

    GSRequest *request=[GSRequest requestForMethod:@"socialize.getUserInfo"];
    
    [request sendWithResponseHandler:^(GSResponse *response, NSError *error)
     {
         if (!error)
         {
             [UserDataSingleton userSingleton].nickName   = response[ @"nickname"];
             
             NSLog(@"Hello, %@", [UserDataSingleton userSingleton].nickName);
             
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
    
    if ([self checkIfLoginIsOk]) {
        
        [self loadNextScreen];
    }
    else{
        
        self.passwordTF.text = @"";
        
        [self showMessageTitle:NSLocalizedString(@"Error",nil)
                   withMessage:NSLocalizedString(@"Email or password incorrect.",nil) ];
    }
}

- (IBAction)sendPasswordOnEmail:(id)sender {
    
    // check if email is in database
    BOOL foundEmail = NO;
    
    if (!foundEmail) {
        
        // couldn't find email in database
        [self showMessageTitle:NSLocalizedString(@"Error",nil)
                   withMessage:NSLocalizedString(@"There is no user registered with this email.",nil) ];
    }
    else{
        
        [self showMessageTitle:NSLocalizedString(@"Done",nil)
                   withMessage:NSLocalizedString(@"An email was sent to this address.",nil) ];
    }
    
}

- (IBAction)registerWithSocialService:(UIButton *)sender {
    
    NSString *providerName = @"";
    
    switch (sender.tag) {
        case 1:
            providerName = @"facebook";
            break;
        case 2:
            providerName = @"twitter";
            break;
        case 3:
            providerName = @"googleplus";
            break;
        case 4:
            providerName = @"foursquare";
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
