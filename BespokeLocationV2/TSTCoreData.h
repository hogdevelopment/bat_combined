//
//  TSTCoreData.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 15/01/14.
//  Copyright (c) 2014 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMNUserInformationCoreData.h"

typedef enum
{
    TSTCoreDataUser,
    TSTCoreDataFilters
    
}TSTCoreDataEntity;

@interface TSTCoreData : NSObject

// save informations from dictionary to core data
+ (void) addInformation:(NSDictionary *)information ofType:(TSTCoreDataEntity)entityType;


// only sketch added
+ (void) updateWithInfo:(NSDictionary*)info forEntity:(TSTCoreDataEntity)entityType;

// fetch user data
+(NSMutableArray *)fetchedUserData;

// check if the user with username was registered with social service in Core Data
+ (BOOL) checkIfIsSavedInCoreDataUserWithUsername: (NSString *) username andIsRegisteredWithSocialService: (UserInformationKeyValues ) socialService;


// check for user with email and password
+ (BOOL) checkIfIsSavedInCoreDataUserWithEmail: (NSString *) userEmail andPassword: (NSString *)userPassword;

// check if the account with this email was created with a password and return it
+ (NSString *) findPasswordForUserRegisteredWithEmail: (NSString *) userEmail;


// get email for user with username and social service
+ (NSString *) returnEmailForUserWithUsername: (NSString *) username andSocialService: (UserInformationKeyValues ) socialService;


// returns url for profile photo (thumbnail) if available, if not - returns Nil
+ (NSString *) returnPhotoURLForUserWithEmail: (NSString *) userEmail ;


@end
