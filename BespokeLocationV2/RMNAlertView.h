//
//  RMNAlertView.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/03/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNAlertView : NSObject

// custom alert view with delegate and message
// and a textfield input view
+ (void)customAlertViewWithMessage:(NSString*)message withDelegate:(id)delegate;

// custom altert view with message
+ (void)customAlertViewWithMessage:(NSString*)message;

@end
