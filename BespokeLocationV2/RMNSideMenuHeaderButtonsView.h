//
//  RMNSideMenuHeaderButtonsView.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 14/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    RMNSideMenuHeaderFavouriteButton,
    RMNSideMenuHeaderFiltersButton,
    RMNSideMenuHeaderEditProfileButton
}
RMNSideMenuHeaderButtonType;

@protocol RMNSideMenuButtonsDelegate

// method sent to the delegate
// which will load the detail view
// for za selected location
- (void)userTouched:(RMNSideMenuHeaderButtonType)buttonType;

@end




@interface RMNSideMenuHeaderButtonsView : UIView
{
    id <RMNSideMenuButtonsDelegate>  headerViewDelegate;

}
                     
                     
@property  id  <RMNSideMenuButtonsDelegate>  headerViewDelegate;

- (IBAction)headerMenuButtonsAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *favouritesLabel;
@property (weak, nonatomic) IBOutlet UILabel *filtersLabel;
@property (weak, nonatomic) IBOutlet UILabel *editProfileLabel;

// populate views with text
- (void) addInfo;

@end
