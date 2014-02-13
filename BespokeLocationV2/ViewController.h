//
//  ViewController.h
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 30/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <GoogleMaps/GoogleMaps.h>
#import <StoreKit/StoreKit.h>
#import "MBProgressHUD.h"
#import "CollectionViewCe.h"


@interface ViewController : UIViewController<CLLocationManagerDelegate,GMSMapViewDelegate,MBProgressHUDDelegate,UICollectionViewDataSource,UICollectionViewDelegate, SKStoreProductViewControllerDelegate>{
    
    

    
    
}

@property (nonatomic, strong)  UICollectionView *CollectionDetails;
//@property (nonatomic, strong)  UIPageControl *pgviewDetails;
@property (weak, nonatomic) IBOutlet UICollectionView *clctionDetials;
@property (weak, nonatomic) IBOutlet UIPageControl *pgviewDetails;

@property (nonatomic, retain)  UIButton *GetData;
@property (nonatomic, retain)  NSString *URL;
@property (nonatomic, retain)  NSData *jsonData;
@property (nonatomic, retain) NSString *strData;
@property (nonatomic, retain) NSMutableArray *LocationObjects;
@property (nonatomic, assign)  double CurrentLocationlat;
@property (nonatomic, assign) double CurrentLocationlng;
@property (nonatomic, strong)  MBProgressHUD *HUD;
@property (nonatomic, retain) UISearchBar *SearchBar;
@property (nonatomic, retain)  UIButton *MenuButton;


@end
