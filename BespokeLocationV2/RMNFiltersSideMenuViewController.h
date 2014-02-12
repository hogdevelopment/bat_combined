//
//  RMNFiltersSideMenuViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 12/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPSearchBar.h"

@protocol RMNFilterFinderCustomSearchDelegate

// the user selected or not custom types of filters
// where to search
- (void)mustSearchWithFilters;

@end


@interface RMNFiltersSideMenuViewController : UITableViewController<HPSearchBarDelegate>
{
    id <RMNFilterFinderCustomSearchDelegate> customFiltersSearchDelegate;

}

@property (nonatomic) HPSearchBar *searchBar;
@property (nonatomic, strong) id <RMNFilterFinderCustomSearchDelegate> customFiltersSearchDelegate;


@end
