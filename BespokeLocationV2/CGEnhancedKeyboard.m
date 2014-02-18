//
//  KSEnhancedKeyboard.m
//  CustomKeyboardForm
//
//  Created by Chiosa Gabi
//

#import "CGEnhancedKeyboard.h"

@implementation CGEnhancedKeyboard
#warning MUST MAKE THIS DYNAMIC
// now it works only for max 9 text fields

@synthesize currentIndex        = currentIndex;
@synthesize numberOfTextFields  = numberOfTextFields;
@synthesize keyboardToolbarDelegate, heightOfKeyboard;

- (UIToolbar *)getExtendedToolbar
{
    heightOfKeyboard = 300;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] init];
    
    NSArray *elements = [NSArray arrayWithObjects:@"Precedentul", @"Următorul", nil];
    UISegmentedControl *leftItems = [[UISegmentedControl alloc] initWithItems:elements];
    
    leftItems.segmentedControlStyle = UISegmentedControlStyleBar;
    
    // do not preserve button's state
    leftItems.momentary = YES;
    [leftItems addTarget:self
                  action:@selector(nextPrevHandlerDidChange:)
        forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *nextPrevControl = [[UIBarButtonItem alloc] initWithCustomView:leftItems];
    [toolbarItems addObject:nextPrevControl];
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc]
                                 initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                      target:self
                                                      action:nil];
    
    [toolbarItems addObject:flexSpace];
    
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]
                                   initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                        target:self
                                                        action:@selector(doneDidClick:)];
    
    [toolbarItems addObject:doneButton];
    
    toolbar.items = toolbarItems;
    
    return toolbar;
}

- (UIToolbar *)getDoneToolbarl
{
    heightOfKeyboard = 300;
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar sizeToFit];
    
    NSMutableArray *toolbarItems = [[NSMutableArray alloc] init];
    
       
    UIBarButtonItem *doneButton =[[UIBarButtonItem alloc]
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                  target:self
                                  action:@selector(doneDidClick:)];
    
    [toolbarItems addObject:doneButton];
    
    toolbar.items = toolbarItems;
    
    return toolbar;
}

- (void)nextPrevHandlerDidChange:(id)sender
{
    if (![self keyboardToolbarDelegate]) return;
    
    // send message to the delegate
    // so we know which button was touched
    switch ([(UISegmentedControl *)sender selectedSegmentIndex])
    {
        case 0:
            [[self keyboardToolbarDelegate] userDidTouchDown:CGEnhancedKeyboardPreviousTag];
            break;
        case 1:
            [[self keyboardToolbarDelegate] userDidTouchDown:CGEnhancedKeyboardNextTag];
            break;
        default:
            break;
    }
}

- (void)doneDidClick:(id)sender
{
    // tell the app it's time to remove
    // the keyboard
    NSLog(@"AJUNGE LA DONE DID CLICK");
    
    if (![self keyboardToolbarDelegate]) return;
    [[self keyboardToolbarDelegate] userDidTouchDown:CGEnhancedKeyboardDoneTag];
}

- (int) gimmieZaTag:(CGEnhancedKeyboardTags)tagType
{
    int zaNextTag = 0;
    
    switch (tagType) {
        case CGEnhancedKeyboardNextTag:
        {
            zaNextTag = [self desiredTag:currentIndex % 10];
            break;
        }
        case CGEnhancedKeyboardPreviousTag:
        {
            zaNextTag = [self desiredTag:currentIndex / 100];
            break;
        }
        default:
            break;
    }
    
    return zaNextTag;
}

- (int) desiredTag:(int)textFieldIndex
{
    // we now have just the index of the textfield
    int tag = textFieldIndex;
    
    
    // the structure of the tag is:
    // prev index _ current index + next index
    // this just eliminates the use of an array
    
    int prev = (textFieldIndex == 1) ? numberOfTextFields : textFieldIndex-1;
    int next = (textFieldIndex == numberOfTextFields) ? 1 : textFieldIndex+1;

    tag = 100*prev + textFieldIndex*10 + next;
    
    return tag;
    
}
@end
