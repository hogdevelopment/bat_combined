//
//  RMNCustomSearchBar.h
//  BespokeLocationV2
//
//  Created by Aura on 2/10/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TRAutocompleteView.h"
#import "TRGoogleMapsAutocompleteItemsSource.h"
#import "TRTextFieldExtensions.h"
#import "TRGoogleMapsAutocompletionCellFactory.h"

@interface RMNCustomSearchBar : UIView <UISearchBarDelegate>
{
    TRAutocompleteView  *autocompleteView;
    UISearchBar         *searchBarView;
    UIViewController    *viewController;
}

- (void) setLocationCoordinate: (CLLocationCoordinate2D) location;
- (void) setViewController: (UIViewController *)vController;

@end
