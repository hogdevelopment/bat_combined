//
//  RMNEditProfileCell.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGEnhancedKeyboard.h"

typedef enum
{
    RMNTextFieldDeleteAccessory,
    RMNTextFieldShowMoreAccessory
}RMNTextFieldAccessory;

// za delegate
@protocol RMNEditProfileCellDelegate

// methods sent to delegate
// so we know what button the
// user touched
- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType;

- (void)userTouchedSection:(int)section;

- (void)animateToInitialState;

- (void)updateSection:(int)section;


@end


@interface RMNEditProfileCell : UITableViewCell
{
    id <RMNEditProfileCellDelegate> keyboardDelegate;
    
}


@property (nonatomic, strong) id <RMNEditProfileCellDelegate> keyboardDelegate;

@property UITextField *textFieldInput;
@property (assign) int indexPathSection;

// adds a picker view for the current text field
- (void)addPickerStuff;

// shows custom button for changing the info in the text field through
// a picker view or
// shows a custom clear content button
- (void)configureExtraAccessory;
@end
