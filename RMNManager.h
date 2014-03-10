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
    BOOL alreadyShownIntro;
    
    NSString *userNameText;
    
    
    
    NSString *userUniqueId;
    NSString *userFirstName;
    NSString *userLastName;
    NSString *userGender;
    NSString *userAgeVerification;
    
    
    NSDate *usersJoiningDate;
    
    NSString *currentUserEmail;
    
    NSMutableArray *markers;
    
    NSArray *locationsArray;
}

@property  BOOL isLoggedIn;
@property  BOOL menuShouldBeOpened;
@property  BOOL alreadyShownIntro;

@property NSDate *usersJoiningDate;

@property NSString *userUniqueId;
@property NSString *userFirstName;
@property NSString *userLastName;
@property NSString *userGender;
@property NSString *userAgeVerification;


@property   NSString *userNameText;


@property   NSString *currentUserEmail;


@property NSMutableArray *markers;
@property NSArray *locationsArray;

+ (id)sharedManager;


// change users info
+ (void)updateUsersWith:(NSDictionary*)userInfo;


@end
