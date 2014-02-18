//
//  RMNUserInformationCoreData.h
//  BespokeLocationV2
//
//  Created by infodesign on 2/17/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    UserEmail                            = 0,
    UserUsername                         = 1,
    UserDateOfBirth                      = 2,
    UserGender                           = 3,
    UserPassword                         = 4,
    UserIsRegisteredWithNewAccount       = 5,
    UserIsUsingFacebook                  = 6,
    UserIsUsingTwitter                   = 7,
    UserIsUsingGoogle                    = 8,
    UserIsUsingFoursquare                = 9,
    UserRegistrationDate                 = 10
}
UserInformationKeyValues;

@interface RMNUserInformationCoreData : NSObject

// this will return the key which is used to save values
// in core data for UserInformation
+ (NSString*) keyForListValue:(UserInformationKeyValues)entityKeyListValue;

@end
