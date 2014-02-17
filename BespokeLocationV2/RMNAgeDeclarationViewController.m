//
//  RMNAgeDeclarationViewController.m
//  BespokeLocationV2
//
//  Created by infodesign on 2/17/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNAgeDeclarationViewController.h"

@interface RMNAgeDeclarationViewController ()

@end

@implementation RMNAgeDeclarationViewController

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
    
    [self setLocalizedStringsForAllTexts];
    
    // put border on butts
    self.thickButt.layer.cornerRadius = 4.0;
    self.thickButt.layer.borderWidth = 1.0;
    self.thickButt.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    self.loginButt.layer.cornerRadius = 4.0;
    self.loginButt.layer.borderWidth = 1.0;
    self.loginButt.layer.borderColor = [UIColor orangeColor].CGColor;
    self.loginButt.titleLabel.textColor = [UIColor orangeColor];
    
    self.registerButt.layer.cornerRadius = 4.0;
    self.registerButt.layer.borderWidth = 1.0;
    self.registerButt.layer.borderColor = [UIColor orangeColor].CGColor;
    self.registerButt.titleLabel.textColor = [UIColor orangeColor];
    
    if (!IS_IPHONE_5) {
        
        CGRect newFrame = self.titleApp.frame;
        newFrame.origin.y -= 45;
        
        [self.titleApp setFrame:newFrame];
        
        newFrame = self.thickButt.frame;
        newFrame.origin.y -= 75;
        
        [self.thickButt setFrame:newFrame];
        
        newFrame = self.ageLabel.frame;
        newFrame.origin.y -= 75;
        
        [self.ageLabel setFrame:newFrame];
        
        newFrame = self.okMark.frame;
        newFrame.origin.y -= 75;
        
        [self.okMark setFrame:newFrame];
        
        newFrame = self.registerButt.frame;
        newFrame.origin.y -= 75;
        
        [self.registerButt setFrame:newFrame];
        
        newFrame = self.loginButt.frame;
        newFrame.origin.y -= 75;
        
        [self.loginButt setFrame:newFrame];
    }

    self.navigationItem.hidesBackButton = YES;
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    // logout user
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:NO forKey:@"isLoggedIn"];
    [defaults synchronize];
    
    [[RMNManager sharedManager] setIsLoggedIn:NO];
    
    
    // change design for butts
    [self.loginButt setBackgroundColor:[UIColor whiteColor]];
    self.loginButt.titleLabel.textColor = [UIColor orangeColor];
    
    [self.registerButt setBackgroundColor:[UIColor whiteColor]];
    self.registerButt.titleLabel.textColor = [UIColor orangeColor];
    
    // change navigation bar aspect
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    
    [[RMNManager sharedManager] setMenuShouldBeOpened:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) setLocalizedStringsForAllTexts
{
    // labels
    self.titleApp.text     = NSLocalizedString(@"Where to Smoke",nil);
    self.ageLabel.text     = NSLocalizedString(@"I am 18 years old",nil);
    
    // buttons title
    [self.loginButt      setTitle:NSLocalizedString(@"Login",nil) forState:UIControlStateNormal];
    [self.registerButt   setTitle:NSLocalizedString(@"Register",nil) forState:UIControlStateNormal];
}


#pragma UIButtons methods

- (IBAction)registerAction:(id)sender {
    [self performSegueWithIdentifier:@"registerSegue" sender:self];

}

- (IBAction)loginAction:(id)sender {
    
    [self performSegueWithIdentifier:@"loginSegue" sender:self];

}

- (IBAction)changeColor:(id)sender {
    
    UIButton *butt = (UIButton *)sender;
    butt.titleLabel.textColor = [UIColor whiteColor];
    [butt setBackgroundColor:[UIColor orangeColor]];

}

- (IBAction)markAction:(id)sender {
    
    self.okMark.alpha = !self.okMark.alpha;
}

@end
