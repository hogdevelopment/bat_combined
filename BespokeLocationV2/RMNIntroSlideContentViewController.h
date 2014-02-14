//
//  RMNIntroSlideContentViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 14/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface RMNIntroSlideContentViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageHolder;
@property (weak, nonatomic) IBOutlet UILabel *subtitleHolder;
@property (weak, nonatomic) IBOutlet UILabel *titleHolder;
@property (weak, nonatomic) IBOutlet UIView *footerMaskView;



@property NSUInteger pageIndex;
@property NSString *titleText;
@property NSString *subtitleText;
@property NSString *imageFile;


@end
