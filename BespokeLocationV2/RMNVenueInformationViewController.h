//
//  RMNVenueInformationViewController.h
//  BespokeLocationV2
//
//  Created by infodesign on 2/20/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMNVenueInformationCell.h"

@interface RMNVenueInformationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, RMNCellVenueInformationDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate>
{
    UITableView *infoTable;
}


@property NSDictionary *venueInfo;
@property UITableView *infoTable;

@property (weak, nonatomic) IBOutlet UIButton *callButt;
@property (weak, nonatomic) IBOutlet UIButton *getThereButt;
@property (weak, nonatomic) IBOutlet UIImageView *bgUnderButtons;


- (IBAction)callAction:(id)sender;
- (IBAction)getThereAction:(id)sender;

@end
