//
//  RMNFiltersScrollView.h
//  BespokeLocationV2
//
//  Created by Aura on 2/11/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface RMNFiltersScrollView : UIView <UIScrollViewDelegate>
{
    UIScrollView   *filtersScrollView;
    NSMutableArray *arrayWithFilters;
    
    UIButton *cancelButton, *saveButton;
}

@end
