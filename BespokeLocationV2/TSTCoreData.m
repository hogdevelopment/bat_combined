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
    
    //
    
    NSString *entityName = [self entityNameFor:entityType];

    NSManagedObject *informationManagedObject     = [NSEntityDescription
                                                   insertNewObjectForEntityForName:entityName
                                                   inManagedObjectContext:context];
    
    

    for(id key in information)
    {

        [informationManagedObject setValue:NULL_TO_NIL([information objectForKey:key])
                                  forKey:key];
    }
    
    
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    else{
        
//        NSLog(@"the info stored are: %@", [self fetchedUserData]);
    }
    
    

}


+ (void)updateWithInfo:(NSDictionary*)info forEntity:(TSTCoreDataEntity)entityType
{
    

}


+(NSMutableArray *)fetchedUserData;
{
    AppDelegate *appDelegate        = (AppDelegate*)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *managedObjectContext = [appDelegate managedObjectContext];
    
    // Define our table/entity to use
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"UserInformation" inManagedObjectContext:managedObjectContext];
    // Setup the fetch request
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    
    request.resultType = NSDictionaryResultType;
    
    
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
        // NSLog(@"core data %@,",mutableFetchResults);
        
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

        default:
            break;
    }
    
    return entityName;
}

@end

    

