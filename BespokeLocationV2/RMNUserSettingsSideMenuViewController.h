//
//  RMNUserSettingsSideMenuViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMNSideMenuHeaderButtonsView.h"
#import "RMNEditProfilePageViewController.h"

@class RMNUserPhotoNameView;

// use this enumaration
// for a better read over the
// buttons which will be touched
// from the side menu
typedef enum
{
    RMNUserSettingsSideMenuUserFilters,
    RMNUserSettingsSideMenuSettings,
    RMNUserSettingsSideMenuFeedback,
    RMNUserSettingsSideMenuRateTheApp,
    RMNUserSettingsSideMenuShareTheApp,
    RMNUserSettingsSideMenuAbout,
    RMNUserSettingsSideMenuPrivacy,
    RMNUserSettingsSideMenuFAQs,
    RMNUserSettingsSideMenuLogout,
    RMNUserSettingsSideMenuFavourites,
    RMNUserSettingsSideMenuFilters,
    RMNUserSettingsSideMenuEditProfile
    
}
RMNUserSettingsSideMenuCellType;


// za delegate
@protocol RMNUserSettingsLefttSideMenuDelegate

// methods sent to delegate
// so we know what button the
// user touched, and load the corresponding page
- (void)userDidTouchDown:(RMNUserSettingsSideMenuCellType)menuType;


@end


@interface RMNUserSettingsSideMenuViewController : UITableViewController<RMNSideMenuButtonsDelegate,RMNUserProfileDelegate>
{
    id <RMNUserSettingsLefttSideMenuDelegate> sideMenuDelegate;
}
@property (nonatomic, strong) id <RMNUserSettingsLefttSideMenuDelegate> sideMenuDelegate;


@property (nonatomic, strong) RMNUserPhotoNameView *userHeaderView;

@end
