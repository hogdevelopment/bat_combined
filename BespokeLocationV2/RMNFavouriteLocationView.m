//
//  RMNFavouriteLocationView.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFavouriteLocationView.h"
#import <QuartzCore/QuartzCore.h>


@implementation RMNFavouriteLocationView

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // add rouned cornes to the table
        
        self.layer.cornerRadius = 4;
        self.layer.masksToBounds = YES;

        
        
    }
    return self;
}

- (void)makeItRound
{
    self.layer.cornerRadius = 4;
    self.layer.masksToBounds = YES;
}

-(void)awakeFromNib
{
   ;
//    [self addSubview:self.nibview];
}

- (void)removeLocationAction:(UIButton *)sender
{
    NSLog(@"STERGE LOCATIA");
}
@end
