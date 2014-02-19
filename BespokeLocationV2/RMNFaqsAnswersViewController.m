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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
