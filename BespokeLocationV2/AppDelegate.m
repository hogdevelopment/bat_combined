//
//  AppDelegate.m
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 30/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
#import "SecondView.h"
#import "UserDataSingleton.h"
#import "ViewController.h"
#import "MFSideMenuContainerViewController.h"


//change API key here
#define ApiKey @"3_7MqzwGmlHY1SIzdGUKu7u20YiW5oBvzzBCZS7MpahR7_71q88LpaWyusERHsMcuz"

@implementation AppDelegate

@synthesize FoursquareAPI;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyDBRlvVVqXgBMieotMc3Jykx0OHa2nUv4Q"];
    [Gigya initWithAPIKey:ApiKey];
   
    
    // If you want to use FourSqaure Database then leave as is. Set to FALSE if you want to use out own Database

    [UserDataSingleton userSingleton].usingGigya=(BOOL *)YES;
    FoursquareAPI = TRUE;
    //FoursquareAPI = FALSE;
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]];
    MFSideMenuContainerViewController *container = (MFSideMenuContainerViewController *)self.window.rootViewController;
    

    
    
    UINavigationController *navigationController = [storyboard instantiateViewControllerWithIdentifier:@"navigationControllerWithoutLogin"];
    
    
    
    UIViewController *leftSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"leftSideMenuViewController"];
    UIViewController *rightSideMenuViewController = [storyboard instantiateViewControllerWithIdentifier:@"rightSideMenuViewController"];
    
    [container setLeftMenuViewController:leftSideMenuViewController];
    [container setRightMenuViewController:rightSideMenuViewController];
    [container setCenterViewController:navigationController];

    
    
    return YES;
}

//facebook need this function
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:
(NSString *)sourceApplication annotation:(id)annotation
{
    return [Gigya handleOpenURL:url sourceApplication:sourceApplication
                     annotation:annotation];
}

@end
