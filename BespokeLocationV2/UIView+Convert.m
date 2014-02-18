//
//  UIView+Convert.m
//  photoAlbook
//
//  Created by Chiosa Gabi on 9/12/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "UIView+Convert.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Convert)

- (float) screenScale
{
    if ([ [UIScreen mainScreen] respondsToSelector: @selector(scale)] == YES) {
        return [ [UIScreen mainScreen] scale];
    }
    return 1;
}


- (UIImage *) imageFromView
{
    CGFloat scale = [self screenScale];
    
    if (scale > 1) {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, scale);
    } else {
        UIGraphicsBeginImageContext(self.bounds.size);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext: context];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return viewImage;
}

@end
