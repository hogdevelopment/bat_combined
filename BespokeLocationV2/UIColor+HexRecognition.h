//
//  UIColor+HexRecognition.h
//  
//
//  Created by Chiosa Gabi on 9/14/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (HexRecognition)

// returns UIColor from a hex code
+(UIColor*)colorWithHexString:(NSString*)hex;

- (void)test;
@end
