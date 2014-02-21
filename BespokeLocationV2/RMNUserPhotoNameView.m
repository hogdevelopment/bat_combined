//
//  UserPhotoNameView.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 15/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNUserPhotoNameView.h"
#import "UIImage+Effects.h"
#import  "QuartzCore/QuartzCore.h"

@implementation RMNUserPhotoNameView

- (void)customizeWith:(NSString*)userName
{
    
    // set the users name
    [self.nameTextHolder setText:userName];
    
    // change bg color to match design
    [self setBackgroundColor:[UIColor colorWithHexString:@"6f6f6f"]];
    
    
    // add drop shadow effect
    self.layer.masksToBounds    = NO;
    self.layer.shadowOffset     = CGSizeMake(.0f,2.5f);
    self.layer.shadowRadius     = 1.5f;
    self.layer.shadowOpacity    = .4f;
    self.layer.shadowColor      = [UIColor grayColor].CGColor;
    self.layer.shadowPath       = [UIBezierPath bezierPathWithRect:self.bounds].CGPath;
    
    [self.activityIndicator setHidesWhenStopped:YES];
    
    [self addImage];

}

- (void)addImage
{
    [self.activityIndicator startAnimating];
    dispatch_async(kBgQueue, ^{
        
        // get the profile image
        UIImage *image = [RMNUserInfo profileImage];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.activityIndicator stopAnimating];
            // set the profile image
            [self.imageViewHolder setImage:[image roundedImage]];
        });
        
    });

}
@end
