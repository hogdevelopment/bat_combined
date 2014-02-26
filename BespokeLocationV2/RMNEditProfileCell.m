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
    UIButton *customButton;
}

@property NSArray *infos;
@property UIButton *customButton;

@end

@implementation RMNEditProfileCell

@synthesize customButton        =   customButton;
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
        
         textFieldInput.font = [UIFont fontWithName:@"Helvetica-Light" size:14];
        [textFieldInput setTextColor:CELL_LIGHT_BLUE];
        [textFieldInput setFrame:CGRectMake(10, 0, 260, 40)];

        [self.contentView addSubview:textFieldInput];

        enhancedKeyboard = [[CGEnhancedKeyboard alloc]init];
        [enhancedKeyboard setKeyboardToolbarDelegate:self];
        [textFieldInput setInputAccessoryView:[enhancedKeyboard getExtendedToolbar]];
        [textFieldInput setEnabled:YES];
        [textFieldInput setDelegate:self];
        
    }
    return self;
}

- (void)configureExtraAccessory
{
    RMNTextFieldAccessory type = (indexPathSection == 2 || indexPathSection == 3) ?
                                                        RMNTextFieldShowMoreAccessory:
                                                        RMNTextFieldDeleteAccessory;
    [self showButton:type];
    [self checkAccessoryStatusWithString:textFieldInput.text];

}



- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *stringTest = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    [self checkAccessoryStatusWithString:stringTest];
    return YES;
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

    [self configureExtraAccessory];
    
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


#pragma custom private methods
#pragma mark - Custom accessory method


- (void)checkAccessoryStatusWithString:(NSString*)stringTest
{
    if ([stringTest length] == 0)
    {
        // do not show the custom buttons
        [customButton setHidden:YES];
    }
    else
    {
        [customButton setHidden:NO];
        
    }
}


- (void)showButton:(RMNTextFieldAccessory)type
{
    
    NSString *imageName;
    
    
    CGRect imageFrame = CGRectMake(0, 0, 11, 12);
    if (!customButton)
    {
        customButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [customButton setFrame:imageFrame];
        
        switch (type)
        {
            case RMNTextFieldDeleteAccessory:
            {
                imageName = @"clearContent";
                [customButton addTarget:self action:@selector(clearTextField) forControlEvents:UIControlEventTouchUpInside];
                
                break;
            }
            case RMNTextFieldShowMoreAccessory:
            {
                imageName = @"showMoreInfoToChoseFromArrow";
                [customButton addTarget:textFieldInput action:@selector(becomeFirstResponder) forControlEvents:UIControlEventTouchUpInside];
                
                break;
            }
            default:
                break;
        }
        
        UIImage *image = [UIImage imageNamed:imageName];
        [customButton setImage:image forState:UIControlStateNormal];
    }
    
    textFieldInput.rightViewMode = UITextFieldViewModeAlways; //can be changed to UITextFieldViewModeNever,    UITextFieldViewModeWhileEditing,   UITextFieldViewModeUnlessEditing
    [textFieldInput setRightView:customButton];
    
    
}
- (void)clearTextField
{
    [textFieldInput setText:@""];
    [customButton setHidden:YES];
}


@end
