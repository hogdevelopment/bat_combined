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

//change API key here
#define ApiKey @"3_7MqzwGmlHY1SIzdGUKu7u20YiW5oBvzzBCZS7MpahR7_71q88LpaWyusERHsMcuz"

@implementation AppDelegate

@synthesize FoursquareAPI;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [GMSServices provideAPIKey:@"AIzaSyDBRlvVVqXgBMieotMc3Jykx0OHa2nUv4Q"];
    [Gigya initWithAPIKey:ApiKey];
    
    /*UIViewController * leftSideDrawerViewController = [[SecondView alloc] init];
    UIViewController * centerViewController = [[ViewController alloc] init];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:centerViewController];
    
     self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window setRootViewController:navigationController];*/
    
    // If you want to use FourSqaure Database then leave as is. Set to FALSE if you want to use out own Database

    [UserDataSingleton userSingleton].usingGigya=(BOOL *)YES;
    FoursquareAPI = TRUE;
    //FoursquareAPI = FALSE;
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
