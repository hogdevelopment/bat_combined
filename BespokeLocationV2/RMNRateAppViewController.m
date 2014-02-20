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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:SIDE_MENU_PAGES_NAVBAR_COLOR];
    
    self.navigationItem.title = NSLocalizedString(@"Rate the App",nil);

    
    [[self navigationItem]setHidesBackButton:YES];
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
	// Do any additional setup after loading the view.
    
    [self rateApp];
}

- (void) rateApp
{
    [textViewDebug          setHidden:YES];
    [self.activityIndicator setHidden:NO];
    [self.activityIndicator startAnimating];

    
#warning pending for app identifier from itunes connect
    SKStoreProductViewController *storeAppController = [[SKStoreProductViewController alloc] init];
    

    [storeAppController setDelegate:self];
    storeAppController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    [storeAppController loadProductWithParameters:@{SKStoreProductParameterITunesItemIdentifier : @"641530683"}
                                  completionBlock:^(BOOL result, NSError *error) {
                                      
                                      if (error) {
                                        
                                          // 
                                          [self.activityIndicator   stopAnimating];
                                          [self.activityIndicator   setHidden:YES];
                                          [textViewDebug            setHidden:NO];
                                          
                                          [textViewDebug setText:error.debugDescription];
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
    
    // if the text view is hidden, we know the
    // loading was successfull and we must dismiss the
    // loaded view controller also
    if ([textViewDebug isHidden])
    {
        [self dismissViewControllerAnimated:NO completion:NULL];
    }

    // send the user back to the side menu controller
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
