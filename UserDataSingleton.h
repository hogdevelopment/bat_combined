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

@property (nonatomic,strong) NSString * email;
@property (nonatomic,strong) NSString * userName;
@property (nonatomic,strong) NSString * password;
@property (nonatomic,strong) NSString * gender;
@property (nonatomic,strong) NSDate   * dateOfBirth;
@property (nonatomic) BOOL              isUsingFacebook;
@property (nonatomic) BOOL              isUsingTwitter;
@property (nonatomic) BOOL              isUsingGoogle;
@property (nonatomic) BOOL              isUsingFoursquare;
@property (nonatomic) BOOL              isRegisteredWithNewAccount;

@property (nonatomic) BOOL              usingGigya;
@property (nonatomic,strong) NSString * age;
@property (nonatomic,strong) NSString * photoUrl;




+(UserDataSingleton *) userSingleton;

@end

