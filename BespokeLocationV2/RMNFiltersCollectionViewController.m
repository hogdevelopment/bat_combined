//
//  RMNFiltersCollectionViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 12/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//


#import "RMNFiltersCollectionViewController.h"

@interface RMNFiltersCollectionViewController ()
{
    NSMutableArray *filterPhotos;
    int numberOfFilters;
}
@end

@implementation RMNFiltersCollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
#warning Debug only
    filterPhotos = [[NSMutableArray alloc]init];
    numberOfFilters = 20;
    for (int i = 0; i < numberOfFilters; i++)
    {
        [filterPhotos addObject:@"filterSideMenuHolder"];
    }



    
}


- (void)cancelNumberPad
{
    [self resignFirstResponder];
}

- (void)doneWithNumberPad
{
    [self resignFirstResponder];

    NSLog(@"IN SEARCH BAR TRIMITE");
}


-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    return [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionViewHeader" forIndexPath:indexPath];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return filterPhotos.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    UIImageView *recipeImageView = (UIImageView *)[cell viewWithTag:100];
    recipeImageView.image = [UIImage imageNamed:[filterPhotos objectAtIndex:indexPath.row]];
    
    return cell;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
