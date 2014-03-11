//
//  RMNAlertView.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/03/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNAlertView.h"

@implementation RMNAlertView


+ (void)customAlertViewWithMessage:(NSString*)message withDelegate:(id)delegate
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:Nil
                                                    message:message
                                                   delegate:delegate
                                          cancelButtonTitle:NSLocalizedString(@"Cancel",nil)
                                          otherButtonTitles:NSLocalizedString(@"Save",nil), nil
                          ];
    
    
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    
    [alert show];
    
    

    
}


@end
