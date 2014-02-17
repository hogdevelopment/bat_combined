//
//  NSDate+Stringifier.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 17/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Stringifier)


// this will return a string from current date
// with a format as: MonthName YearInteger
// ex: February 2014
- (NSString*)monthYearification;


@end
