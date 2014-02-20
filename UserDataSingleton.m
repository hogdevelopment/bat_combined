//
//  UserDataSingleton.m
//  BespokeLocationV2
//
//  Created by shinoy on 2/7/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "UserDataSingleton.h"

@implementation UserDataSingleton

+(UserDataSingleton *)userSingleton
{
    static UserDataSingleton * user =nil;
    
    if (!user)
    {
        user=[[super allocWithZone:nil]init];
    }
    
    return user;
}

+(id)allocWithZone:(struct _NSZone *)zone
{
    return [self userSingleton];
}

-(id) init
{
    self=[super init];
    if(self)
    {
        _userName       = [[NSString alloc]init];
        _password       = [[NSString alloc]init];
        _email          = [[NSString alloc]init];
        _gender         = [[NSString alloc]init];
        _dateOfBirth    = [[NSDate alloc] init];
        
        _age            = [[NSString alloc]init];
        _photoUrl       = [[NSString alloc]init];

        
        _usingGigya         = YES;
        
        _isRegisteredWithNewAccount = NO;
        _isUsingFacebook            = NO;
        _isUsingFoursquare          = NO;
        _isUsingGoogle              = NO;
        _isUsingTwitter             = NO;
    }
    return self;
}

@end
