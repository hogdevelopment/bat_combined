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
    [holder setFrame:buttonFrame];
    
    CGRect labelFrame = CGRectMake(20, 0, 35, 30);
    
   
    // custom cases
    
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
        default:
            break;
    }
    
    
    
    // set the background image view holder
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:buttonFrame];
    [imageView setImage:[UIImage imageNamed:imageLocation]];
    
    // set the custom label
    UILabel *label = [[UILabel alloc]init];
    [label setFrame:labelFrame];
    [label setText:title];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont fontWithName:@"HelveticaNeue" size:12]];
    
  
    // add all together
    [holder addSubview:imageView];
    [holder addSubview:label];
    
    
    
    
    
    
    return [holder imageFromView];

}

@end
