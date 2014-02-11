//
//  RMNUserSettingsSideMenuViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    RMNUserSettingsSideMenuDistance,
    RMNUserSettingsSideMenuFeedback,
    RMNUserSettingsSideMenuHelpImprove,
    RMNUserSettingsSideMenuRateTheApp,
    RMNUserSettingsSideMenuShareTheApp,
    RMNUserSettingsSideMenuAbout,
    RMNUserSettingsSideMenuPrivacy,
    RMNUserSettingsSideMenuTermsOfService
    
    
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
