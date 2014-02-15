//
//  RMNSideMenuHeaderButtonsView.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 14/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNSideMenuHeaderButtonsView.h"

@implementation RMNSideMenuHeaderButtonsView

@synthesize headerViewDelegate  =   headerViewDelegate;



- (void) addInfo
{

    [self.favouritesLabel   setText:NSLocalizedString(@"Favourites",nil)];
    [self.filtersLabel      setText:NSLocalizedString(@"Filters",nil)];
    [self.editProfileLabel  setText:NSLocalizedString(@"Edit Profile",nil)];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)headerMenuButtonsAction:(id)sender
{
   [self.headerViewDelegate userTouched:((UIButton*)sender).tag];
}
@end
