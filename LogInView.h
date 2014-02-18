//
//  ViewController.h
//  GigyaAuth
//
//  Created by shinoy on 1/20/14.
//  Copyright (c) 2014 shinoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GigyaSDK/Gigya.h>
#import "CGEnhancedKeyboard.h"

@interface LogInView : UIViewController<GSSessionDelegate, UIAlertViewDelegate,UITextFieldDelegate, UIScrollViewDelegate, CGEnhancedKeyboardDelegate, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIScrollView *zaScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewBg;

@property (strong, nonatomic) IBOutlet UILabel *titleForGetStareted;
@property (strong, nonatomic) IBOutlet UILabel *subTitle;
@property (strong, nonatomic) IBOutlet UILabel *emailLabel;
@property (strong, nonatomic) IBOutlet UILabel *usernameLabel;
@property (strong, nonatomic) IBOutlet UILabel *birthLabel;
@property (strong, nonatomic) IBOutlet UILabel *genderLabel;
@property (strong, nonatomic) IBOutlet UILabel *passLabel;
@property (strong, nonatomic) IBOutlet UILabel *serviceSignLabel;

@property (weak, nonatomic) IBOutlet UITextField  * txtEmail;
@property (weak, nonatomic) IBOutlet UITextField  * txtUsername;
@property (weak, nonatomic) IBOutlet UITextField  * txtAge;
@property (weak, nonatomic) IBOutlet UITextField  * txtPassword;

@property (weak, nonatomic) IBOutlet UISegmentedControl *genderSgmCtrl;

@property (weak, nonatomic) IBOutlet UIButton     * btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton     * btnGoogleplus;
@property (weak, nonatomic) IBOutlet UIButton     * btnTwitter;
@property (weak, nonatomic) IBOutlet UIButton     * btnLinkedin;
@property (weak, nonatomic) IBOutlet UIButton     * btnFoursquare;
@property (weak, nonatomic) IBOutlet UIButton     * btnRegistrater;

@property (strong, nonatomic) IBOutlet UIImageView *emailOkMark;
@property (strong, nonatomic) IBOutlet UIImageView *usernameOkMark;
@property (strong, nonatomic) IBOutlet UIImageView *birthOkMark;
@property (strong, nonatomic) IBOutlet UIImageView *passwordOkMark;

// actions
- (IBAction)signUpAction             :(id)sender;
- (IBAction)loginWithFoursquare      :(id)sender;
- (IBAction)loginWithFacebook        :(id)sender;
- (IBAction)loginWithGoogleplus      :(id)sender;
- (IBAction)loginWithTwitter         :(id)sender;
- (IBAction)loginWithLinkedin        :(id)sender;

- (IBAction)changeBorderColor:(id)sender;
- (IBAction)changeColorToWhite:(id)sender;

@end
