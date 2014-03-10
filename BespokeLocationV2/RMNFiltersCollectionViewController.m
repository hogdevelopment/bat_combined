//
//  RMNFiltersCollectionViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 12/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//


#import "RMNFiltersCollectionViewController.h"
#import "RMNFilterSearchHeaderView.h"
#import <QuartzCore/QuartzCore.h>
#import "RMNCustomSearchBar.h"

@interface RMNFiltersCollectionViewController ()<RMNAutocompleteSearchBarTextDelegate>
{
    NSMutableArray *filterPhotos;
    NSMutableArray *attributesPhotos;
    int numberOfFilters;
    int numberOfAttributes;
    RMNCustomSearchBar *customSearchBar;
    
    NSMutableArray *selectedFilters;
 }

@property  NSMutableArray *selectedFilters;

@end

@implementation RMNFiltersCollectionViewController

@synthesize clearFiltersButton  =   clearFiltersButton;


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
    
    
    // init custom search bar
    customSearchBar = [[RMNCustomSearchBar alloc] initWithFrame:CGRectMake(0,10, 270, 40)];
    [customSearchBar setDelegate:self];
    
    [customSearchBar setBackgroundColor:CELL_LIGHT_BLUE];

    
    CLLocationCoordinate2D tempLoc = [RMNLocationController sharedInstance].locationManager.location.coordinate;
    
    // settings needed for autocomplete feature
    [customSearchBar setViewController:self];
    [customSearchBar setLocationCoordinate:tempLoc];
    
    [self.view addSubview:customSearchBar];
    
#warning Debug only
    filterPhotos        = [[NSMutableArray alloc]init];
    attributesPhotos    = [[NSMutableArray alloc]init];
    
    numberOfFilters = 35;
    for (int i = 0; i < numberOfFilters; i++)
    {

        NSMutableDictionary *info = [[NSMutableDictionary alloc] initWithDictionary:@{@"photo"   : @"attributePlaceHolder",
                                                                                      @"text"    : [NSString stringWithFormat:@"Fi%d",i],
                                                                                      @"state"   : @"deselected",
                                                                                      @"keys"    : @[@"key0",@"key1",@"key3"]}];
        [filterPhotos addObject:info];
    }
    
    numberOfAttributes = 20;
    for (int i = 0; i < numberOfAttributes; i++)
    {
        NSMutableDictionary *info = [[NSMutableDictionary alloc] initWithDictionary:@{@"photo"   : @"attributePlaceHolder",
                                                                                      @"text"    : [NSString stringWithFormat:@"At%d",i],
                                                                                      @"state"   : @"deselected",
                                                                                      @"keys"    : @[@"key0",@"key1"]}];
    [attributesPhotos addObject:info];
    }
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"RMNFilterSearchHeaderView"
                                                    bundle:[NSBundle mainBundle]]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:@"CollectionViewReusableSearchView"];


    [self.collectionView setAllowsMultipleSelection:YES];
    

    // add drop shadow effect
    self.searchBar.layer.masksToBounds    = NO;
    self.searchBar.layer.shadowOffset     = CGSizeMake(.0f,2.5f);
    self.searchBar.layer.shadowRadius     = 1.5f;
    self.searchBar.layer.shadowOpacity    = .4f;
    self.searchBar.layer.shadowColor      = [UIColor grayColor].CGColor;
    self.searchBar.layer.shadowPath       = [UIBezierPath bezierPathWithRect:self.searchBar.bounds].CGPath;
    
    
    selectedFilters = [[NSMutableArray alloc]init];
    
    
    //customize the buttons from the bottom of the screen
    
    UIImage *clearImage = [RMNCustomNavButton customNavButton:RMNCustomNavButtonArrowless withTitle:@"Clear filters"];
    [self.clearFiltersButton setImage:clearImage forState:UIControlStateNormal];
    
    
    UIImage *findImage = [RMNCustomNavButton customNavButton:RMNCustomNavButtonArrowless withTitle:@"Find"];
    [self.findVenuesButton setImage:findImage forState:UIControlStateNormal];
    

    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)cancelNumberPad
{
    [self resignFirstResponder];
}

- (void)doneWithNumberPad
{
    [self resignFirstResponder];
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
          viewForSupplementaryElementOfKind:(NSString *)kind
                                atIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *headerCell = (indexPath.section == 0) ? @"CollectionViewReusableSearchView" : @"collectionViewHeader";
    
    
    UICollectionReusableView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                                   withReuseIdentifier:headerCell
                                                                                          forIndexPath:indexPath];

    
    UILabel *textLabel = (UILabel *)[headerView viewWithTag:200];
    
    switch (indexPath.section) {
        case 1:
        {
            [textLabel setText:NSLocalizedString(@"Venue Type", nil)];
            break;
        }
        case 2:
        {
            [textLabel setText:NSLocalizedString(@"Specific Attributes", nil)];
            break;
        }
        default:
            break;
    }
    
    return headerView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (section == 0) ? CGSizeMake(320, 60) : CGSizeMake(320, 50);
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return (section == 0)? 0 : (section == 1)? filterPhotos.count : attributesPhotos.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"Cell";
    UICollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                           forIndexPath:indexPath];
    
    UIImageView *imageView              = (UIImageView *)[cell viewWithTag:100];
    UILabel     *labelText              = (UILabel *)[cell viewWithTag:200];
    
    
    
    
    
    NSArray *sourceArray;
    
    switch (indexPath.section)
    {
        case 1:
        {
            sourceArray = filterPhotos;
            break;
        }
        case 2:
        {
            sourceArray = attributesPhotos;
            break;
        }
        default:
            break;
    }
    
    imageView.image = [UIImage imageNamed:[[sourceArray objectAtIndex:indexPath.row] valueForKey:@"photo"]];
    [labelText setText :[[sourceArray objectAtIndex:indexPath.row] valueForKey:@"text"]];

    
    
    
    if (IS_IOS7)
    {
        
        UIImageView *imageView  = (UIImageView *)[cell viewWithTag:100];
        UILabel *textLabel      = (UILabel *)[cell viewWithTag:200];
        
        imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        
        UIColor *colorState = CELL_LIGHT_BLUE;
        
        if ([[[sourceArray objectAtIndex:indexPath.row] valueForKey:@"state"] isEqualToString:@"deselected"])
        {
            colorState = CELL_DARK_GRAY;
        }
        
        [imageView setTintColor:colorState];
        [textLabel setTextColor:colorState];
    }


    
    
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];
  
    if (IS_IOS7)
    {

        UIImageView *imageView  = (UIImageView *)[cell viewWithTag:100];
        UILabel *textLabel      = (UILabel *)[cell viewWithTag:200];
      
        imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

        
        [imageView setTintColor:CELL_LIGHT_BLUE];
        [textLabel setTextColor:CELL_LIGHT_BLUE];
        
        
        
        
        
        NSArray *sourceArray;
        
        switch (indexPath.section)
        {
            case 1:
            {
                sourceArray = filterPhotos;
                break;
            }
            case 2:
            {
                sourceArray = attributesPhotos;
                break;
            }
            default:
                break;
        }

        
        [[sourceArray objectAtIndex:indexPath.row]setValue:@"selected" forKey:@"state"];
        
        NSLog(@"baga filtru");
        [selectedFilters addObject:[sourceArray objectAtIndex:indexPath.row]];
        
    }
    else
    {
        [cell setBackgroundColor:CELL_LIGHT_BLUE];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:indexPath];

    if (IS_IOS7)
    {
        
        UIImageView *imageView  = (UIImageView *)[cell viewWithTag:100];
        UILabel *textLabel      = (UILabel *)[cell viewWithTag:200];
        
        imageView.image = [imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

        
        [imageView setTintColor:CELL_DARK_GRAY];
        [textLabel setTextColor:CELL_DARK_GRAY];
        
        NSArray *sourceArray;
        
        switch (indexPath.section)
        {
            case 1:
            {
                sourceArray = filterPhotos;
                break;
            }
            case 2:
            {
                sourceArray = attributesPhotos;
                break;
            }
            default:
                break;
        }
        
        NSLog(@"scoate filtru");
        [[sourceArray objectAtIndex:indexPath.row] setValue:@"deselected" forKey:@"state"];
        [selectedFilters removeObject:[sourceArray objectAtIndex:indexPath.row]];

    }
    else
    {
         [cell setBackgroundColor:[UIColor clearColor]];
    }
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma RMNCustomSearchBar methods
- (void)userSearched:(NSString *)searchedString
{
    
}

- (IBAction)clearFilters:(UIButton *)sender
{
    NSLog(@"Clear filters %d",[selectedFilters count]);

    
    
    // find array of pins which souldn't be on the map but are and remove references
    dispatch_async(kBgQueue, ^{
        

        // reset the state for each filter
        for (int i = 0; i<[selectedFilters count];i++)
        {
            NSMutableDictionary *info = [selectedFilters objectAtIndex:i];
            [info setValue:@"deselected" forKey:@"state"];
            NSLog(@"SCOATE %@",[info valueForKey:@"text"]);
           
        }
        
        [selectedFilters removeAllObjects];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSLog(@"ramane cu %d elemente ",[selectedFilters count]);
            // reload the collection view
            [self.collectionView reloadData];
            
            
        });
    });
    

    
}

- (IBAction)findWithFilters:(id)sender
{
    // send the filter array to a custom search
    NSLog(@"Searching With %@",selectedFilters);
}
@end
