//
//  UserPhotoNameView.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 15/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMNUserPhotoNameView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *imageViewHolder;
@property (weak, nonatomic) IBOutlet UILabel *nameTextHolder;


// add custom image to user basic info
- (void)addPic:(NSString*)imageName;

// add users name to menu
- (void)addName:(NSString*)userName;
@end
