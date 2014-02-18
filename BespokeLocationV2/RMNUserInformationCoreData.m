//
//  RMNUserInformationCoreData.m
//  BespokeLocationV2
//
//  Created by infodesign on 2/17/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNUserInformationCoreData.h"

@implementation RMNUserInformationCoreData


+ (NSString*) keyForListValue:(UserInformationKeyValues)entityKeyListValue
{
    NSString *keyString;

    switch (entityKeyListValue) {
            
        case UserEmail:
        {
            keyString = @"email";
            break;
        }
        case UserDateOfBirth:
        {
            keyString = @"dateOfBirth";
            break;
        }
        case UserGender:
        {
            keyString = @"gender";
            break;
        }
        case UserUsername:
        {
            keyString = @"username";
            break;
        }
        case UserPassword:
        {
            keyString = @"password";
            break;
        }
        case UserIsRegisteredWithNewAccount:
        {
            keyString = @"isRegisteredWithNewAccount";
            break;
        }
        case UserIsUsingFacebook:
        {
            keyString = @"isUsingFacebook";
            break;
        }
        case UserIsUsingFoursquare:
        {
            keyString = @"isUsingFoursquare";
            break;
        }
        case UserIsUsingGoogle:
        {
            keyString = @"isUsingGooglePlus";
            break;
        }
        case UserIsUsingTwitter:
        {
            keyString = @"isUsingTwitter";
            break;
        }
        case UserRegistrationDate:
        {
            keyString = @"registrationDate";
            break;
        }
        default:
            break;
    }
    
    return keyString;
}


@end
