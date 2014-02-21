//
//  NSDate+Stringifier.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "NSDate+Stringifier.h"

@implementation NSDate (Stringifier)


- (NSString*)monthYearification
{
    NSString * deviceLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:deviceLanguage];
    
    [dateFormatter setDateFormat:@"MMMM YYYY"];
    [dateFormatter setLocale:locale];
    
    NSString * dateString = [dateFormatter stringFromDate:self];
    
    return dateString;
}

-(NSString*)dayMonthYearification
{
    NSString * deviceLanguage = [[NSLocale preferredLanguages] objectAtIndex:0];
    NSDateFormatter * dateFormatter = [NSDateFormatter new];
    NSLocale * locale = [[NSLocale alloc] initWithLocaleIdentifier:deviceLanguage];
    
    [dateFormatter setDateFormat:@"EEEE dd, yyyy"];
    [dateFormatter setLocale:locale];
    
    NSString * dateString = [dateFormatter stringFromDate:self];
    
    return dateString;

}
@end
