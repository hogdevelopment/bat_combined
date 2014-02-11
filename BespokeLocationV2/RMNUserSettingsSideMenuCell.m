//
//  RMNUserSettingsSideMenuCell.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNUserSettingsSideMenuCell.h"





@interface RMNUserSettingsSideMenuCell()
{
    UIImageView *imageViewHolder;
}

@end

@implementation RMNUserSettingsSideMenuCell

@synthesize imageViewHolder =   imageViewHolder;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        // create image holder
        imageViewHolder = [[UIImageView alloc]init];
        [imageViewHolder setFrame:CGRectMake(10, 0, 30, self.contentView.frame.size.height)];
        [self.contentView addSubview:imageViewHolder];
        
        [imageViewHolder setContentMode:UIViewContentModeCenter];
        
#warning DEBUG ONLY. Modify later, when we have design layouts.
        [imageViewHolder setBackgroundColor:[UIColor purpleColor]];
        
  
        
        
    }
    return self;
}

// overwritten this to move the existing text label 50 px to the right
// so it wont overlay with the image
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGRect frame = CGRectMake(50.0f, 0.0f, size.width, size.height);
    self.textLabel.frame =  frame;
    self.textLabel.contentMode = UIViewContentModeScaleAspectFit;
}


// overwrite it to obtain the custom colors
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        // if selected, the background changes color
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:@"dddddd"]];
        
    }
    else
    {
        // if deselected, the background return to the original color
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:@"333333"]];
    }
    // Configure the view for the selected state
}


@end
