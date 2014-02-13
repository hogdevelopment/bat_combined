//
//  RMNRateAppViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 13/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNRateAppViewController.h"

@interface RMNRateAppViewController ()
{
    UITextView *textViewDebug;
}
@end

@implementation RMNRateAppViewController

@synthesize textViewDebug   =   textViewDebug;
- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

     self.navigationItem.hidesBackButton = YES;


    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [self rateApp];
}

- (void) rateApp{
    
    [self.activityIndicator startAnimating];
    [textViewDebug setHidden:YES];
    
#warning pending for app identifier from itunes connect
    SKStoreProductViewController *storeAppController = [[SKStoreProductViewController alloc] init];
    

    [storeAppController setDelegate:self];
    
    [storeAppController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"641530683"}
                                  completionBlock:^(BOOL result, NSError *error) {
                                      
                                      if (error) {
                                        
                                          [self.activityIndicator stopAnimating];
                                          [textViewDebug setHidden:NO];
                                          [textViewDebug setText:error.debugDescription];
//NSLog(@"Error %@ with User Info %@.", error, [error userInfo]);
                                          
                                           self.navigationItem.hidesBackButton = NO;
                                      } else
                                      {
                                          [self.activityIndicator stopAnimating];
                                          [self presentViewController:storeAppController animated:YES completion:nil];
                                      }
                                  }
     ];
    
    
    

    

}



- (void)productViewControllerDidFinish:(SKStoreProductViewController *)viewController
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
