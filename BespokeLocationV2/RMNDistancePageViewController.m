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


- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"616161"]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];

    [self.navigationItem.backBarButtonItem setTintColor:[UIColor whiteColor]];
    
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
