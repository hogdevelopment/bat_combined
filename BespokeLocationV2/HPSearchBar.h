//
//  HPSearchBar.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 9/7/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CGEnhancedKeyboard.h"

typedef enum
{
    SearchFriends,
    SearchLocations
}
SearchBarTypes;


@protocol HPSearchBarDelegate

// the user selected or not custom types of locations
// where to search 
- (void)userHitSearchButton;

@end

@interface HPSearchBar : UISearchBar
{
    id <HPSearchBarDelegate> searchDelegate;
}
// custom initialization of search bar
// makes za creation of search bars shorter in lines of code
- (id)initWithFrame:(CGRect)frame ofType:(SearchBarTypes)type;


@property (nonatomic, strong) id <HPSearchBarDelegate> searchDelegate;

@end
