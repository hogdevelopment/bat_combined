//
//  RMNEditProfilePageViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RMNUserProfileDelegate
// methods sent to delegate
// so we know when the user updates his profile
- (void)userUpdatedProfile;

@end




@interface RMNEditProfilePageViewController : UIViewController<UITableViewDataSource,
                                                               UITableViewDelegate>
{
        id <RMNUserProfileDelegate> delegate;
}


@property (strong, nonatomic) IBOutlet UIImageView  *profileImageHolder;
@property (weak, nonatomic) IBOutlet UILabel        *userName;
@property (weak, nonatomic) IBOutlet UILabel        *usersJoiningDate;
@property (weak, nonatomic) IBOutlet UITableView    *tableView;
@property (weak, nonatomic) IBOutlet UILabel *profileHeaderLabel;



@property (nonatomic, strong) id <RMNUserProfileDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

- (IBAction)changePicture:(id)sender;

@end




