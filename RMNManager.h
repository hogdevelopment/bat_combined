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
}

@property  BOOL isLoggedIn;
@property  BOOL menuShouldBeOpened;
@property  BOOL alreadyShownIntro;


+ (id)sharedManager;

@end
