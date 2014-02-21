//
//  RMNEditProfileCell.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNEditProfileCell.h"
#import "NSDate+Stringifier.h"

@interface RMNEditProfileCell()<CGEnhancedKeyboardDelegate, UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
{
    UITextField *textFieldInput;
    CGEnhancedKeyboard *enhancedKeyboard;
    int indexPathSection;
    NSArray     *infos;

}

@property NSArray *infos;


@end

@implementation RMNEditProfileCell

@synthesize infos               =   infos;
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

        enhancedKeyboard = [[CGEnhancedKeyboard alloc]init];
        [enhancedKeyboard setKeyboardToolbarDelegate:self];
        [textFieldInput setInputAccessoryView:[enhancedKeyboard getExtendedToolbar]];
        [textFieldInput setEnabled:YES];
        [textFieldInput setDelegate:self];
        
    }
    return self;
}


- (void)addPickerStuff
{
    
    switch (indexPathSection)
    {
        case 2:
        {
            // create the picker view
            UIPickerView * picker = [UIPickerView new];
            picker.delegate = self;
            picker.dataSource = self;
            picker.showsSelectionIndicator = YES;
            
            NSArray *genderInfo = @[NSLocalizedString(@"Male", nil),
                                    NSLocalizedString(@"Female", nil),];

            infos = genderInfo;
            [textFieldInput setInputView:picker];
            break;
        }
        case 3:
        {
            UIDatePicker *picker = [UIDatePicker new];
            [textFieldInput setInputView:picker];
            picker.datePickerMode = UIDatePickerModeDate;

            [picker addTarget:self action:@selector(changedPickerDateValues:)
                 forControlEvents:UIControlEventValueChanged];

            break;
        }
            
        default:
            break;
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (indexPathSection == 5)
    {
        [textField setSecureTextEntry:YES];
    }
    
    [[self keyboardDelegate] userTouchedSection:indexPathSection];
    
}

- (void)userDidTouchDown:(CGEnhancedKeyboardTags)tagType
{

    [[self keyboardDelegate] updateSection:indexPathSection];
    if (tagType == CGEnhancedKeyboardDoneTag)
    {

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


#pragma MARK - UIPicker View Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component {
    return [infos count];;
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    
    NSString * title = [infos objectAtIndex:row];
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{

    [textFieldInput setText:[infos objectAtIndex:row ]];
}

#pragma  UIDatePickerView method

- (void)changedPickerDateValues:(UIDatePicker*) datePickerView
{

    
    [textFieldInput setText: [datePickerView.date dayMonthYearification]];
}



@end
