//
//  RMNFaqsAnswersViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 19/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNFaqsAnswersViewController : UIViewController


@property (nonatomic, strong) NSString* question;
@property (nonatomic, strong) NSString* answer;

@property (weak, nonatomic) IBOutlet UIView *viewHolder;
@property (weak, nonatomic) IBOutlet UILabel *questionHolderLabel;
@property (weak, nonatomic) IBOutlet UITextView *answerTextView;


@end
