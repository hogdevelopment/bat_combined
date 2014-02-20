//
//  ViewController.m
//  GigyaAuth
//
//  Created by shinoy on 1/20/14.
//  Copyright (c) 2014 shinoy. All rights reserved.
//

#import "LogInView.h"
#import "ViewController.h"
#import "UserDataSingleton.h"

#import "RMNUserInformationCoreData.h"
#import "RMNLoginViewController.h"
#import "TSTCoreData.h"

@interface LogInView ()
{
    BOOL isUsingSocialService;
    CGEnhancedKeyboard *enhancedKeyboard;
    int currentTFIndex;
    
    CGPoint pointOfOffset;
    
    UIDatePicker *datePicker;
    
    NSMutableArray *availableTFs;
}

@end

@implementation LogInView

//checks whether the user is already in or not. using Gigya session memory.

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // change navigation bar aspect
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"2980b9"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    // change color for gender segmented control
    [[UISegmentedControl appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]} forState:UIControlStateSelected];
    
    // change registration button design
    self.btnRegistrater.layer.cornerRadius = 4.0;
    self.btnRegistrater.layer.borderWidth = 1.0;
    self.btnRegistrater.layer.borderColor    = [UIColor orangeColor].CGColor;
    self.btnRegistrater.titleLabel.textColor = [UIColor orangeColor];
    
    // set NSLocalizedString for all labels
    [self setLocalizedStringsForAllTexts];

    // hide password text when typing
    [self.txtPassword setSecureTextEntry:YES];
    
    isUsingSocialService = NO;
    
    if(![UserDataSingleton userSingleton].usingGigya)
    {
        [self hideGigya];
    }
    
    [UserDataSingleton userSingleton].isRegisteredWithNewAccount = YES;
    
    [self.zaScrollView setDelegate:self];
    
    UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignTFs)];
    [self.imageViewBg setUserInteractionEnabled:YES];
    [self.imageViewBg addGestureRecognizer:tapG];
    
    
    // add custom keyboard to textFields
    enhancedKeyboard = [[CGEnhancedKeyboard alloc]init];
    [enhancedKeyboard setKeyboardToolbarDelegate:self];
    [enhancedKeyboard setNumberOfTextFields:4];
    
    
    // add custom picker view for date of birth
    datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    [datePicker addTarget:self action:@selector(datePickerValueChanged:)
         forControlEvents:UIControlEventValueChanged];
    
    NSDateComponents *componentsBegin = [[NSDateComponents alloc] init];
    [componentsBegin setDay:1];
    [componentsBegin setMonth:1];
    [componentsBegin setYear:1970];
    NSCalendar *gregorian = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *componentsMinimum = [[NSDateComponents alloc] init];
    [componentsMinimum setDay:1];
    [componentsMinimum setMonth:1];
    [componentsMinimum setYear:1900];
    NSCalendar *gregorianMinimum = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    
    [datePicker setDate:[gregorian dateFromComponents:componentsBegin]];
    datePicker.minimumDate = [gregorianMinimum dateFromComponents:componentsMinimum];
    datePicker.maximumDate = [NSDate date];
    
    
    [self.txtAge      setInputView:datePicker];
    [self.txtEmail    setInputAccessoryView:[enhancedKeyboard getExtendedToolbar]];
    [self.txtUsername setInputAccessoryView:[enhancedKeyboard getExtendedToolbar]];
    [self.txtAge      setInputAccessoryView:[enhancedKeyboard getExtendedToolbar]];
    [self.txtPassword setInputAccessoryView:[enhancedKeyboard getExtendedToolbar]];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    if (IS_IPHONE_5) {
        
        self.zaScrollView.scrollEnabled = NO;
        pointOfOffset = CGPointZero;
    }
    else{
        
        self.zaScrollView.scrollEnabled = YES;
        
        CGRect scrollFrame = self.zaScrollView.frame;
        scrollFrame.size.height = 480;
        scrollFrame.origin.y = 0;
        
        [self.zaScrollView setFrame:scrollFrame];
        
        [self.zaScrollView setContentSize:CGSizeMake(320, 490)];
        
        pointOfOffset = CGPointMake(0, -10);
    }
    
    availableTFs = [[NSMutableArray alloc] initWithObjects:self.txtEmail, self.txtUsername, self.txtAge, self.txtPassword, nil];
    currentTFIndex = 0;
    
    [self resetView];
    [self clearSession];
}

//if the user is already signed in using a provider then this page will redirect to the main page
//to set the main page check the nextView method

-(void)viewDidAppear:(BOOL)animated
{
    if ([[Gigya session] isValid])
    {
//        [self nextView];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}



#pragma mark - TextField Delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_txtAge            resignFirstResponder];
    [_txtEmail          resignFirstResponder];
    [_txtUsername       resignFirstResponder];
    [_txtPassword       resignFirstResponder];
    
    CGPoint offsetPoint = CGPointMake(0, -64);
    [self.zaScrollView setContentOffset:offsetPoint animated:YES];
    
    return NO;
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if([textField.textColor isEqual:[UIColor redColor]])
       [textField setTextColor:[UIColor blackColor]];
    
    [textField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    
    self.btnRegistrater.titleLabel.textColor = [UIColor orangeColor];
    
    currentTFIndex = [availableTFs indexOfObject:textField];
    
    if (textField == self.txtPassword) {
        
        if (IS_IPHONE_5) {
            [self.zaScrollView setContentOffset:CGPointZero animated:YES];
        }
        else{
            CGPoint offsetPoint = CGPointMake(0, 90);
            [self.zaScrollView setContentOffset:offsetPoint animated:YES];
        }
    }
    else{
        
        if (!IS_IPHONE_5) {
            
            if (textField == self.txtAge) {
                [self.zaScrollView setContentOffset:pointOfOffset animated:YES];
            }
            else{
                CGPoint offsetPoint = CGPointMake(0, -64);
                [self.zaScrollView setContentOffset:offsetPoint animated:YES];
            }
        }
        else{
            CGPoint offsetPoint = CGPointMake(0, -64);
            [self.zaScrollView setContentOffset:offsetPoint animated:YES];
        }
    }
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField
{

}


#pragma CGEnhancedKeyboard delegate method

- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType
{
    UITextField *nowTF = (UITextField *)[availableTFs objectAtIndex:currentTFIndex];
    
    switch (tagType) {
            
        case CGEnhancedKeyboardPreviousTag:
            
            if ( currentTFIndex > 0) {
                
                currentTFIndex --;
                nowTF = (UITextField *)[availableTFs objectAtIndex:currentTFIndex];
                [nowTF becomeFirstResponder];
            }
            
            break;
            
        case CGEnhancedKeyboardNextTag:
            
            if ( currentTFIndex < [availableTFs count]-1) {
                
                currentTFIndex ++;
                nowTF = (UITextField *)[availableTFs objectAtIndex:currentTFIndex];
                [nowTF becomeFirstResponder];
            }
            
            break;
            
        case CGEnhancedKeyboardDoneTag:
            
            [self resignTFs];
            
            CGPoint offsetPoint = CGPointMake(0, -64);
            [self.zaScrollView setContentOffset:offsetPoint animated:YES];
            
            break;
        default:
            break;
    }
    
}


#pragma  UIDatePickerView method

- (void)datePickerValueChanged:(UIDatePicker*) datePickerView{
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    df.dateStyle = NSDateFormatterMediumStyle;

    [self.txtAge setText: [df stringFromDate:datePickerView.date]];
}


//This method is used to fetch the user info. and store it in userInfo class
//if details cannot fetch from provider then registration page will fill with the values got from
//provider and use those details for registration

#pragma mark - Getting user information


-(void)getUserInfoToClass
{
    isUsingSocialService = YES;
    
    GSRequest *request=[GSRequest requestForMethod:@"socialize.getUserInfo"];
    
    [request sendWithResponseHandler:^(GSResponse *response, NSError *error)
     {
         if (!error)
         {
             
             [UserDataSingleton userSingleton].isRegisteredWithNewAccount = NO;
             
             [UserDataSingleton userSingleton].userName   = response[ @"nickname"];
             [UserDataSingleton userSingleton].gender     = response[   @"gender"];
             [UserDataSingleton userSingleton].email      = response[    @"email"];
             [UserDataSingleton userSingleton].age        = Nil;
             [UserDataSingleton userSingleton].photoUrl   = response[@"thumbnailURL"];

//             NSLog(@"photoURL = %@", response[@"photoURL"] );
//             NSLog(@"thumbnailURL = %@", response[@"thumbnailURL"] );

             availableTFs = [[NSMutableArray alloc] initWithObjects:self.txtEmail, self.txtUsername, self.txtAge, self.txtPassword, nil];
             
             [self fillRegistration];
             
             self.txtPassword.enabled = NO;
             self.txtPassword.placeholder = @"Not needed";

             if (![self checkIfRegistrationIsOk])
             {
                 // didn't recieve all the info wanted
                 [self showMessageTitle:NSLocalizedString(@"Error",nil)
                            withMessage:NSLocalizedString(@"We are unable to access some of your details. Please fill in the rest of the fields.",nil) ];
                 
                 [self clearSession    ];
             }
             else{
                 // the provider gave all the information needed.
                 [self nextView];
             }
           }
         else
         {
             NSLog(@"Error while trying to fetch user details");
         }
         
     }];

}


// this will show a table of with three choices facebook, linkedin, foursquare and googleplus.
// user can select one provider. if wanto add other social networking sites just add to "providers" array
// this will redirect to a webpage from there user can login.
// gigya will keep a session memory this can be used to later to login

#pragma mark - Two different way to access user info

-(void)selectFromProviders
{
    if (![Gigya session])
    {
        NSArray *providers = @[ @"facebook",@"googleplus", @"linkedin", @"foursquare", @"twitter"];
    
        [Gigya showLoginProvidersDialogOver:self providers:providers parameters:Nil
                          completionHandler:^(GSUser *user, NSError *error)
         {
             if (!error)
             {
                 //[self getUserInfo];
                 [self getUserInfoToClass];
             }
             else
             {
                 NSLog(@"Cancelled by User");
             }
         }];
    }
    else
    {
        [self showMessageTitle:nil withMessage:[NSString stringWithFormat:
              @"You are already signed in using %@",[Gigya session].lastLoginProvider]];
    }
}


//when different providers selected gigya framework will access the providers account from device,
//if user is already signed in on the device or show sign in page.

-(void)fromSelectedProvider: (NSString *)provider
{
    
    if (![Gigya session])
    {
        [Gigya loginToProvider:provider parameters:Nil completionHandler:^(GSUser *user, NSError *error)
         {
             if (!error)
             {
                // [self getUserInfo];
                 [self getUserInfoToClass];
            }
             else
                 NSLog(@"Cancelled %@", error);
         }];
    }
    else
    {
        [self showMessageTitle:@"" withMessage:[NSString stringWithFormat:
                               @"You are already signed in using %@",[Gigya session].lastLoginProvider]];
    }
}


//this function is used to fill the details into registration,
//if the data fetched from different providers are not enough.
//the details copied into the dictionary is copied fields and at the end dictionary is cleared

#pragma mark- Registration form autofill and reset

-(void)fillRegistration
{
    [self resetView];
    
        if ([UserDataSingleton userSingleton].userName)
        {
            _txtUsername.textColor          = [UIColor blackColor];
            _txtUsername.text               = [UserDataSingleton userSingleton].userName;
            _txtUsername.enabled = NO;
            [availableTFs removeObject:self.txtUsername];
        }
    
    
        if([UserDataSingleton userSingleton].age)
        {
            _txtAge.textColor           = [UIColor blackColor];
            _txtAge.text                = [UserDataSingleton userSingleton].age;
            _txtAge.enabled = NO;
            [availableTFs removeObject:self.txtAge];
        }
    
    
        if ([UserDataSingleton userSingleton].email.length > 0)
        {   _txtEmail.textColor         = [UIColor blackColor];
            _txtEmail.text              = [UserDataSingleton userSingleton].email;
            _txtEmail.enabled = NO;
            [availableTFs removeObject:self.txtEmail];
        }
    
        [availableTFs removeObject:self.txtPassword];

        if ([UserDataSingleton userSingleton].gender)
        {
            if ([[UserDataSingleton userSingleton].gender caseInsensitiveCompare:@"female"] == NSOrderedSame ||
                [[UserDataSingleton userSingleton].gender caseInsensitiveCompare:@"f"]      == NSOrderedSame)
            {
                [self.genderSgmCtrl setSelectedSegmentIndex:1];
            }
        }
}


// resetting views with default value
-(void)resetView
{
    _txtUsername.text           = @"";
    _txtEmail.text              = @"";
    _txtPassword.text           = @"";
    _txtAge.text                = @"";
    
}



#pragma mark - UIButtons actions

- (IBAction)changeBorderColor:(id)sender {
    
    self.btnRegistrater.titleLabel.textColor = [UIColor whiteColor];
    [self.btnRegistrater setBackgroundColor:[UIColor orangeColor]];
}

- (IBAction)changeColorToWhite:(id)sender {
    
    self.btnRegistrater.titleLabel.textColor = [UIColor orangeColor];
    [self.btnRegistrater setBackgroundColor:[UIColor whiteColor]];
}

- (IBAction)signUpAction:(id)sender {

    [_txtAge            resignFirstResponder];
    [_txtEmail          resignFirstResponder];
    [_txtUsername       resignFirstResponder];
    [_txtPassword       resignFirstResponder];
    
    if ([self checkIfRegistrationIsOk]) {

        // save user info
        [UserDataSingleton userSingleton].userName    = _txtUsername.text;
        [UserDataSingleton userSingleton].gender      = _genderSgmCtrl.selectedSegmentIndex == 0 ? @"male" : @"female";
        [UserDataSingleton userSingleton].email       = _txtEmail.text;
        [UserDataSingleton userSingleton].age         = _txtAge.text;
        
        if ([UserDataSingleton userSingleton].isRegisteredWithNewAccount) {
            
            [UserDataSingleton userSingleton].password = _txtPassword.text;
        }
        
        //[self showMessageTitle:@"Succes" withMessage:@"Registration successful"];
        [self nextView];
        // code here to persist data in userInfo dictionary and push to next page
        // [self nextView] can be used to push to next page.
    }
    else{
        
        self.btnRegistrater.titleLabel.textColor = [UIColor orangeColor];
        [self.btnRegistrater setBackgroundColor:[UIColor whiteColor]];
        
    }
}




// sign up with social services

-(IBAction)loginWithFacebook:(id)sender;
{
    [self fromSelectedProvider:@"facebook"];
    
    [UserDataSingleton userSingleton].isUsingFacebook   = YES;
    [UserDataSingleton userSingleton].isUsingFoursquare = NO;
    [UserDataSingleton userSingleton].isUsingGoogle     = NO;
    [UserDataSingleton userSingleton].isUsingTwitter    = NO;

}

-(IBAction)loginWithGoogleplus:(id)sender
{
    [self fromSelectedProvider:@"googleplus"];
    
    [UserDataSingleton userSingleton].isUsingFacebook   = NO;
    [UserDataSingleton userSingleton].isUsingFoursquare = NO;
    [UserDataSingleton userSingleton].isUsingGoogle     = YES;
    [UserDataSingleton userSingleton].isUsingTwitter    = NO;
}

-(IBAction)loginWithLinkedin:(id)sender
{
    [self fromSelectedProvider:@"linkedin"];
}

- (IBAction)loginWithTwitter:(id)sender
{
    [self fromSelectedProvider:@"twitter"];
    
    [UserDataSingleton userSingleton].isUsingFacebook   = NO;
    [UserDataSingleton userSingleton].isUsingFoursquare = NO;
    [UserDataSingleton userSingleton].isUsingGoogle     = NO;
    [UserDataSingleton userSingleton].isUsingTwitter    = YES;
}

- (IBAction)loginWithFoursquare:(id)sender
{
    [self fromSelectedProvider:@"foursquare"];
    
    [UserDataSingleton userSingleton].isUsingFacebook   = NO;
    [UserDataSingleton userSingleton].isUsingFoursquare = YES;
    [UserDataSingleton userSingleton].isUsingGoogle     = NO;
    [UserDataSingleton userSingleton].isUsingTwitter    = NO;
}



#pragma mark- Other useful methods


- (void) setLocalizedStringsForAllTexts
{
    // screen title
    [self.navigationItem setTitle:NSLocalizedString(@"Sign up",nil)];

    // labels
    self.titleForGetStareted.text   = NSLocalizedString(@"Get started",nil);
    self.subTitle.text              = NSLocalizedString(@"subtitle text",nil);
    self.emailLabel.text            = NSLocalizedString(@"Email",nil);
    self.usernameLabel.text         = NSLocalizedString(@"Username",nil);
    self.birthLabel.text            = NSLocalizedString(@"Date of birth",nil);
    self.genderLabel.text           = NSLocalizedString(@"Gender",nil);
    self.passLabel.text             = NSLocalizedString(@"Password",nil);
    self.serviceSignLabel.text      = NSLocalizedString(@"or sign up with",nil);

    
    // placeholders for textFields
    self.txtEmail.placeholder      = NSLocalizedString(@"Email",nil);
    self.txtUsername.placeholder   = NSLocalizedString(@"Username",nil);
    self.txtAge.placeholder        = NSLocalizedString(@"Date of birth",nil);
    self.txtPassword.placeholder   = NSLocalizedString(@"Password",nil);
    
    // gender segmented control
    [self.genderSgmCtrl setTitle:NSLocalizedString(@"Male",nil) forSegmentAtIndex:1];
    [self.genderSgmCtrl setTitle:NSLocalizedString(@"Female",nil) forSegmentAtIndex:1];

    // button title
    [self.btnRegistrater setTitle:NSLocalizedString(@"Sign up",nil) forState:UIControlStateNormal];
}


// when sign up button is pressed this method will check if text fields are properly filled or not
// if any field is not completed then it will turn red
- (BOOL) checkIfRegistrationIsOk
{
    BOOL isOk = YES;
    BOOL alreadyShownAlert = NO;
    
    
    if ([_txtUsername.text isEqualToString:@""]    || [_txtEmail.text isEqualToString:@""]   ||
        [_txtAge.text isEqualToString:@""] )
    {
        if (!isUsingSocialService) {
            [self showMessageTitle:NSLocalizedString(@"Error",nil) withMessage:NSLocalizedString(@"All fields should be entered",nil)];
            alreadyShownAlert = YES;
        }
        
        isOk = NO;
        
        if([_txtAge.text   isEqualToString: @"" ])
        {
            [_txtAge becomeFirstResponder];
            [_txtAge setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
        else{
            self.birthOkMark.alpha = 1;
        }
        
        if([_txtUsername.text isEqualToString: @"" ])
        {
            [_txtUsername becomeFirstResponder];
            [_txtUsername setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
        else{
            self.usernameOkMark.alpha = 1;
        }
        
        if([_txtEmail.text isEqualToString: @"" ])
        {
            [_txtEmail becomeFirstResponder];
            [_txtEmail setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
        }
        else{
            self.emailOkMark.alpha = 1;
        }
    }
    else if (![self validateEmail:_txtEmail.text])
    {
        [self showMessageTitle:NSLocalizedString(@"Error",nil) withMessage:NSLocalizedString(@"Please enter a valid email address",nil)];
        [_txtEmail setTextColor:[UIColor redColor]];
        isOk = NO;
        self.emailOkMark.alpha = 0;
    }
    
    if (isUsingSocialService) {
        
//        [availableTFs removeObject:self.txtPassword];
    }
    else
        if ([_txtPassword.text isEqualToString:@""]) {
            
            isOk = NO;
            
            [_txtPassword becomeFirstResponder];
            [_txtPassword setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
            
            if (!alreadyShownAlert) {
                [self showMessageTitle:NSLocalizedString(@"Error",nil) withMessage:NSLocalizedString(@"All fields should be entered",nil)];
            }
        }
        else
        {
            self.passwordOkMark.alpha = 1;
        }
    
    return  isOk;
}



//This method will clear session
-(void)clearSession
{
    [Gigya logout];
    [Gigya setSession:Nil];
    [Gigya setSessionDelegate:nil];
    
}


// hide social services butts
-(void)hideGigya
{
    _btnFacebook.hidden     = YES;
    _btnGoogleplus.hidden   = YES;
    _btnFoursquare.hidden   = YES;
    _btnTwitter.hidden      = YES;
    
//    _btnLinkedin.hidden     = YES;

}

// this method will push the next view.
-(void)nextView
{
    // ok, assuming at this point that everything has been validated and
    // I'm ready to return, so just dismiss the navigation controller.
    // You could use unwind segue in iOS 6, as well.
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"isLoggedIn"];
    [defaults setObject:[UserDataSingleton userSingleton].email forKey:@"currentLoggedInUserEmail"];
    [defaults synchronize];
    
    [[RMNManager sharedManager] setIsLoggedIn:YES];
    [[RMNManager sharedManager] setCurrentUserEmail:[UserDataSingleton userSingleton].email];
    
    NSLog(@"gata, sa salvam!");
    
    NSDate *birthDate = [[NSDate alloc] init];
    birthDate = [UserDataSingleton userSingleton].dateOfBirth;
    NSLog(@"birth is %@", birthDate);
    birthDate = datePicker.date;
    NSLog(@"birth from picker is %@", birthDate);
    
    NSMutableDictionary *infoUser = [[NSMutableDictionary alloc] init];
    
    [infoUser setValue:[UserDataSingleton userSingleton].email
                forKey:[RMNUserInformationCoreData keyForListValue:UserEmail]];
    [infoUser setValue:[UserDataSingleton userSingleton].userName
                forKey:[RMNUserInformationCoreData keyForListValue:UserUsername]];
    [infoUser setValue:birthDate
                forKey:[RMNUserInformationCoreData keyForListValue:UserDateOfBirth]];
    [infoUser setValue:[UserDataSingleton userSingleton].gender
                forKey:[RMNUserInformationCoreData keyForListValue:UserGender]];
    [infoUser setValue:[UserDataSingleton userSingleton].password
                forKey:[RMNUserInformationCoreData keyForListValue:UserPassword]];
    [infoUser setObject:[NSNumber numberWithBool:[UserDataSingleton userSingleton].isRegisteredWithNewAccount]
                forKey:[RMNUserInformationCoreData keyForListValue:UserIsRegisteredWithNewAccount]];
    [infoUser setValue:[NSNumber numberWithBool:[UserDataSingleton userSingleton].isUsingFacebook]
                forKey:[RMNUserInformationCoreData keyForListValue:UserIsUsingFacebook]];
    [infoUser setValue:[NSNumber numberWithBool:[UserDataSingleton userSingleton].isUsingFoursquare]
                forKey:[RMNUserInformationCoreData keyForListValue:UserIsUsingFoursquare]];
    [infoUser setValue:[NSNumber numberWithBool:[UserDataSingleton userSingleton].isUsingGoogle]
                forKey:[RMNUserInformationCoreData keyForListValue:UserIsUsingGoogle]];
    [infoUser setValue:[NSNumber numberWithBool:[UserDataSingleton userSingleton].isUsingTwitter]
                forKey:[RMNUserInformationCoreData keyForListValue:UserIsUsingTwitter]];
    [infoUser setValue:[NSDate date]
                forKey:[RMNUserInformationCoreData keyForListValue:UserRegistrationDate]];
    [infoUser setValue:[UserDataSingleton userSingleton].photoUrl
                forKey:[RMNUserInformationCoreData keyForListValue:UserPhotoURL]];
    
    [TSTCoreData addInformation:infoUser ofType:TSTCoreDataUser];
    
        
    [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}


// check if email is valid or not
-(BOOL) validateEmail:(NSString *)emailString
{
    BOOL stricterFilter         = YES;
    NSString *filterString      = @"^[_A-Za-z0-9-+]+(\\.[_A-Za-z0-9-+]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9-]+)*(\\.[A-Za-z‌​]{2,4})$";
    NSString        *laxString  = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString        *emailRegex = stricterFilter ? filterString : laxString;
    NSPredicate     *emailTest  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailString];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_txtAge            resignFirstResponder];
    [_txtEmail          resignFirstResponder];
    [_txtUsername       resignFirstResponder];
    [_txtPassword       resignFirstResponder];
}

- (void)resignTFs{
    
    [_txtAge            resignFirstResponder];
    [_txtEmail          resignFirstResponder];
    [_txtUsername       resignFirstResponder];
    [_txtPassword       resignFirstResponder];
}

//This is used to show alert views
-(void)showMessageTitle: (NSString *) title withMessage:(NSString *) message
{
    UIAlertView * alert=[[UIAlertView alloc]initWithTitle:title message:message
                          delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [alert show];
    
}

@end
