//
//  RMNIntroSlideContentViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 14/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNIntroSlideContentViewController.h"

@interface RMNIntroSlideContentViewController ()

@end

@implementation RMNIntroSlideContentViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    // customize content view controller
    // information comes from the page view controller
    self.imageHolder.image      = [UIImage imageNamed:self.imageFile];
    self.titleHolder.text       = self.titleText;
    self.subtitleHolder.text    = self.subtitleText;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
