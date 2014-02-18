//
//  RMNFavouriteLocationView.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNFavouriteLocationView : UITableViewCell
- (IBAction)removeLocationAction:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewHolderLocation;
@property (weak, nonatomic) IBOutlet UILabel *locationDescriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationStars;


- (void)makeItRound;
@end
