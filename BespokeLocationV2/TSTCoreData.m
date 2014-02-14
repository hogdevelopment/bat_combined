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
    

}

+ (void)updateWithInfo:(NSDictionary*)info forEntity:(TSTCoreDataEntity)entityType
{
    

    
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

    

