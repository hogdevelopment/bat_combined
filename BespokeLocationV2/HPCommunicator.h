//
//  HPCommunicator.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/26/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HPCommunicatorDelegate.h"



@protocol HPCommunicatorDelegate;


@interface HPCommunicator : NSObject


@property (nonatomic) id<HPCommunicatorDelegate> delegate;
@property (strong, nonatomic) NSString*foursquareID;



// use this to send a http request
- (void)doSomeHTTPRequestFor:(RMNLocationSource)type;
@end


