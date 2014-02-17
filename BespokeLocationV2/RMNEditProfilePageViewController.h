//
//  RMNEditProfilePageViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNEditProfilePageViewController : UIViewController<UITableViewDataSource,
                                                               UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImageHolder;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *usersJoiningDate;
@property (weak, nonatomic) IBOutlet UITableView *tableView;





@end
