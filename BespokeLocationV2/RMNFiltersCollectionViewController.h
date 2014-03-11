//
//  RMNFiltersCollectionViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 12/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMNCustomSearchBar;


@protocol RMNFiltersSideMenuDelegate

// methods sent to delegate
// so we know when a button was pressed
- (void)userSearchedWithDefinedFilters;

@end



@interface RMNFiltersCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    id <RMNFiltersSideMenuDelegate> delegate;
}

@property (nonatomic, strong) id <RMNFiltersSideMenuDelegate> delegate;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property RMNCustomSearchBar *searchBar;
- (IBAction)clearFilters:(UIButton *)sender;
- (IBAction)findWithFilters:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *clearFiltersButton;
@property (weak, nonatomic) IBOutlet UIButton *findVenuesButton;

@end
