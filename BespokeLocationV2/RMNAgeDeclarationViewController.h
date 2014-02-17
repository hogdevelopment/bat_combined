//
//  RMNAgeDeclarationViewController.h
//  BespokeLocationV2
//
//  Created by infodesign on 2/17/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNAgeDeclarationViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleApp;
@property (strong, nonatomic) IBOutlet UILabel *ageLabel;

@property (strong, nonatomic) IBOutlet UIButton *thickButt;
@property (strong, nonatomic) IBOutlet UIButton *loginButt;
@property (strong, nonatomic) IBOutlet UIButton *registerButt;

@property (strong, nonatomic) IBOutlet UIImageView *okMark;


- (IBAction)markAction:(id)sender;
- (IBAction)registerAction:(id)sender;
- (IBAction)loginAction:(id)sender;

- (IBAction)changeColor:(id)sender;

@end
