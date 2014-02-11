//
//  RMNFiltersScrollView.m
//  BespokeLocationV2
//
//  Created by Aura on 2/11/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFiltersScrollView.h"
#import "UIColor+HexRecognition.h"

@implementation RMNFiltersScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self createFiltersList];
    }
    return self;
}

- (void) createFiltersList
{
    [self setBackgroundColor:[UIColor colorWithHexString:@"e9e9e9"]];
    
    CGRect frame = self.frame;
    frame.origin.x = 0;
    frame.origin.y = 0;
    
    // create the scroll view for the filters
    filtersScrollView = [[UIScrollView alloc] initWithFrame:frame];
    [filtersScrollView setDelegate:self];
    filtersScrollView.showsVerticalScrollIndicator = NO;
    
    arrayWithFilters = [[NSMutableArray alloc] initWithObjects:
                        NSLocalizedString(@"Hotel Bars",nil),
                        NSLocalizedString(@"Bars",nil),
                        NSLocalizedString(@"Pubs",nil),
                        NSLocalizedString(@"Cafes",nil),
                        NSLocalizedString(@"Restaurants",nil),
                        NSLocalizedString(@"Lounges",nil),
                        NSLocalizedString(@"Clubs",nil),
                        nil];
    
    int index = 1;
    CGFloat lastX = 10;
    
    // create buttons for every filter
    for (NSString *name in arrayWithFilters) {
        
        UIButton *butt = [[UIButton alloc] init];
        [butt setTitle:name forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [butt setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];

        [butt sizeToFit];
        [butt addTarget:self action:@selector(selectFilter:) forControlEvents:UIControlEventTouchUpInside];
        
        CGRect newFrame = CGRectMake(lastX, 0, butt.frame.size.width, frame.size.height);
        [butt setFrame:newFrame];
        
        lastX += butt.frame.size.width + 25;
        
        [butt setTag:index];
        index ++;
        
        [filtersScrollView addSubview:butt];
    }
    
    // resize content size
    [filtersScrollView setContentSize:CGSizeMake(lastX, 50)];
    
    [self addSubview:filtersScrollView];
    
    // init cancel and save filter buttons
    cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 145, 40)];
    [cancelButton setTitle:NSLocalizedString(@"Clear filter",nil) forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton setBackgroundColor:[UIColor colorWithHexString:@"6d6f71"]];
    cancelButton.layer.cornerRadius = 5;
    [cancelButton addTarget:self action:@selector(changeBgColor:) forControlEvents:UIControlEventTouchDown];
    [cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    
    saveButton = [[UIButton alloc] initWithFrame:CGRectMake(165, 5, 145, 40)];
    [saveButton setTitle:NSLocalizedString(@"Save filter",nil) forState:UIControlStateNormal];
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setBackgroundColor:[UIColor colorWithHexString:@"6d6f71"]];
    saveButton.layer.cornerRadius = 5;
    [saveButton addTarget:self action:@selector(changeBgColor:) forControlEvents:UIControlEventTouchDown];
    [saveButton addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:cancelButton];
    [self addSubview:saveButton];

    cancelButton.alpha = 0;
    saveButton.alpha = 0;
}


#pragma - UIScrollView Delegate Methods
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    UIButton *butt = (UIButton *) [scrollView viewWithTag:1];

}



#pragma - UIButtons Methods

- (void) selectFilter: (UIButton *) butt
{
    NSLog(@"%@ filter", butt.titleLabel.text);
    
    cancelButton.alpha = 1;
    saveButton.alpha = 1;
    filtersScrollView.alpha = 0;
}


- (void) changeBgColor: (UIButton *) butt
{
    [butt setBackgroundColor:[UIColor colorWithHexString:@"ee5c31"]];
}


- (void) cancelAction: (UIButton *) butt
{
    // do this so the user can see the background color of the button changing
    [self performSelector:@selector(cancelAfterDelay) withObject:Nil afterDelay:0.1];
}

- (void) cancelAfterDelay
{
    cancelButton.alpha = 0;
    saveButton.alpha = 0;
    filtersScrollView.alpha = 1;
    
    [cancelButton setBackgroundColor:[UIColor colorWithHexString:@"6d6f71"]];
    [saveButton setBackgroundColor:[UIColor colorWithHexString:@"6d6f71"]];
}

#warning not done here, save method needs to do more!
- (void) saveAction: (UIButton *) butt
{
    // do this so the user can see the background color of the button changing
    [self performSelector:@selector(cancelAfterDelay) withObject:Nil afterDelay:0.1];
}


@end
