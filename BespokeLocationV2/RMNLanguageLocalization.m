//
//  RMNLanguageLocalization.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 12/03/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNLanguageLocalization.h"


@implementation RMNLanguageLocalization


+ (void)init
{
    NSUserDefaults *defaults;
    //set app's primary language
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:RMNLanguageAvailableEnglish
                  forKey:@"BATAppLanguages"];
    [defaults synchronize];
    
    
}

+ (void)toggleLanguageTo:(RMNLanguagesAvailable)newLanguage
{
    
    NSUserDefaults *defaults;
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:newLanguage
                  forKey:@"BATAppLanguages"];
    [defaults synchronize];
}

+(NSString *)translatedTextForKey:(NSString *)key
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //read primary language
    int currentLanguage = [defaults integerForKey:@"BATAppLanguages"];
    
    //get the path to the desired lproj file
    NSString *path;
    switch (currentLanguage) {
        case RMNLanguageAvailableEnglish:
        {
            
            path = [[NSBundle mainBundle] pathForResource:@"en"
                                                   ofType:@"lproj"];
            break;
        }
        case RMNLanguageAvailableGerman:
        {
            
            path = [[NSBundle mainBundle] pathForResource:@"de"
                                                   ofType:@"lproj"];
            break;
        }
        case RMNLanguageAvailableRoumanian:
        {
            NSLog(@"este cu ROOOOO");
            path = [[NSBundle mainBundle] pathForResource:@"ro" ofType:@"lproj"];
            break;
        }
        default:
            break;
    }

    NSBundle* languageBundle = [NSBundle bundleWithPath:path];
    
    //find and return the desired string
    NSString* str=[languageBundle localizedStringForKey:key value:@"" table:nil];
    return str;
}


@end
