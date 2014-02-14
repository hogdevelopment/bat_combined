//
//  RMNIntroSlidesViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 13/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNIntroSlidesViewController : UIViewController<UIPageViewControllerDataSource,UIPageViewControllerDelegate>


@property (strong, nonatomic) UIPageViewController *pageViewController;


//- (IBAction)startWalkthrough:(id)sender;
@property (strong, nonatomic) NSArray *pageTitles;
@property (strong, nonatomic) NSArray *pageSubtitles;

@property (strong, nonatomic) NSArray *pageImages;
@property (weak, nonatomic) IBOutlet UIButton *skipIntroSlidesButton;

@property (weak, nonatomic) IBOutlet UIPageControl *customPageController;

@property (weak, nonatomic) IBOutlet UIImageView *lineSeparator;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
- (IBAction)nextSlideAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *startAppButton;
@property (weak, nonatomic) IBOutlet UIView *customFooter;


@end
