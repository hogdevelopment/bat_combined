//
//  TSTCoreData.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 15/01/14.
//  Copyright (c) 2014 Chiosa Gabi. All rights reserved.
//

#import "TSTCoreData.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "UserInformation.h"
#import "RMNUserInformationCoreData.h"

// use this to avoid app crashes due to crapy work from the web developer
// if values returned are NULL it will make them nil
#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })


@implementation TSTCoreData

+ (void) addInformation:(NSDictionary *)information ofType:(TSTCoreDataEntity)entityType
{
    // bring za app delegate instance
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    NSString *entityName = [self entityNameFor:entityType];

    NSManagedObject *informationManagedObject     = [NSEntityDescription
                                                   insertNewObjectForEntityForName:entityName
                                                   inManagedObjectContext:context];
    

    for(id key in information)
    {
        
        if ([[information objectForKey:key] isKindOfClass:[NSArray class]])
        {
            
            NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:[information objectForKey:key]];
            
            [informationManagedObject setValue:newData
                                        forKey:key];
            
        }
        else
        {
            [informationManagedObject setValue:NULL_TO_NIL([information
                                                            objectForKey:key])
                                        forKey:key];
        }
    }
    
    
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    else{
        
    }

}


+ (void) addInformations:(NSMutableArray*)informationArrayOfDictionaries ofType:(TSTCoreDataEntity)entityType
{
    // bring za app delegate instance
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    NSString *entityName = [self entityNameFor:entityType];
    
    NSManagedObject *informationManagedObject     = [NSEntityDescription
                                                     insertNewObjectForEntityForName:entityName
                                                     inManagedObjectContext:context];
    
    NSLog(@"la core data primeste %d informatii ",[informationArrayOfDictionaries count]);
    for (int i = 0; i< [informationArrayOfDictionaries count]; i++)
    {
        //informationArrayOfDictionaries
        NSDictionary *information = [informationArrayOfDictionaries objectAtIndex:i];
       
        NSLog(@"--------------------------%d-------",i);
        for(id key in information)
        {
            NSLog(@"key %@",key);
            if ([[information objectForKey:key] isKindOfClass:[NSArray class]])
            {
                
                NSData *newData = [NSKeyedArchiver archivedDataWithRootObject:[information objectForKey:key]];
                
                [informationManagedObject setValue:newData
                                        forKey:key];
                
                
                
            }
            else
            {
            
            [informationManagedObject setValue:NULL_TO_NIL([information
                                                            objectForKey:key])
                                        forKey:key];
            }
        }
    
     }
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    else{
        
    }
    
}

+ (id)actionType:(TSTCoreDataActionType)actionType
         forEntity:(TSTCoreDataEntity)entityType
          withKeys:(NSDictionary*)info
{
    // bring za app delegate instance
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    
    
    NSString *entityName = [self entityNameFor:entityType];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    

    

    // build custom id to search for in entity
    NSString *valueKey  = [info valueForKey:@"valueKey"];
    NSString *idKey     = [info valueForKey:@"idKey"];

    // build dynamic predicate for request
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"%K like %@",
                              idKey, valueKey];

    
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];

    // retrieve the desired object
    NSManagedObject* userData = [results lastObject];

    
    // do custom action
    switch (actionType) {
        case TSTCoreDataActionDelete:
        {
            [context deleteObject:userData];
            break;
        }
        case TSTCoreDataActionUpdate:
        {
            
            NSArray *keys = [info allKeys];
            
            // parse the dictionary to update the given values
            for (NSString *key in keys)
            {
                if ([key isEqualToString:@"idKey"] ||
                    [key isEqualToString:@"valueKey"])
                    return 0;
                
                [userData setValue:[info objectForKey:key]
                            forKey:key];
            }
            
        break;
        }
        default:
            break;
    }
    
 
    // update and check for errros
    if(![context save:&error])
    {
        //This is a serious error saying the record
        //could not be saved. Advise the user to
        //try again or restart the application.
        NSLog(@"Eroare la update in Core Data");
        /// TODO - throw an alert, and make the
        /// user to save it again
    }
    else{
        //        NSLog(@"update for photos is done! WITH %@",[self fetchedUserData]);
        
    }
    
    return 0;

}


+ (void)updateWithInfo:(NSDictionary*)info forEntity:(TSTCoreDataEntity)entityType
{
    
    // bring za app delegate instance
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];

    
    NSString *entityName = [self entityNameFor:entityType];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:entityName inManagedObjectContext:context]];
    
    NSString *userEmail = [[RMNManager sharedManager] currentUserEmail];
    request.predicate   = [NSPredicate predicateWithFormat:@"email == %@",userEmail];

    
    NSError *error = nil;
    NSArray *results = [context executeFetchRequest:request error:&error];
    
    NSManagedObject* userData = [results lastObject];
    
    NSArray *keys = [info allKeys];

    // parse the dictionary to update the given values
    for (NSString *key in keys)
    {

        [userData setValue:[info objectForKey:key]
                           forKey:key];
    }

    // update and check for errros
    if(![context save:&error])
    {
        //This is a serious error saying the record
        //could not be saved. Advise the user to
        //try again or restart the application.
        NSLog(@"Eroare la update in Core Data");
        /// TODO - throw an alert, and make the
        /// user to save it again
    }
    else{
//        NSLog(@"update for photos is done! WITH %@",[self fetchedUserData]);

    }


}



+(NSMutableArray *)fetchedUserDataFor:(TSTCoreDataEntity)entityType
{
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    
    NSString *entityName = [self entityNameFor:entityType];

    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    if (entityType == TSTCoreDataUser)
    {
        NSString *userEmail = [[RMNManager sharedManager] currentUserEmail];
        NSString *username  = [[RMNManager sharedManager] userNameText];
        NSLog(@"cauta ori cu %@ ori cu %@",userEmail,username);
        request.predicate   = [NSPredicate predicateWithFormat:@"email == %@ or username == %@",userEmail,username];
    }
    request.resultType  = NSDictionaryResultType;
    
    
    // Fetch the records and handle an error
    NSError *error;
    NSMutableArray *mutableFetchResults = [[managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (!mutableFetchResults)
    {
        // Handle the error.
        // This is a serious error and should advise the user to restart the application
        ////TODO: ADD an alert
        NSLog(@"herrrroor!");
    }
    else
    {
//         NSLog(@"core data %@,",mutableFetchResults);
        
    }
    return mutableFetchResults;
}



+ (BOOL) checkIfIsSavedInCoreDataUserWithUsername: (NSString *) username andIsRegisteredWithSocialService: (UserInformationKeyValues ) socialService;
{
    BOOL userExists = NO;
    
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInformation" inManagedObjectContext:managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    request.predicate = [NSPredicate predicateWithFormat:@"username == %@",username];
    request.resultType = NSDictionaryResultType;

    NSArray *fetchedObjects;
    NSError *error;

    fetchedObjects = [managedObjectContext executeFetchRequest:request error:&error] ;

//    NSLog(@"fetched %@", fetchedObjects);
//    NSLog(@"key is %@", [RMNUserInformationCoreData keyForListValue:socialService]);
    
    for (id elem in fetchedObjects) {
        
        BOOL usingSocialSrv = [[elem valueForKey:[RMNUserInformationCoreData keyForListValue:socialService]] boolValue];
        
        if (usingSocialSrv) {
            
            NSLog(@"found user : %@", [elem valueForKey:[RMNUserInformationCoreData keyForListValue:UserUsername]]);
            userExists = YES;
        }
    }
    
    return userExists;
}


+ (BOOL) checkIfIsSavedInCoreDataUserWithEmail: (NSString *) userEmail andPassword: (NSString *)userPassword{
    
    BOOL userExists = NO;
    
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInformation" inManagedObjectContext:managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    request.predicate = [NSPredicate predicateWithFormat:@"email == %@",userEmail];
    request.resultType = NSDictionaryResultType;
    
    NSArray *fetchedObjects;
    NSError *error;
    
    fetchedObjects = [managedObjectContext executeFetchRequest:request error:&error];
    
    for (id elem in fetchedObjects) {
        
        if ([[elem valueForKey:[RMNUserInformationCoreData keyForListValue:UserPassword]] isEqualToString:userPassword]) { //
            
            NSLog(@"found user : %@", [elem valueForKey:[RMNUserInformationCoreData keyForListValue:UserUsername]]);
            userExists = YES;
        }
    }
    
    return userExists;
}



+ (NSString *) findPasswordForUserRegisteredWithEmail: (NSString *) userEmail
{
    NSString *foundPassword = @"";
    
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInformation" inManagedObjectContext:managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    request.predicate = [NSPredicate predicateWithFormat:@"email == %@",userEmail];
    request.resultType = NSDictionaryResultType;
    
    NSArray *fetchedObjects;
    NSError *error;
    
    fetchedObjects = [[managedObjectContext executeFetchRequest:request error:&error] lastObject];
    
    if (fetchedObjects) {
        
        foundPassword = [fetchedObjects valueForKey:[RMNUserInformationCoreData keyForListValue:UserPassword]];
        
        if (foundPassword.length > 0) {
            NSLog(@"yes, found the user registered with password: %@", fetchedObjects);
        }
    }
    
    return foundPassword;
}



+ (NSString *) returnEmailForUserWithUsername: (NSString *) username andSocialService: (UserInformationKeyValues ) socialService
{
    NSString *foundEmail = @"";
    
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInformation" inManagedObjectContext:managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    request.predicate = [NSPredicate predicateWithFormat:@"username == %@",username];
    request.resultType = NSDictionaryResultType;
    
    NSArray *fetchedObjects;
    NSError *error;
    
    fetchedObjects = [managedObjectContext executeFetchRequest:request error:&error] ;
    
    for (id elem in fetchedObjects) {
        
        BOOL usingSocialSrv = [[elem valueForKey:[RMNUserInformationCoreData keyForListValue:socialService]] boolValue];
        
        if (usingSocialSrv) {
            foundEmail = [elem valueForKey:[RMNUserInformationCoreData keyForListValue:UserEmail]];
        }
    }
    
    return foundEmail;
}





+ (NSString *) returnPhotoURLForUserWithEmail: (NSString *) userEmail
{
    NSString *photo = Nil;
    
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInformation" inManagedObjectContext:managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    request.predicate = [NSPredicate predicateWithFormat:@"email == %@",userEmail];
    request.resultType = NSDictionaryResultType;
    
    NSArray *fetchedObjects;
    NSError *error;
    
    fetchedObjects = [[managedObjectContext executeFetchRequest:request error:&error] lastObject];
    
    if (fetchedObjects) {
        
        photo = [fetchedObjects valueForKey:[RMNUserInformationCoreData keyForListValue:UserPhotoURL]];
        
        if (photo.length > 0) {
            
            // check if photo is just a placeholder provided by the social service
            BOOL isPlaceholder = NO;
            
            if ([photo rangeOfString:@"default_profile"].location != NSNotFound) {
                isPlaceholder = YES;
            }
            if ([photo rangeOfString:@"photo.jpg"].location != NSNotFound) {
                isPlaceholder = YES;
            }
            if ([photo rangeOfString:@"blank_"].location != NSNotFound) {
                isPlaceholder = YES;
            }
            
            if (isPlaceholder) {
                photo = Nil;
            }
            
        }
    }
    
    return photo;
}



+ (BOOL) checkIfVenueIsAlreadySavedInFavouritesWithName: (NSString *) venueName andLocalAddress: (NSString *) localAddress
{
    BOOL foundVenue = NO;
    
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Favourites" inManagedObjectContext:managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@",venueName];
    request.resultType = NSDictionaryResultType;
    
    NSArray *fetchedObjects;
    NSError *error;
    
    fetchedObjects = [managedObjectContext executeFetchRequest:request error:&error];
    
    for (id elem in fetchedObjects) {
        
        NSString *address = [elem valueForKey:@"localAddress"];
        
        if ([address isEqualToString:localAddress]) {
            foundVenue = YES;
        }
    }
    
    return foundVenue;
}



+ (NSString*)entityNameFor:(TSTCoreDataEntity)entityType
{
    NSString *entityName;
    switch (entityType)
    {
        case TSTCoreDataUser:
        {
            entityName = @"UserInformation";
            break;
        }
        case TSTCoreDataFilters:
        {
            entityName = @"Filters";
            break;
        }
        case TSTCoreDataFavourites:
        {
            entityName = @"Favourites";
            break;
        }

        default:
            break;
    }
    
    return entityName;
}




@end



