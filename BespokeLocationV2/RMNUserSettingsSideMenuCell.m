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
    BOOL isHeader;
}

@property BOOL isHeader;

@end

@implementation RMNUserSettingsSideMenuCell

@synthesize imageViewHolder =   imageViewHolder;
@synthesize isHeader        =   isHeader;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier

{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {

        if ([reuseIdentifier isEqualToString:@"HeaderCellReuseIdentifier"])
        {
            isHeader = YES;
            NSLog(@"este header");
        }

        
        [self.contentView addSubview:[self cellViewIsSelected:NO]];
        
         self.selectedBackgroundView =  [self cellViewIsSelected:YES];
        
        
        // create image holder
        imageViewHolder = [[UIImageView alloc]init];
        [imageViewHolder setFrame:CGRectMake(20, 0, 30, SIDE_MENU_ROW_HEIGHT)];
        [self.contentView addSubview:imageViewHolder];
        [imageViewHolder setContentMode:UIViewContentModeCenter];

        
        //custom separator line
        UIView* separatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                             SCREEN_WIDTH, 1)];
        separatorLineView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:separatorLineView];
        
        
    }
    return self;
}


- (UIView *) cellViewIsSelected:(BOOL)isSelectedState
{
    
    UIView *cellBackground = [[UIView alloc]initWithFrame:SCREEN_FRAME];

    
    // draw custom selection view
    UIView *selectedView = [[UIView alloc]initWithFrame:SCREEN_FRAME];
    
    // draw the frame for the little view
    CGRect littleSelectedViewFrame      = CGRectZero;
    littleSelectedViewFrame.size.width  = 5;
    
    int multiplier = (isHeader) ? 2 : 1;
    
  
    littleSelectedViewFrame.size.height = SIDE_MENU_ROW_HEIGHT*multiplier;

    // create the little view
    UIView *littleSelectedView          = [[UIView alloc]initWithFrame:littleSelectedViewFrame];
    
    
    UIView* topSeparatorLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,
                                                                            SCREEN_WIDTH, 2)];
    
    if (isSelectedState)
    {
        [selectedView       setBackgroundColor:[UIColor whiteColor]];
        [littleSelectedView setBackgroundColor:CELL_LIGHT_BLUE];
        [topSeparatorLineView setBackgroundColor:[UIColor whiteColor]];


    }
    else
    {
        
        [selectedView       setBackgroundColor:(isHeader) ? [UIColor whiteColor] : CELL_LIGHT_GRAY];
        [littleSelectedView setBackgroundColor:CELL_HEAVY_GRAY];
        [topSeparatorLineView setBackgroundColor:[UIColor clearColor]];

    }

    
    [cellBackground addSubview:selectedView];
    [cellBackground addSubview:littleSelectedView];
    [cellBackground addSubview:topSeparatorLineView];
    
    return cellBackground;
}

// overwritten this to move the existing text label 50 px to the right
// so it wont overlay with the image
- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.textLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:12];
    
    CGSize size = self.bounds.size;
    CGRect frame = CGRectMake(80.0f, 0.0f, size.width, size.height);
    self.textLabel.frame =  frame;
    self.textLabel.contentMode = UIViewContentModeScaleAspectFit;
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted)
    {
        [imageViewHolder setTintColor:CELL_LIGHT_BLUE];
        [self.textLabel setTextColor:CELL_LIGHT_BLUE];
    }
    else
    {
        [imageViewHolder setTintColor:CELL_DARK_GRAY];
        [self.textLabel setTextColor:CELL_DARK_GRAY];
    }
}


@end
