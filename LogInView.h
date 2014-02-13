//
//  ViewController.h
//  GigyaAuth
//
//  Created by shinoy on 1/20/14.
//  Copyright (c) 2014 shinoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GigyaSDK/Gigya.h>


@interface LogInView : UIViewController<GSSessionDelegate, UIAlertViewDelegate,UITextFieldDelegate>


//@property (nonatomic, strong) NSMutableDictionary * userInfo;

@property (weak, nonatomic) IBOutlet UITextField  * txtName;

@property (weak, nonatomic) IBOutlet UITextField  * txtLastName;

@property (weak, nonatomic) IBOutlet UITextField  * txtEmail;

@property (weak, nonatomic) IBOutlet UITextField  * txtReenterEmail;

@property (weak, nonatomic) IBOutlet UITextField  * txtAge;

@property (weak, nonatomic) IBOutlet UILabel      * lblGender;

@property (weak, nonatomic) IBOutlet UISwitch     * swtchGender;

@property (weak, nonatomic) IBOutlet UIButton     * btnRegistrater;

@property (weak, nonatomic) IBOutlet UIButton     * btnFacebook;

@property (weak, nonatomic) IBOutlet UIButton     * btnGoogleplus;

@property (weak, nonatomic) IBOutlet UIButton     * btnLinkedin;

@property (weak, nonatomic) IBOutlet UIButton     * btnFoursquare;

@property (weak, nonatomic) IBOutlet UILabel      * lblGigya;
@property (strong, nonatomic) IBOutlet UIButton *btnTwitter;

//Actions
- (IBAction)swtchValueChanged:(id)sender;

- (IBAction)btnRegister      :(id)sender;


- (IBAction)loginWithFoursquare      :(id)sender;

- (IBAction)loginWithFacebook        :(id)sender;

- (IBAction)loginWithGoogleplus      :(id)sender;

- (IBAction)loginWithLinkedin        :(id)sender;

- (IBAction)loginWithTwitter         :(id)sender;

@end
