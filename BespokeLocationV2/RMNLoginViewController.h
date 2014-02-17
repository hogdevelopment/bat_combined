//
//  RMNLoginViewController.h
//  BespokeLocationV2
//
//  Created by infodesign on 2/14/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GigyaSDK/Gigya.h>

@interface RMNLoginViewController : UIViewController<GSSessionDelegate, UIAlertViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UILabel      *titleAppLabel;
@property (strong, nonatomic) IBOutlet UITextField  *emailTF;
@property (strong, nonatomic) IBOutlet UITextField  *passwordTF;
@property (strong, nonatomic) IBOutlet UIButton     *loginButt;
@property (strong, nonatomic) IBOutlet UIButton     *forgotPassButt;

@property (strong, nonatomic) IBOutlet UIView   *socialView;
@property (strong, nonatomic) IBOutlet UILabel  *loginSocialLabel;
@property (strong, nonatomic) IBOutlet UIButton *facebookButt;
@property (strong, nonatomic) IBOutlet UIButton *twitterButt;
@property (strong, nonatomic) IBOutlet UIButton *googleButt;
@property (strong, nonatomic) IBOutlet UIButton *foursquareButt;

- (IBAction)loginAction                 :(id)sender;
- (IBAction)sendPasswordOnEmail         :(id)sender;
- (IBAction)registerWithSocialService   :(id)sender;

@end
