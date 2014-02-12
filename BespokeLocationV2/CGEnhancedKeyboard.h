//
//  KSEnhancedKeyboard.m
//  CustomKeyboardForm
//
//  Created by Chiosa Gabi
//

#import <Foundation/Foundation.h>

// enum to determine if
// user pressed next/prev button
typedef enum
{
    CGEnhancedKeyboardNextTag,
    CGEnhancedKeyboardPreviousTag,
    CGEnhancedKeyboardDoneTag
}
CGEnhancedKeyboardTags;

// za delegate
@protocol CGEnhancedKeyboardDelegate

// methods sent to delegate
// so we know what button the
// user touched
- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType;


@end

@interface CGEnhancedKeyboard : NSObject
{
    int currentIndex;
    int numberOfTextFields;
    
    CGFloat heightOfKeyboard;
    
    id <CGEnhancedKeyboardDelegate> keyboardToolbarDelegate;
}
@property (nonatomic, strong) id <CGEnhancedKeyboardDelegate> keyboardToolbarDelegate;

@property int currentIndex;

// usefull to calculate the next tag
@property int numberOfTextFields;

// predefined height of keyboard
@property CGFloat heightOfKeyboard;

// this will return the tag for the next text field
// to become first responder
- (int)gimmieZaTag:(CGEnhancedKeyboardTags)tagType;

// returns the toolbar which will extend the keyboard
// with next/prev and done buttons
- (UIToolbar *)getExtendedToolbar;


// returns the toolbar with done button
- (UIToolbar *)getDoneToolbarl;

@end
