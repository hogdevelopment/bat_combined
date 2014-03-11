//
//  NSData+Unarchiver.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 01/02/14.
//  Copyright (c) 2014 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Unarchiver)


// unarchives a archived file to a array
// this is used usualy when we retrieve information
// archived to the Core Data
- (NSMutableArray*)unarchiveToArray;

@end
