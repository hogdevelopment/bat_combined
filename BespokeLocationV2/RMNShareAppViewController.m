//
//  RMNShareAppViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 13/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNShareAppViewController.h"

@interface RMNShareAppViewController ()


@end

@implementation RMNShareAppViewController


- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationItem.title = NSLocalizedString(@"Share the App",nil);

    
    self.navigationItem.hidesBackButton = YES;
    [self.navigationController.navigationBar setBarTintColor:SIDE_MENU_PAGES_NAVBAR_COLOR];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self shareApp];
}



- (void) shareApp{

#warning pending text and/or url to share
    
    // start activity indicator
    [self.activityIndicator startAnimating];
     [self.activityIndicator setHidden:NO];
    
    // create new dispatch queue in background
    dispatch_queue_t queue = dispatch_queue_create("openActivityIndicatorQueue", NULL);
    
    // send initialization of UIActivityViewController in background
    dispatch_async(queue, ^{
        NSString *text = @"Yes, we are sharing the Smoking app";
        NSURL *shareUrl = [NSURL URLWithString:@"http://www.google.com"];
        
        NSArray *activityItems = @[text, shareUrl];
        UIActivityViewController *activityController = [[UIActivityViewController alloc]
                                                        initWithActivityItems:activityItems
                                                        applicationActivities:nil];
        
#warning THIS WILL CRASH IN < IOS 7. Not a priority now
        // tell the activity controller which activities should not appear
        activityController.excludedActivityTypes = @[UIActivityTypePrint, UIActivityTypeAirDrop, UIActivityTypeAssignToContact, UIActivityTypeSaveToCameraRoll, UIActivityTypeAddToReadingList];
        activityController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
        // when UIActivityViewController is finally initialized,
        // hide indicator and present it on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.activityIndicator stopAnimating];
            [self.activityIndicator setHidden:YES];
            [self presentViewController:activityController
                                  animated:YES completion:nil];
            
            [activityController setCompletionHandler:^(NSString *activityType, BOOL completed)
             {
                 NSLog(@"completed dialog - activity: %@ - finished flag: %d", activityType, completed);
                 [self.navigationController popViewControllerAnimated:YES];
             }];
            
        });
    });
    

    
} 


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
