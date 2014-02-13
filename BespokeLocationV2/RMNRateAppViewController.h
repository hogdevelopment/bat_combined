//
//  RMNRateAppViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 13/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>


@interface RMNRateAppViewController : UIViewController<SKStoreProductViewControllerDelegate>


@property (nonatomic) IBOutlet UITextView *textViewDebug;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end
