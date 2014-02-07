//
//  ImagesCell.h
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 31/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImagesCell : UITableViewCell{
    
    NSMutableArray *ImageViews;
}
@property (nonatomic, retain) NSMutableArray *ImageViews;
- (void)setImages;
@end
