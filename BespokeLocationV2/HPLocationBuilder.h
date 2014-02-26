//
//  HPLocationBuilder.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HPLocationBuilder : NSObject


// build an array with the NSData received from the server
// for the location information
+ (NSDictionary *)locationsFromFoursquare:(NSData *)objectNotation
                                    error:(NSError **)error;


+ (NSDictionary *)locationsFromDataBase:(NSData *)objectNotation
                                  error:(NSError **)error;

 @end
