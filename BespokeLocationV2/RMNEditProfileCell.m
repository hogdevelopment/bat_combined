//
//  RMNEditProfileCell.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNEditProfileCell.h"


@interface RMNEditProfileCell()<CGEnhancedKeyboardDelegate, UITextFieldDelegate>
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
        [textFieldInput setFrame:CGRectMake(10, 0, self.contentView.frame.size.width, 40)];
        [self.contentView addSubview:textFieldInput];

#warning KEYBOARD BUttons not working well. Must fix when rested
        enhancedKeyboard = [[CGEnhancedKeyboard alloc]init];
        [enhancedKeyboard setKeyboardToolbarDelegate:self];
        [textFieldInput setInputAccessoryView:[enhancedKeyboard getExtendedToolbar]];
        [textFieldInput setEnabled:YES];
        [textFieldInput setDelegate:self];
        
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"VREA S[ INCEAPA CEVA cu %D",indexPathSection);
    
    if (indexPathSection == 5)
    {
        [textField setSecureTextEntry:YES];
    }
    
    [[self keyboardDelegate] userTouchedSection:indexPathSection];
    
}

- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType
{

    if (tagType == CGEnhancedKeyboardDoneTag)
    {
        // scroll back to top
//         [[self keyboardDelegate] userTouchedSection:0];
        [self.contentView endEditing:YES];
        [[self keyboardDelegate]animateToInitialState];
    }
    else
    {
        [[self keyboardDelegate] userDidTouchDown:tagType];
    }
    
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
