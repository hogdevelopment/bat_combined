//
//  ImagesCell.m
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 31/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "ImagesCell.h"

@implementation ImagesCell

@synthesize ImageViews;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
                ImageViews = [[NSMutableArray alloc] init];
           }
    return self;
}

- (void)setImages {
    
    for (int i = 0; i < ImageViews.count ; i++) {
        
        [self addSubview:ImageViews[i]];
        
    }

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
