//
//  CallGetThereView.h
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 31/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallGetThereView : UIView{

UIButton *getThere;

}
@property (nonatomic, retain) UIButton *getThere;

- (id)initWithFrame:(CGRect)frame phone:(bool)IsThereAPhoneNumber;

@end
