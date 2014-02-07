//
//  DetailsTableViewViewController.h
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 30/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "databaseItem.h"
#import "FourSquareResturant.h"
@class ASStarRatingView;


@interface DetailsTableViewViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
     databaseItem *ObjectsToShow;
    FourSquareResturant *ObjectoToshowFromFourSquare;
    
}
@property (nonatomic, retain)  databaseItem *ObjectsToShow;
@property (nonatomic, retain)  FourSquareResturant *ObjectoToshowFromFourSquare;
@property (nonatomic, retain)  UIImageView *PlaceImageView;
@property (nonatomic, retain)  UIImage *PlaceImage;
@property (retain, nonatomic)  ASStarRatingView *staticStarRatingView;
@property (strong, nonatomic)  UITableView *mytableView;
@property (nonatomic, retain)  UIButton *favouriteButton;
@property (nonatomic, retain)  UIButton *MenuButton;

@end
