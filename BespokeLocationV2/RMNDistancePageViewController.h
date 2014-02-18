//
//  RMNDistancePageViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNDistancePageViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *unitsSgmCtrl;

- (IBAction)changeUnit:(id)sender;
@end
