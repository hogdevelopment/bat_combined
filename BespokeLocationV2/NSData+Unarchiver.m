//
//  NSData+Unarchiver.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 01/02/14.
//  Copyright (c) 2014 Chiosa Gabi. All rights reserved.
//

#import "NSData+Unarchiver.h"

@implementation NSData (Unarchiver)

- (NSMutableArray*)unarchiveToArray
{
    NSMutableArray *array = [NSMutableArray arrayWithArray:
                             [NSKeyedUnarchiver unarchiveObjectWithData:self]];
    
    if (array)
    return array;
    else
        return [[NSMutableArray alloc]init];
}
@end
