//
//  RMNUserInfo.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 21/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMNUserInfo : NSObject

// saves the profile picture to a predifined place in the phone's
// library.
+ (void)saveProfileImageWithURL:(NSString*)profilePicLocation;

// saves custom filter created by the user
+ (void)saveFilter:(NSDictionary*)filterInfo;

// loades the current users profile image stored locally
+ (UIImage*)profileImage;


// loads the users personal info from Core Data
+ (NSArray*)profileData;

// updates the users personal info in Core data
+ (void)updateProfileDataWith:(NSArray*)infoToUpdate;


// saves favourite location to core data
+ (void)saveLocationToFavourites:(NSDictionary*)location;

// fetches the favourites locations
+ (NSMutableArray*)fetchFavouriteLocations;

// fetches the filters created by the user
+ (NSMutableArray*)fetchFilters;

// deletes favourite location from core data
+ (void)removeFavouriteLocation:(NSDictionary*)location;
@end
