//
//  RMNVenueInformationViewController.h
//  BespokeLocationV2
//
//  Created by infodesign on 2/20/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMNVenueInformationCell.h"

@interface RMNVenueInformationViewController : UIViewController<UITableViewDataSource, UITableViewDelegate, RMNCellVenueInformationDelegate>
{
    UITableView *infoTable;
}


@end
