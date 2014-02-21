//
//  RMNUserInfo.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 21/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNUserInfo.h"
#import "TSTCoreData.h"


@implementation RMNUserInfo

+ (void)saveProfileImageWithURL:(NSString*)profilePicLocation
{
    UIImage *profileImage;
    
    BOOL allWasGoodAndWeHaveAPicture = NO;
    
        NSURL *url = [NSURL URLWithString:profilePicLocation];
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        if (imgData)
        {
            profileImage = [UIImage imageWithData:imgData];
            allWasGoodAndWeHaveAPicture =   YES;
        }

    
    if (!allWasGoodAndWeHaveAPicture)
    {
        profileImage = [UIImage imageNamed:@"profile"];
    }
    
    [profileImage saveImageToPhone];
        
    
}



+ (UIImage*)profileImage
{
    
    NSString *pathToSave = [NSString stringWithFormat:@"/Documents/myProfileImageFor%@.png",
                            [[RMNManager sharedManager]currentUserEmail]];
    
    NSString* path = [NSHomeDirectory() stringByAppendingString:pathToSave];
    
    NSFileHandle* myFileHandle = [NSFileHandle fileHandleForReadingAtPath:path];
    UIImage     * loadedImage = [UIImage imageWithData:[myFileHandle readDataToEndOfFile]];
    
    return loadedImage;
}


+ (NSArray*)profileData
{
    // get the info from Core Data
    NSDictionary *sectionsTitles =    (NSDictionary*)[[TSTCoreData fetchedUserData]lastObject];

    
    // make the array for the table view
    NSArray *sections = @[[sectionsTitles valueForKey:@"username"],
                          [sectionsTitles valueForKey:@"username"],
                          [[sectionsTitles valueForKey:@"gender"]capitalizedString],
                          [sectionsTitles valueForKey:@"dateOfBirth"],
                          [sectionsTitles valueForKey:@"email"],
                          [sectionsTitles valueForKey:@"password"]];

    
    
    
    return sections;
}

+ (void)updateProfileDataWith:(NSArray*)infoToUpdate
{
    
    NSDateFormatter *dateFormatterForGettingDate = [[NSDateFormatter alloc] init];
    [dateFormatterForGettingDate setDateFormat:@"EEEE dd, yyyy"];
    
    // convert the string date to a NSDate
    // so we can update the new value if any
    NSDate *dateFromStr = [dateFormatterForGettingDate dateFromString:[infoToUpdate objectAtIndex:3]];
    
    
    NSDictionary *dictionaryCD = @{//TO ADD NAME HERE
                                    @"username"     :   [infoToUpdate objectAtIndex:1],
                                    @"gender"       :   [infoToUpdate objectAtIndex:2] ,
                                    @"dateOfBirth"  :   dateFromStr,
                                    @"email"        :   [infoToUpdate objectAtIndex:4],
                                    @"password"     :   [infoToUpdate objectAtIndex:5]
                                    };
    
    [TSTCoreData updateWithInfo:dictionaryCD forEntity:TSTCoreDataUser];
}
@end
