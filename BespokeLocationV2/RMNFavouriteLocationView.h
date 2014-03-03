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

/*

city = "Z\U00fcrich";
contactPhone = "";
contactTwitter = "";
country = Schweiz;
distance = 129;
"foursquare_id" = 4b856505f964a520085b31e3;
"foursquare_verified" = 0;
latitude = 47;
localAddress = "Bahnhofstrasse 25,Z\U00fcrich,";
longitude = 8;
name = "Restaurant B\U00e4rengasse";
new = 0;
"rating_count" = 0;
smokingRatingAverage = 0;
smokingRatingCount = 0;
smokingRatingTotal = 0;

*/