//
//  RMNEditFilterTableViewCell.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 20/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNEditFilterTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation RMNEditFilterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)prepareForReuse {
    
    [super prepareForReuse];
    [self.scrollContentView setContentOffset:CGPointZero animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) setScrollViewProperties{
    
    [self.scrollContentView setDelegate:self];
    [self.scrollContentView setContentSize:CGSizeMake(420, self.scrollContentView.frame.size.height)];
    
}



- (void) snapCellToPosition{
    
    if (_lastContentOffset < (int)self.scrollContentView.contentOffset.x) {
        
        // moving to the right - bottom of the scroll view
        CGPoint bottomOffset = CGPointMake(self.scrollContentView.contentSize.width - self.scrollContentView.bounds.size.width, 0);
        [self.scrollContentView setContentOffset:bottomOffset animated:YES];
    }
    else
        if (_lastContentOffset > (int)self.scrollContentView.contentOffset.x) {
            
            // moving to the left
            [self.scrollContentView setContentOffset:CGPointZero animated:YES];
        }
}



#pragma UIScrollView Delegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    _lastContentOffset = scrollView.contentOffset.x;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self snapCellToPosition];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        
        [self snapCellToPosition];
    }
}



#pragma UIButtons method
- (IBAction)clickOnButton:(UIButton *)sender {
    
    NSLog(@"clickOnButton %u", sender.tag);
    [self.scrollContentView setContentOffset:CGPointZero animated:YES];

}

@end
