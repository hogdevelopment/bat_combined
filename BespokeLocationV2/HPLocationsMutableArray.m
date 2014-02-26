//
//  HPLocationsMutableArray.m
//  HartaDePescar
//
//  Created by Chiosa Gabi on 05/12/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import "HPLocationsMutableArray.h"

@implementation HPLocationsMutableArray

+ (NSMutableArray *)locationsArray
{
    static NSMutableArray *singletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[NSMutableArray alloc]init];
        
    });
    return singletonInstance;
}

+ (NSMutableArray *)friendsArray
{
    static NSMutableArray *singletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[NSMutableArray alloc]init];
        
    });
    return singletonInstance;
}

+ (NSMutableArray *)searchedLocationsArray
{
    static NSMutableArray *singletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[NSMutableArray alloc]init];
        
    });
    return singletonInstance;
}


+ (NSMutableArray *)locationsType
{
    static NSMutableArray *singletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[NSMutableArray alloc]init];
        
    });
    return singletonInstance;
}

+ (NSMutableArray*) searchString
{
    static NSMutableArray *singletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[NSMutableArray alloc]init];
        
    });
    return singletonInstance;
    
}

+ (NSMutableArray*) coordinateToZoomTo
{
    static NSMutableArray *singletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[NSMutableArray alloc]init];
        
    });
    return singletonInstance;
    
}


+ (NSMutableArray*)dummyForCrapWork
{
    static NSMutableArray *singletonInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonInstance = [[NSMutableArray alloc]init];
        
    });
    return singletonInstance;
    
}
@end
