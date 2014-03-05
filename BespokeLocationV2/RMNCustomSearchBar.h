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


@protocol RMNAutocompleteSearchBarTextDelegate <NSObject>

- (void)userSearched:(NSString*)searchedString;

@end

@interface RMNCustomSearchBar : UIView <UISearchBarDelegate>
{
    TRAutocompleteView  *autocompleteView;
    UISearchBar         *searchBarView;
    UIViewController    *viewController;
    
    id <RMNAutocompleteSearchBarTextDelegate> delegate;
}

@property (nonatomic, strong) id <RMNAutocompleteSearchBarTextDelegate> delegate;

@property UISearchBar *searchBarView;

- (void) setLocationCoordinate: (CLLocationCoordinate2D) location;
- (void) setViewController: (UIViewController *)vController;



@end
