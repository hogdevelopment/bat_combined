//
//  CallGetThereView.m
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 31/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "CallGetThereView.h"


@implementation CallGetThereView

@synthesize getThere;

- (id)initWithFrame:(CGRect)frame phone:(bool)IsThereAPhoneNumber
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // This means the Venue had no Phone Number so let us hide the call button
        if(IsThereAPhoneNumber == false){
            
            UIImage *lineImage = [UIImage imageNamed:@"line.png"];
            UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 0.5)];
            lineImageView.image = lineImage;
            [self addSubview:lineImageView];

            getThere = [UIButton buttonWithType:UIButtonTypeCustom];
            UIImage *GetThereImage = [UIImage imageNamed:@"get-there-button.png"];
            getThere.frame = CGRectMake(85, 20, 141, 43);
            [getThere setImage:GetThereImage forState:UIControlStateNormal];
           
            [self addSubview:getThere];

            
        }
        else
            
        {
        
        UIImage *lineImage = [UIImage imageNamed:@"line.png"];
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 0.5)];
        lineImageView.image = lineImage;
        [self addSubview:lineImageView];
        
        UIButton *btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *CallImage = [UIImage imageNamed:@"call-button.png"];
        btnCall.frame = CGRectMake(10, 20, 141, 43);
        [btnCall setImage:CallImage forState:UIControlStateNormal];
        
        [self addSubview:btnCall];
        
        
        getThere = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *GetThereImage = [UIImage imageNamed:@"get-there-button.png"];
        getThere.frame = CGRectMake(170, 20, 141, 43);
        [getThere setImage:GetThereImage forState:UIControlStateNormal];
            
        [self addSubview:getThere];
        }
        
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
