//
//  RMNDistancePageViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNDistancePageViewController.h"
#import "UIColor+HexRecognition.h"


@interface RMNDistancePageViewController ()

@end

@implementation RMNDistancePageViewController


- (void)viewWillAppear:(BOOL)animated{
    
    
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar setBarTintColor:SIDE_MENU_PAGES_NAVBAR_COLOR];
    
    
    [self setupMenuBarButtonItems];
    
    
}

// setup custom left/right menu bar buttons
// to fit the design
- (void)setupMenuBarButtonItems
{
    self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    
}

- (UIBarButtonItem *)leftMenuBarButtonItem
{
    
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
    
    // set localized texts
    self.navigationItem.title = NSLocalizedString(@"Settings",nil);
    self.titleLabel.text = NSLocalizedString(@"Distance",nil);
    
    [self.unitsSgmCtrl setTitle:NSLocalizedString(@"Kilometers",nil) forSegmentAtIndex:0];
    [self.unitsSgmCtrl setTitle:NSLocalizedString(@"Miles",nil) forSegmentAtIndex:1];

    	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"e9e9e9"]];

    // get unit from user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentUnit = [defaults objectForKey:@"distanceCurrentUnit"];
    
    if ([currentUnit isEqualToString:@"miles"]) {
        
        [self.unitsSgmCtrl setSelectedSegmentIndex:1];
    }
    else{

        [self.unitsSgmCtrl setSelectedSegmentIndex:0];
    }
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)changeUnit:(id)sender {
    
    NSString *currentUnit = @"";
    
    if (self.unitsSgmCtrl.selectedSegmentIndex == 0) {
        
        currentUnit = @"kilometers";
    }
    else{
        currentUnit = @"miles";
    }

    // save unit to user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentUnit forKey:@"distanceCurrentUnit"];
    [defaults synchronize];
}

@end
