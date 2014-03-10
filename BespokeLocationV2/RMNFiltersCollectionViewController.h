//
//  RMNFiltersCollectionViewController.h
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 12/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RMNCustomSearchBar;

@interface RMNFiltersCollectionViewController : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property RMNCustomSearchBar *searchBar;
- (IBAction)clearFilters:(UIButton *)sender;
- (IBAction)findWithFilters:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *clearFiltersButton;
@property (weak, nonatomic) IBOutlet UIButton *findVenuesButton;

@end
