//
//  RMNLoader.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 25/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNLoader.h"

@implementation RMNLoader

- (void)animate
{
    [self.activityIndicator startAnimating];
}

- (void)stopAnimating
{
    [self.activityIndicator stopAnimating];
    [self removeFromSuperview];
}

@end
