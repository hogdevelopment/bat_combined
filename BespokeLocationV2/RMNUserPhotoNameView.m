//
//  UserPhotoNameView.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 15/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNUserPhotoNameView.h"
#import "UIImage+Effects.h"


@implementation RMNUserPhotoNameView

- (void)addPic:(NSString*)imageName
{
    // change bg color to match design
    [self setBackgroundColor:[UIColor colorWithHexString:@"6f6f6f"]];
    
    
    // apply custom effect to image and add it
    // to its holder
    UIImage *image = [UIImage imageNamed:imageName];
    [self.imageViewHolder setImage:[image roundedImage]];

}

- (void)addName:(NSString*)userName
{
    // set the users name
    [self.nameTextHolder setText:userName];
}

@end
