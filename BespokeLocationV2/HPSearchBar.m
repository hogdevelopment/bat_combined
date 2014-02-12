//
//  HPSearchBar.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 9/7/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "HPSearchBar.h"
//#import "HPLocationsMutableArray.h"


@implementation HPSearchBar

@synthesize searchDelegate;

- (id)initWithFrame:(CGRect)frame ofType:(SearchBarTypes)type
{
    self = [super initWithFrame:frame];
    if (self) {

    
        self.placeholder = NSLocalizedString(@"Users filters",nil);
        
        UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        numberToolbar.barStyle = UIBarButtonItemStylePlain;
        numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Cancel",nil)
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(cancelNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Search",nil)
                                                               style:UIBarButtonItemStyleBordered
                                                              target:self
                                                              action:@selector(doneWithNumberPad)],
                               nil];
        [numberToolbar sizeToFit];
        self.inputAccessoryView = numberToolbar;
        
        
    }
    return self;
}


- (void)cancelNumberPad
{
    [self resignFirstResponder];
}

- (void)doneWithNumberPad
{
    [self resignFirstResponder];
//    if ([[HPLocationsMutableArray searchString] count]>0)
//    {
//        [[HPLocationsMutableArray searchString]removeLastObject];
//    }
//    [[HPLocationsMutableArray searchString] addObject:self.text];
    [[self searchDelegate]userHitSearchButton];
    
    NSLog(@"IN SEARCH BAR TRIMITE");
}


// hide the magninfing glass image
- (void)setTextFieldLeftView:(UIView *)view
{
    UITextField *searchField = nil;
    for (UIView *subview in self.subviews)
    {
        if ([subview isKindOfClass:[UITextField class]])
        {
            searchField = (UITextField *)subview;
            break;
        }
    }
    
    if (searchField != nil)
    {
        searchField.leftView = view;
    }
}


@end
