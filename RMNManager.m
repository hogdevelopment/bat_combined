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
@synthesize alreadyShownIntro       =   alreadyShownIntro;
@synthesize currentUserEmail        =   currentUserEmail;

@synthesize userAgeVerification     =   userAgeVerification;
@synthesize userFirstName           =   userFirstName;
@synthesize userLastName            =   userLastName;
@synthesize userGender              =   userGender;
@synthesize userUniqueId            =   userUniqueId;
@synthesize usersJoiningDate        =   usersJoiningDate;
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
        
        
        
        userUniqueId        = [defaults valueForKey:@"userId"];
        userLastName        = [defaults valueForKey:@"userLastName"];
        userFirstName       = [defaults valueForKey:@"userFirstName"];
        userGender          = [defaults valueForKey:@"userGender"];
        userAgeVerification = [defaults valueForKey:@"userAgeVerification"];
        userNameText        = [defaults valueForKey:@"userNameText"];
        
        usersJoiningDate    = [defaults objectForKey:@"registrationDate"];
        
        menuShouldBeOpened          =   NO;
    }
    return self;
}

+ (void)updateUsersWith:(NSDictionary*)userInfo
{
    NSLog(@"UDPATE FA");
    // logout user
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSArray *keys = [userInfo allKeys];
    for (NSString *key in keys)
    {
        NSLog(@"SINcronizeaza %@ cu %@",key, [userInfo valueForKey:key]);
        [defaults setObject:[userInfo valueForKey:key]
                     forKey:key];
        
    }
    
    [defaults synchronize];
}

@end
