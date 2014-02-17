//
//  RMNManager.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNManager.h"

@implementation RMNManager

@synthesize isLoggedIn,menuShouldBeOpened;
@synthesize userNameText,profileImageLocation;
@synthesize usersJoiningDate;
@synthesize alreadyShownIntro;

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
        
        // to be changed
#warning Must load name and image from data base
        profileImageLocation        =   @"profile";
        userNameText                =   @"Chiosa Gabi";
        usersJoiningDate            =   [NSDate date];
        menuShouldBeOpened          =   NO;
    }
    return self;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
}

 
@end
