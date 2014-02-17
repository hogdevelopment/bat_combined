//
//  RMNManager.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMNManager : NSObject
{
    BOOL isLoggedIn;
    BOOL menuShouldBeOpened;
    
    NSString *profileImageLocation;
    NSString *userNameText;
    NSDate   *usersJoiningDate;
}

@property  BOOL isLoggedIn;
@property  BOOL menuShouldBeOpened;

@property   NSString *profileImageLocation;
@property   NSString *userNameText;
@property   NSDate   *usersJoiningDate;

+ (id)sharedManager;

@end
