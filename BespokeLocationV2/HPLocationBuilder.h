//
//  HPLocationBuilder.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPLocationBuilder : NSObject


// builds a dictionary with the NSData received from the server
// for detailed information regarding a certain location
+ (NSDictionary *)locationsFromFoursquare:(NSData *)objectNotation
                                    error:(NSError **)error;


// builds a dictionary with the NSData received from the server
// with all the locations stored in the data base
+ (NSArray *)locationsFromDataBase:(NSData *)objectNotation
                                  error:(NSError **)error;

// builds the answer for certain server requests such as
// login, register, change password, update users info
+ (NSDictionary *)answerFrom:(NSData *)objectNotation
                       error:(NSError **)error;
 @end
