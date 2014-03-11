//
//  RMNCustomNavButton.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNCustomNavButton.h"
#import "UIView+Convert.h"

@implementation RMNCustomNavButton


+ (UIImage*)customNavButton:(RMNCustomNavigationBarType)type
                          withTitle:(NSString*)title
{
    
    CGRect buttonFrame = CGRectMake(0, 0, 60, 30);
    UIView* holder = [[UIView alloc]init];
    
    
    CGRect labelFrame = CGRectMake(20, 0, 35, 30);
    
    UIColor *labelColor = [UIColor whiteColor];
    
    
    int fontSize = 12;
    // custom cases
    
    // set the custom label
    UILabel *label = [[UILabel alloc]init];
    
    NSString *imageLocation;
    switch (type) {
        case RMNCustomNavButtonForward:
        {
            imageLocation = @"fwdHolderImageBg";
            labelFrame.origin.x = 10;
            break;
        }
        case RMNCustomNavButtonBackward:
        {
            imageLocation = @"bcwdHolderImageBg";
            break;
        }
        case RMNCustomNavButtonArrowless:
        {
            imageLocation   = @"filtersSideMenuButtonBackground";
            buttonFrame     = CGRectMake(0, 0, 106, 32);
            labelFrame      = CGRectMake(0, 0, 106, 32);
            labelColor      = CELL_DARK_GRAY;
            fontSize        = 14;
            [label setTextAlignment:NSTextAlignmentCenter];


            break;
        }
        default:
            break;
    }
    
    
    [holder setFrame:buttonFrame];
    
    // set the background image view holder
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:buttonFrame];
    [imageView setImage:[UIImage imageNamed:imageLocation]];
    

    [label setFrame:labelFrame];
    [label setText:NSLocalizedString(title, nil)];
    [label setTextColor:labelColor];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    
  
    // add all together
    [holder addSubview:imageView];
    [holder addSubview:label];
    
    
    
    
    
    
    return [holder imageFromView];

}

@end
