//
//  RMNCustomNavButton.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    RMNCustomNavButtonForward,
    RMNCustomNavButtonBackward
}RMNCustomNavigationBarType;

@interface RMNCustomNavButton : NSObject


// creates image from a set of give images and text
// this is used for creation of custom ui bar buttons
+ (UIImage*)customNavButton:(RMNCustomNavigationBarType)type
                  withTitle:(NSString*)title;


@end
