//
//  RMNSideMenuHeaderButtonsView.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 14/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNSideMenuHeaderButtonsView.h"

@implementation RMNSideMenuHeaderButtonsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}


- (void) addInfo
{

    
    [self.favouritesLabel setText:NSLocalizedString(@"Favourites",nil)];
    [self.favouritesLabel setText:NSLocalizedString(@"Filters",nil)];
    [self.favouritesLabel setText:NSLocalizedString(@"Edit Profile",nil)];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction)headerMenuButtonsAction:(id)sender {
}
@end
