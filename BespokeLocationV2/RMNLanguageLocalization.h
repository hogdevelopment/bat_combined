//
//  RMNLanguageLocalization.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 12/03/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    RMNLanguageAvailableEnglish     = 0,
    RMNLanguageAvailableGerman      = 1,
    RMNLanguageAvailableRoumanian   = 2
}
RMNLanguagesAvailable;


@interface RMNLanguageLocalization : NSObject

// set the default language to be english
+ (void)init;

//translates the text through the app to the selected language
+(NSString *)translatedTextForKey:(NSString *)key;

@end
