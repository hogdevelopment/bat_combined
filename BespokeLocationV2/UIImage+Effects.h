//
//  UIImage+Effects.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 15/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Effects)

// make the corners of the image rounded
// + white border
- (UIImage*)roundedImage;

// scale image keeping aspect ratio
- (UIImage *)scaleToMaxSize:(CGSize)size;

// save image to a predefined location
- (void)saveImageToPhone;
@end
