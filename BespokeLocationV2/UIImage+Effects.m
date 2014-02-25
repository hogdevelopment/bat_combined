//
//  UIImage+Effects.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 15/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "UIImage+Effects.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImage (Effects)

- (UIImage*)roundedImage
{
    
    
    UIImage *image = self;
    CGSize imageSize = image.size;
    
    
    CGRect imageRect = CGRectMake(0, 0, imageSize.width, imageSize.height);
    
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // Create the clipping path and add it
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:imageRect];
    [path addClip];
    [image drawInRect:imageRect];
    
    CGContextSetStrokeColorWithColor(ctx, [[UIColor whiteColor] CGColor]);
    [path setLineWidth:5.0f];
    [path stroke];
    
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();

    return roundedImage;
    
}

- (UIImage *)scaleToSize:(CGSize)size
{
    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)])
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, [[UIScreen mainScreen] scale]);
    }
    else
    {
        UIGraphicsBeginImageContext(size);
    }
    
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage *)scaleToMaxSize:(CGSize)size
{
    
    CGFloat oldWidth    = self.size.width;
    CGFloat oldHeight   = self.size.height;
    
    CGFloat scaleFactor = (oldWidth > oldHeight) ?  size.width / oldWidth :
                                                    size.height / oldHeight;
    
    CGFloat newHeight   = oldHeight * scaleFactor;
    CGFloat newWidth    = oldWidth * scaleFactor;
    CGSize  newSize     = CGSizeMake(newWidth, newHeight);
    
    return [self scaleToSize:newSize];
}



- (void)saveImageToPhone
{
    NSString *pathToSave = [NSString stringWithFormat:@"/Documents/myProfileImageFor%@.png",
                            [[RMNManager sharedManager]currentUserEmail]];
    
    NSString* path = [NSHomeDirectory() stringByAppendingString:pathToSave];
    
    BOOL ok = [[NSFileManager defaultManager] createFileAtPath:path
                                                      contents:nil attributes:nil];
    
    if (!ok)
    {
        NSLog(@"Error creating file %@", path);
    }
    else
    {
        NSFileHandle* myFileHandle = [NSFileHandle fileHandleForWritingAtPath:path];
        [myFileHandle writeData:UIImagePNGRepresentation(self)];
        [myFileHandle closeFile];
    }
}


@end
