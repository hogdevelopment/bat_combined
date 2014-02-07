//
//  DetailsViewController.m
//  GoogleMap
//
//  Created by Joseph caxton-idowu on 20/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "DetailsViewController.h"
#import "DirectionsViewController.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController


@synthesize ObjectsToShow,uid,name,contactPhone,contactTwitter,localAddress,crossStreet,city,state,
postCode,country,latitude,longitude,distance,SiteURL,Hours,Price,Rating,Description,flag,PhotoPrefix,PhotoSuffix,Categories,image,imageView,scrollView,PlaceImageView,PlaceImage;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.navigationItem.title = @"Details";
    
    NSString *PlaceImagePath = [[NSBundle mainBundle] pathForResource:@"place_Details" ofType:@"png"];
    PlaceImage = [[UIImage alloc]initWithContentsOfFile:PlaceImagePath];
    PlaceImageView = [[UIImageView alloc] initWithImage:PlaceImage];
    PlaceImageView.frame = CGRectMake(0, 0.0, self.view.bounds.size.width,self.view.bounds.size.height - 400);
    [self.view addSubview:PlaceImageView];
    
    /*UIButton *backbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backbtn setBackgroundImage:[UIImage imageNamed:@"back_arrow40.png"] forState:UIControlStateNormal];
    [backbtn addTarget:self action:@selector(goBack:) forControlEvents:UIControlEventTouchUpInside];
    backbtn.frame=CGRectMake(0.0, 0.0, 64.0, 40.0);
    UIBarButtonItem *GoBack = [[UIBarButtonItem alloc] initWithCustomView:backbtn];
    self.navigationItem.leftBarButtonItem = GoBack; */
    
    
    
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.scrollEnabled = YES;
    //scrollView.pagingEnabled = YES;
    //scrollView.showsVerticalScrollIndicator = YES;
    //scrollView.showsHorizontalScrollIndicator = YES;
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height);
    [self.view addSubview:scrollView];
    
    
    Categories= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 50.0, 300, 40.0)];
    Categories.text = [NSString stringWithFormat:@"Category: %@",ObjectsToShow.Categories] ;
    [scrollView addSubview:Categories];

    
    uid = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 80.0, 300, 40.0)];
    uid.text = [NSString stringWithFormat:@"UID: %@", ObjectsToShow.uid];
    [scrollView addSubview:uid];
    
    
    
    name = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 110.0, 300, 40.0)];
    name.text = [NSString stringWithFormat:@"Name: %@",ObjectsToShow.name];
    [scrollView addSubview:name];
    
    contactPhone = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 140.0, 300, 40.0)];
    contactPhone.text = [NSString stringWithFormat:@"Phone: %@",ObjectsToShow.contactPhone];
    [scrollView addSubview:contactPhone];
    
    
    contactTwitter= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 170.0, 300, 40.0)];
    contactTwitter.text = [NSString stringWithFormat:@"Twitter: %@",ObjectsToShow.contactTwitter] ;
    [scrollView addSubview:contactTwitter];
    
    localAddress = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 200.0, 300, 80.0)];
    localAddress.numberOfLines = 0;
    [localAddress setLineBreakMode:NSLineBreakByWordWrapping];
    localAddress.text = [NSString stringWithFormat:@"Adress: %@ %@ %@ %@ %@",ObjectsToShow.localAddress, ObjectsToShow.city, ObjectsToShow.state, ObjectsToShow.postCode, ObjectsToShow.country ] ;
    [scrollView addSubview:localAddress];
    
    latitude= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 260.0, 300, 40.0)];
    latitude.text = [NSString stringWithFormat:@"Latitude: %@",ObjectsToShow.latitude] ;
    [scrollView addSubview:latitude];
    
    longitude= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 290.0, 300, 40.0)];
    longitude.text = [NSString stringWithFormat:@"Longitude: %@",ObjectsToShow.longitude] ;
    [scrollView addSubview:longitude];
    
    distance= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 320.0, 300, 40.0)];
    distance.text = [NSString stringWithFormat:@"Distance: %@",ObjectsToShow.distance] ;
    [scrollView addSubview:distance];
    
    SiteURL= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 350.0, 300, 40.0)];
    SiteURL.text = [NSString stringWithFormat:@"URL: %@",ObjectsToShow.SiteURL] ;
    [scrollView addSubview:SiteURL];
    
    Hours= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 380.0, 300, 40.0)];
    Hours.text = [NSString stringWithFormat:@"Hours: %@",ObjectsToShow.Hours] ;
    [scrollView addSubview:Hours];
    
    Price= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 410.0, 300, 40.0)];
    Price.text = [NSString stringWithFormat:@"Price: %@",ObjectsToShow.Price] ;
    [scrollView addSubview:Price];
    
    Rating= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 440.0, 300, 40.0)];
    Rating.text = [NSString stringWithFormat:@"Rating: %@",ObjectsToShow.Rating] ;
    [scrollView addSubview:Rating];
    
    Description= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 470.0, 300, 40.0)];
    Description.text = [NSString stringWithFormat:@"Description: %@",ObjectsToShow.Description] ;
    [scrollView addSubview:Description];
    
    flag= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 500.0, 300, 40.0)];
    flag.text = [NSString stringWithFormat:@"Flag: %@",(ObjectsToShow.outsideradius) ? @"True" : @"False" ] ;
    [scrollView addSubview:flag];
    
    PhotoPrefix= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 530.0, 300, 40.0)];
    PhotoPrefix.text = [NSString stringWithFormat:@"Photo Prefix: %@",ObjectsToShow.PhotoPrefix] ;
    [scrollView addSubview:PhotoPrefix];
    
    PhotoSuffix= [[UILabel alloc] initWithFrame:CGRectMake(10.0, 560.0, 300, 40.0)];
    PhotoSuffix.text = [NSString stringWithFormat:@"Photo Suffix: %@",ObjectsToShow.PhotoSuffix] ;
    [scrollView addSubview:PhotoSuffix];
    
    
    
    // Remove the first "/" from the URL Suffix
    if([ObjectsToShow.PhotoPrefix length] > 1){
        
       // NSLog(@"%@",ObjectsToShow.PhotoPrefix);
       // NSLog(@"%@",ObjectsToShow.PhotoSuffix);
        
    NSString *PhotoSuffixClean = [ObjectsToShow.PhotoSuffix substringWithRange:NSMakeRange(1,ObjectsToShow.PhotoSuffix.length - 1)];
    NSString *FullImageURL = [NSString stringWithFormat:@"%@60x60/%@", ObjectsToShow.PhotoPrefix,PhotoSuffixClean];
    image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:FullImageURL]]];
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(240.0, 0.0, 60.0, 60.0)];
    imageView.image = image;
    [scrollView addSubview:imageView];
        
    }
    
 // Direction Button
    UIButton *directionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [directionBtn setBackgroundImage:[UIImage imageNamed:@"direction.png"] forState:UIControlStateNormal];
    [directionBtn addTarget:self action:@selector(startDirecting:) forControlEvents:UIControlEventTouchUpInside];
    directionBtn.frame=CGRectMake(20.0, 20.0, 30, 30.0);
    [scrollView addSubview:directionBtn];

}

- (void)loadView
{
    [super loadView];

    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    [view setBackgroundColor:[UIColor whiteColor]];
    
   
    
    self.view = view;
    
   
    
}

-(void)viewWillAppear:(BOOL)animated{
    
     [self willAnimateRotationToInterfaceOrientation:self.interfaceOrientation duration:1];
    
}

-(void)goBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)startDirecting:(id)sender {
    
    DirectionsViewController *di = [[DirectionsViewController  alloc] initWithNibName:nil bundle:nil];
    
    di.destinationToShow = ObjectsToShow;
    [self.navigationController pushViewController:di animated:YES];
    
    
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation duration:(NSTimeInterval)duration{
    
    if (interfaceOrientation == UIInterfaceOrientationPortrait  || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ) {
       
        scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        imageView.frame = CGRectMake(240.0, 0.0, 60.0, 60.0);
        
        
    } else {
        
        scrollView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
        imageView.frame = CGRectMake(self.view.bounds.size.width - 80, 0, 60, 60);
        
        
    }
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
