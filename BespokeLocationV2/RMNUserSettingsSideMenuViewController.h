//
//  RMNUserSettingsSideMenuViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

// use this enumaration
// for a better read over the
// buttons which will be touched
// from the side menu
typedef enum
{
    RMNUserSettingsSideMenuDistance,
    RMNUserSettingsSideMenuFeedback,
    RMNUserSettingsSideMenuHelpImprove,
    RMNUserSettingsSideMenuRateTheApp,
    RMNUserSettingsSideMenuShareTheApp,
    RMNUserSettingsSideMenuAbout,
    RMNUserSettingsSideMenuPrivacy,
    RMNUserSettingsSideMenuTermsOfService,
    RMNUserSettingsSideMenuFAQs
    
    
}RMNUserSettingsSideMenuCellType;


// za delegate
@protocol RMNUserSettingsLefttSideMenuDelegate

// methods sent to delegate
// so we know what button the
// user touched, and load the corresponding page
- (void)userDidTouchDown:(RMNUserSettingsSideMenuCellType)menuType;


@end


@interface RMNUserSettingsSideMenuViewController : UITableViewController
{
    id <RMNUserSettingsLefttSideMenuDelegate> sideMenuDelegate;
}
@property (nonatomic, strong) id <RMNUserSettingsLefttSideMenuDelegate> sideMenuDelegate;

@end
