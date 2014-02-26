//
//  RMNEditFilterTableViewCell.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 20/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface RMNEditFilterTableViewCell : UITableViewCell<UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *filterImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *kindLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollContentView;
@property CGFloat lastContentOffset;

- (IBAction)clickOnButton:(UIButton *)sender;

- (void) setScrollViewProperties;
@end
