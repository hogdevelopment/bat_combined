//
//  RMNEditProfileCell.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGEnhancedKeyboard.h"

// za delegate
@protocol RMNEditProfileCellDelegate

// methods sent to delegate
// so we know what button the
// user touched
- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType;

- (void)userTouchedSection:(int)section;

- (void)animateToInitialState;


@end


@interface RMNEditProfileCell : UITableViewCell
{
    id <RMNEditProfileCellDelegate> keyboardDelegate;
    
}


@property (nonatomic, strong) id <RMNEditProfileCellDelegate> keyboardDelegate;

@property UITextField *textFieldInput;
@property (assign) int indexPathSection;


- (void)addPickerStuff;

@end
