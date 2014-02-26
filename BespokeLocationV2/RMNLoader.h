//
//  RMNLoader.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 25/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNLoader : UIView
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

// start animating the activity indicator
- (void)animate;

// stop animating and remove it from the parent view
- (void)stopAnimating;
@end
