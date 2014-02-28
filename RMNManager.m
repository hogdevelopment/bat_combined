//
//  RMNManager.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNManager.h"

@implementation RMNManager

@synthesize isLoggedIn              =   isLoggedIn;
@synthesize menuShouldBeOpened      =   menuShouldBeOpened;
@synthesize userNameText            =   userNameText;
@synthesize profileImageLocation    =   profileImageLocation;
@synthesize usersJoiningDate        =   usersJoiningDate;
@synthesize alreadyShownIntro       =   alreadyShownIntro;
@synthesize currentUserEmail        =   currentUserEmail;

#pragma mark Singleton Methods

+ (id)sharedManager {
    static RMNManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init])
    {
        // load the bool from nsuserdefaults. We don't wanna load
        // the login proceess every time the user starts the app
        NSUserDefaults *defaults    =   [NSUserDefaults standardUserDefaults];
        isLoggedIn                  =   [defaults boolForKey:@"isLoggedIn"];
        
        alreadyShownIntro           =   [defaults boolForKey:@"alreadyShownIntro"];
        
        currentUserEmail            =   [defaults objectForKey:@"currentLoggedInUserEmail"];

        
        // to be changed
#warning Must load name and image from data base
        profileImageLocation        =   @"profilePic";
        userNameText                =   @"Chiosa Gabi";
        usersJoiningDate            =   [NSDate date];
        menuShouldBeOpened          =   NO;
    }
    return self;
}



@end
