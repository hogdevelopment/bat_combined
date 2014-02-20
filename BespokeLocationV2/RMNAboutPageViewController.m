//
//  RMNAboutPageViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNAboutPageViewController.h"

@interface RMNAboutPageViewController ()

@end

@implementation RMNAboutPageViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:SIDE_MENU_PAGES_NAVBAR_COLOR];
    
    [self.navigationItem setHidesBackButton:YES];
    
    // setup custom back button
    [self setupMenuBarButtonItems];
    
    // add page title
    self.navigationItem.title = NSLocalizedString(@"About",nil);


}



// setup custom left/right menu bar buttons
// to fit the design
- (void)setupMenuBarButtonItems
{
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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // detect current version of app and update the view
    [self.appVersionLabel setText:[NSString stringWithFormat:@"Version %@",
                                   [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]]];
    
    // add rouned cornes to the table
    self.backgroundView.layer.cornerRadius = 4;
    self.backgroundView.layer.masksToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)showMenuViewController:(id)sender
{
     [self.navigationController dismissViewControllerAnimated:NO completion:nil];
}

@end
