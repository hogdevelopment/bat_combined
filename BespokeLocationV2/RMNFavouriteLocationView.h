//
//  RMNFavouriteLocationView.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol RMNFavouriteLocationDelegate <NSObject>

// tells the delegate to remove the location
// from the content array
// and core data
- (void)removeFavouriteLocationFromSection:(int)indexPathSection;

@end

@interface RMNFavouriteLocationView : UITableViewCell

@property (nonatomic, strong) id <RMNFavouriteLocationDelegate> delegate;



@property (weak, nonatomic) IBOutlet UIImageView *imageViewHolderLocation;
@property (weak, nonatomic) IBOutlet UILabel *locationDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationStars;

@property int indexPathSection;


- (IBAction)removeLocationAction:(UIButton *)sender;

// round up the views corners
- (void)makeItRound;

// populate the view with information
- (void)populateWithInformationFrom:(NSDictionary*)locationInfo;


@end

