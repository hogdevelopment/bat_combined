//
//  RMNHelpAndImproveViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 13/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface RMNHelpAndImproveViewController : UIViewController<MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textViewDebug;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

