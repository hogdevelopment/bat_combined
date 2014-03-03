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


@property NSDictionary *venueInfo;
@property UITableView *infoTable;
@end
/*


 @"http://static.comicvine.com/uploads/original/14/145849/2814973-robert_majkut_design_cinema_multikino_velvet_bar.jpg",
 @"http://activate.metroactive.com/files/2013/06/silicon-valley-bar-crawl-620x459.jpg",
 @"http://www.jeffkorhan.com/images/2012/05/2012.5.3-Crowded-Bar.jpg",
 nil]];


*/