//
//  RMNEditProfileCell.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNEditProfileCell.h"


@interface RMNEditProfileCell()<CGEnhancedKeyboardDelegate>
{
    UITextField *textFieldInput;
    CGEnhancedKeyboard *enhancedKeyboard;
    int indexPathSection;
}

@end

@implementation RMNEditProfileCell

@synthesize textFieldInput      =   textFieldInput;
@synthesize keyboardDelegate    =   keyboardDelegate;
@synthesize indexPathSection    =   indexPathSection;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    
        textFieldInput = [[UITextField alloc]init];
        [textFieldInput setFrame:CGRectMake(0, 0, self.contentView.frame.size.width, 40)];
        [self.contentView addSubview:textFieldInput];

#warning KEYBOARD BUttons not working well. Must fix when rested
        enhancedKeyboard = [[CGEnhancedKeyboard alloc]init];
        [enhancedKeyboard setKeyboardToolbarDelegate:self];
        [textFieldInput setInputAccessoryView:[enhancedKeyboard getExtendedToolbar]];

    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [[self keyboardDelegate] userTouchedSection:indexPathSection];
    
}

- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType
{

     [[self keyboardDelegate] userDidTouchDown:tagType];
    
    if (tagType == CGEnhancedKeyboardDoneTag)
    {
        // scroll back to top
         [[self keyboardDelegate] userTouchedSection:0];
        [self.contentView endEditing:YES];
    }
    
   
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
