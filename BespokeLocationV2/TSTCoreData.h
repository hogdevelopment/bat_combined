//
//  TSTCoreData.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 15/01/14.
//  Copyright (c) 2014 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMNUserInformationCoreData.h"
#import "RMNFoursquaredLocation.h"

typedef enum
{
    TSTCoreDataUser,
    TSTCoreDataFilters,
    TSTCoreDataFavourites
    
}TSTCoreDataEntity;


typedef enum
{
    TSTCoreDataActionDelete,
    TSTCoreDataActionUpdate,
    TSTCoreDataActionSearchFavourite
}
TSTCoreDataActionType;

@interface TSTCoreData : NSObject

// save informations from dictionary to core data
+ (void) addInformation:(NSDictionary *)information ofType:(TSTCoreDataEntity)entityType;


// updates informations from dictionary to core data
+ (void) updateWithInfo:(NSDictionary*)info forEntity:(TSTCoreDataEntity)entityType;

// fetch user data
+(NSMutableArray *)fetchedUserDataFor:(TSTCoreDataEntity)entityType;

// cusotm action type for entities
// update, delete
// requiers an id in the dictionary with
// the key "idKey" and the value "valueKey"
// which will be used to fetch the object
+ (id)actionType:(TSTCoreDataActionType)actionType
         forEntity:(TSTCoreDataEntity)entityType
          withKeys:(NSDictionary*)info;

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


// check if venue is already saved in favourites
+ (BOOL) checkIfVenueIsAlreadySavedInFavouritesWithName: (NSString *) venueName andLocalAddress: (NSString *) localAddress;

@end
