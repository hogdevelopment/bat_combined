//
//  HPCell.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 9/5/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "RMNFilterSideMenuCell.h"

// initial
//021d23

//063b45
NSString* const AppCellNormalStateBg     = @"01161b";
NSString* const AppCellSelectedStateBg   = @"063b45";
NSString* const FontNormalStateColor     = @"000000";
NSString* const FontSelectedStateColor   = @"000000";



int       const CellTitleNewFontSize     = 15;


@implementation RMNFilterSideMenuCell


- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        

             // draw custom selection view
        UIView *selectedView = [[UIView alloc]init];
        [selectedView setFrame:[self bounds]];
        [selectedView setBackgroundColor:[UIColor colorWithHexString:AppCellSelectedStateBg ]];
        
        // set the custom selected view for the cell
        [self setSelectedBackgroundView:selectedView];
        
        // hide default accessory
        [self setAccessoryType :UITableViewCellAccessoryNone];
        
        

    }
    return self;
}




// overwrite it to obtain the custom colors
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    if (selected)
    {
        // if selected the background and the text changes color
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:AppCellSelectedStateBg ]];
    
    
    }
    else
    {
        // if not selected the background and the text remains the same
        // or changes the color back to it's original state
        [self.contentView setBackgroundColor:[UIColor colorWithHexString:AppCellNormalStateBg ]];
    }
    // Configure the view for the selected state
}

@end
