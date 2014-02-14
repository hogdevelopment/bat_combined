//
//  AppDelegate.h
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 30/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <GigyaSDK/Gigya.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    
   
}

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, assign) BOOL FoursquareAPI;


@property (readonly, strong, nonatomic) NSManagedObjectContext          *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel            *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator    *persistentStoreCoordinator;
@end
