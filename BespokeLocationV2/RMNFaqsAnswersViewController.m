//
//  RMNFaqsAnswersViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 19/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFaqsAnswersViewController.h"

@interface RMNFaqsAnswersViewController ()
{
    NSString* question;
    NSString* answer;
}
@end

@implementation RMNFaqsAnswersViewController
@synthesize question    =   question;
@synthesize answer      =   answer;


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBarTintColor:SIDE_MENU_PAGES_NAVBAR_COLOR];
    
    [self setupMenuBarButtonItems];
}


// setup custom left/right menu bar buttons
// to fit the design
- (void)setupMenuBarButtonItems
{
    self.navigationItem.leftBarButtonItem = [self leftMenuBarButtonItem];
    
}

- (UIBarButtonItem *)leftMenuBarButtonItem {
    
    UIImage*leftyButton = [RMNCustomNavButton customNavButton:RMNCustomNavButtonBackward withTitle:@"Back"];
    
    UIBarButtonItem *lefty = [[UIBarButtonItem alloc]
                              initWithImage:leftyButton
                              style:UIBarButtonItemStyleBordered
                              target:self.navigationController
                              action:@selector(popViewControllerAnimated:)];
    [lefty setTintColor:[UIColor whiteColor]];
    
    return lefty;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.questionHolderLabel   setText: question];
    [self.answerTextView        setText: answer];
    
    
    // add rouned cornes to the table
    self.viewHolder.layer.cornerRadius = 4;
    self.viewHolder.layer.masksToBounds = YES;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
