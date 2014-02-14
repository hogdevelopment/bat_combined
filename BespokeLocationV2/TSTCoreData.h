//
//  TSTCoreData.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 15/01/14.
//  Copyright (c) 2014 Chiosa Gabi. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum
{
    TSTCoreDataUser,
    TSTCoreDataFilters
    
}TSTCoreDataEntity;

@interface TSTCoreData : NSObject

#warning not tested
// prototype to save informations from dictionary to core data
+ (void) addInformation:(NSDictionary *)information ofType:(TSTCoreDataEntity)entityType;


#warning not implemented
// only sketch added
+ (void) updateWithInfo:(NSDictionary*)info forEntity:(TSTCoreDataEntity)entityType;
@end
