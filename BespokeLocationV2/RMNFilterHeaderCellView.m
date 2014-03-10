//
//  RMNFilterHeaderCellView.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 10/03/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFilterHeaderCellView.h"

@implementation RMNFilterHeaderCellView

- (id)init
{
    self = [super init];
    if (self)
    {
        NSLog(@"aa juns la init");
    
    // add rouned cornes to the table
    self.backgroundView.layer.cornerRadius = 4;
    self.backgroundView.layer.masksToBounds = YES;
    }
    return self;
}

- (void)prepareForReuse
{
    NSLog(@"aa juns la prepareForReuse");
//
//    // add rouned cornes to the table
//    self.backgroundView.layer.cornerRadius = 4;
//    self.backgroundView.layer.masksToBounds = YES;
}



@end
