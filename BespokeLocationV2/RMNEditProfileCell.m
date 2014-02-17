//
//  RMNEditProfileCell.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNEditProfileCell.h"
#import "CGEnhancedKeyboard.h"


@interface RMNEditProfilePageViewController
{
    UITextField *textField;
}

@end

@implementation RMNEditProfileCell

@synthesize textField   =   textField;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    
        textField = [[UITextField alloc]init];
        [textField setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 40)];
        [self.contentView addSubview:textField];
        
//        CGEnhancedKeyboard *enhancedKeyboard = [[CGEnhancedKeyboard alloc]init];
//        [textField setInputAccessoryView:[enhancedKeyboard getExtendedToolbar]];
#warning MUST IMPLEMENT FURTHER HERE
    }
    return self;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
