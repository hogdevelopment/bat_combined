//
//  RMNDistancePageViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNDistancePageViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *milesButt;
@property (strong, nonatomic) IBOutlet UIButton *kmButt;
@property (strong, nonatomic) IBOutlet UIImageView *selectedMark;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;

- (IBAction)chooseUnitAction:(id)sender;
@end
