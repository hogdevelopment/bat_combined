//
//  UserInformation.h
//  BespokeLocationV2
//
//  Created by infodesign on 2/17/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface UserInformation : NSManagedObject

@property (nonatomic, retain) NSNumber * isRegisteredWithNewAccount;
@property (nonatomic, retain) NSNumber * isUsingFacebook;
@property (nonatomic, retain) NSNumber * isUsingFoursquare;
@property (nonatomic, retain) NSNumber * isUsingGooglePlus;
@property (nonatomic, retain) NSNumber * isUsingTwitter;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSDate   * dateOfBirth;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSDate   * registrationDate;
@property (nonatomic, retain) NSString * photoURL;
@end
