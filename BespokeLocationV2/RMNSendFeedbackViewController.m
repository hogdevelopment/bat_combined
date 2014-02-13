//
//  RMNSendFeedbackViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 13/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNSendFeedbackViewController.h"

@interface RMNSendFeedbackViewController ()

@end

@implementation RMNSendFeedbackViewController

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
#warning NO MAIL SET UP ISSUE
    // if the user hasn't mail set up to its phone
    // we must let him now
    if ([MFMailComposeViewController canSendMail])
    {
        self.navigationItem.hidesBackButton = YES;
    }

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if ([MFMailComposeViewController canSendMail]) {
     
        // if we can load the mail view controller
        // there's no need for the debug text view
        [self.textViewDebug setHidden:YES];
        
        [self sendFeedback]; 
    }

}

- (void) sendFeedback
{
    
#warning pending text and/or url to share
    
    // start activity indicator
    [self.activityIndicator startAnimating];
    
    // create new dispatch queue in background
    dispatch_queue_t queue = dispatch_queue_create("openActivityIndicatorQueue", NULL);
    
    // send initialization of MFMailComposeViewController in background
    dispatch_async(queue, ^{
        MFMailComposeViewController *mailController = [[MFMailComposeViewController alloc] init];
        [mailController setMailComposeDelegate:self];
        [mailController setSubject:@"Feedback for smoking app"];
        [mailController setMessageBody:@" " isHTML:NO];
        [mailController setToRecipients:[NSArray arrayWithObjects:@"aurelia.pasat@infodesign.ro", nil]];
        [mailController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
        // when MFMailComposeViewController is finally initialized,
        // hide indicator and present it on main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            [self presentViewController:mailController animated:NO completion:NULL];
            
        });
    });
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - MFMailComposeViewControllerDelegate Method

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    // maybe we should show an alert to user
    // if the mail was sent or not
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Email Cancelled") ;
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Email Saved") ;
            break;
        case MFMailComposeResultSent:
            NSLog(@"Email Sent") ;
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Email Failed") ;
            break;
        default:
            NSLog(@"Email Not Sent") ;
            break;
    }
    
//    [self dismissViewControllerAnimated:NO completion:NULL];
    

    [[RMNManager sharedManager] setMenuShouldBeOpened:YES];
    
    [self dismissViewControllerAnimated:NO completion:nil];
     [self.navigationController popViewControllerAnimated:YES];
}

@end