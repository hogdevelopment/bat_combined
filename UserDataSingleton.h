//
//  UserDataSingleton.h
//  BespokeLocationV2
//
//  Created by shinoy on 2/7/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LogInView.h"
@interface UserDataSingleton : NSObject

@property (nonatomic,strong) NSString * nickName;
@property (nonatomic,strong) NSString * firstName;
@property (nonatomic,strong) NSString * password;
@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSString * age;
@property (nonatomic,strong) NSString * gender;
@property (nonatomic) BOOL            * usingGigya;



+(UserDataSingleton *) userSingleton;

@end

