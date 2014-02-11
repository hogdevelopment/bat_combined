//
//  DetailsTableViewViewController.m
//  BespokeLocationV2
//
//  Created by Joseph caxton-idowu on 30/01/2014.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "DetailsTableViewViewController.h"
#import "ASStarRatingView.h"
#import "CallGetThereView.h"
#import "ImagesCell.h"
#import "SecondView.h"
#import "AppDelegate.h"
#import "DirectionsViewController.h"

@interface DetailsTableViewViewController ()

@end

@implementation DetailsTableViewViewController

@synthesize ObjectsToShow,PlaceImageView,PlaceImage,mytableView,favouriteButton,MenuButton,ObjectoToshowFromFourSquare;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
//    
//    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    [UIColor whiteColor],NSForegroundColorAttributeName,
//                                    [UIColor whiteColor],NSBackgroundColorAttributeName,nil];
    
//    self.navigationController.navigationBar.titleTextAttributes = textAttributes;
//    
//    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:209.0/255.0 green:82.0/255.0 blue:23.0/255.0 alpha:0.9]];
    //[self.navigationController.navigationBar setTranslucent:NO];
    
    self.navigationItem.title = @"Details";
    favouriteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [favouriteButton setBackgroundImage:[UIImage imageNamed:@"favourite"] forState:UIControlStateNormal];
    favouriteButton.frame= CGRectMake(0.0, 0.0, 42.0, 40.0);
    UIBarButtonItem *favour = [[UIBarButtonItem alloc] initWithCustomView:favouriteButton];
     self.navigationItem.rightBarButtonItem = favour;
    
   
    
    mytableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.view.bounds.origin.x, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
    mytableView.dataSource = self;
    mytableView.delegate = self;
    [self.view addSubview:mytableView];
    
    CGFloat fixedFooterHeight = 80.0;
    
    CGRect footerFrame = CGRectMake(CGRectGetMinX(self.view.bounds), CGRectGetMaxY(self.view.bounds) - fixedFooterHeight, CGRectGetWidth(self.view.bounds), fixedFooterHeight);
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BOOL foursquare = appDelegate.FoursquareAPI;
    
    if(foursquare == TRUE){
        
        if ([ObjectoToshowFromFourSquare.contactPhone isEqualToString:@""]){
            
            CallGetThereView *cgtView = [[CallGetThereView alloc] initWithFrame:footerFrame phone:false];
            [cgtView.getThere  addTarget:self action:@selector(startDirecting:) forControlEvents:UIControlEventTouchUpInside];
            [cgtView setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:cgtView];
        }
        else{
            
            CallGetThereView *cgtView = [[CallGetThereView alloc] initWithFrame:footerFrame phone:true];
            [cgtView.getThere  addTarget:self action:@selector(startDirecting:) forControlEvents:UIControlEventTouchUpInside];
            [cgtView setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:cgtView];
            
            
        }

        
    }
    else {
        
        
    
    
        if ([ObjectsToShow.contactPhone isEqualToString:@""]){
            
            CallGetThereView *cgtView = [[CallGetThereView alloc] initWithFrame:footerFrame phone:false];
           [cgtView.getThere  addTarget:self action:@selector(startDirecting:) forControlEvents:UIControlEventTouchUpInside];
            [cgtView setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:cgtView];
        }
        else{
            
            CallGetThereView *cgtView = [[CallGetThereView alloc] initWithFrame:footerFrame phone:true];
            [cgtView.getThere  addTarget:self action:@selector(startDirecting:) forControlEvents:UIControlEventTouchUpInside];
            [cgtView setBackgroundColor:[UIColor whiteColor]];
            [self.view addSubview:cgtView];
            
            
        }

    
    }
    
    

    self.mytableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    // Return the number of rows in the section.
    return 9;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        
        return 200;
        
    }
    else if ( indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8){
        
        return 80;
    }
    
    return 30;

    
}
- (float)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    // This will create a "invisible" footer
    
    return 0.01f;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BOOL foursquare = appDelegate.FoursquareAPI;
    
    if(indexPath.row == 0){
        
        if(foursquare == TRUE && ObjectoToshowFromFourSquare.PhotoSuffix.length > 0){
        //get a dispatch queue
        dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        //this will start the image loading in bg
        dispatch_async(concurrentQueue, ^{
            
            NSURL *imageURL = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"%@100x100%@",ObjectoToshowFromFourSquare.PhotoPrefix, ObjectoToshowFromFourSquare.PhotoSuffix]];
            NSData *image = [[NSData alloc] initWithContentsOfURL:imageURL];
            
            //this will set the image when loading is finished
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.imageView.image = [UIImage imageWithData:image];
                [tableView reloadRowsAtIndexPaths:0 withRowAnimation:UITableViewRowAnimationNone];
                
            });
        });
        
        
        }
        else{
        
        //PlaceImage = [UIImage imageNamed:@"bar.png"];
        //cell.imageView.image = PlaceImage;
        }
        
        
    }
    else if (indexPath.row == 1){
            if(foursquare == TRUE){
                cell.textLabel.text = [NSString stringWithFormat:@"%@",ObjectoToshowFromFourSquare.name];
            }
            else{
                cell.textLabel.text = [NSString stringWithFormat:@"%@",ObjectsToShow.name];
            }
            
            cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:15];
            cell.textLabel.textColor = [UIColor colorWithRed:209.0/255.0 green:82.0/255.0 blue:23.0/255.0 alpha:1];
    }
    
    else if (indexPath.row == 2){
        
            if(foursquare == TRUE){
                cell.textLabel.text = [NSString stringWithFormat:@"%@",ObjectoToshowFromFourSquare.localAddress];
            }
            else{
                cell.textLabel.text = [NSString stringWithFormat:@"%@",ObjectsToShow.localAddress];
            }
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        cell.textLabel.textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1];
        
    }
    
    else if (indexPath.row == 3){
        
        cell.textLabel.text = @"Smoker Rating";
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        cell.textLabel.textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1];
        ASStarRatingView *stars = [[ASStarRatingView alloc] initWithFrame:CGRectMake(120, 0, 100, 30)];
        stars.canEdit = NO;
        stars.maxRating = 5;
        if(foursquare == TRUE){
            // Not this is not Smoking ratings as fourSquare does not supply that
            stars.rating = 0;
        }
        else{
            stars.rating = [ObjectsToShow.smokingRatingTotal doubleValue];
        }
        
        [cell addSubview:stars];
        
            }
    
    else if (indexPath.row == 4){
        
        cell.textLabel.text = @"FourSquare Rating";
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        cell.textLabel.textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1];
        ASStarRatingView *stars = [[ASStarRatingView alloc] initWithFrame:CGRectMake(120, 0, 100, 30)];
        stars.canEdit = NO;
        stars.maxRating = 5;
        if(foursquare == TRUE){
            // Not this is not Smoking ratings as fourSquare does not supply that
            stars.rating = [ObjectoToshowFromFourSquare.Rating doubleValue];
        }
        else{
            stars.rating = 0;
        }
        
        [cell addSubview:stars];
        
    }
    else if (indexPath.row == 5){
        
        // Add Horizontal line
        
        UIImage *lineImage = [UIImage imageNamed:@"line.png"];
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 0.5)];
        lineImageView.image = lineImage;
        [cell addSubview:lineImageView];
        
        if(foursquare == TRUE){
            cell.textLabel.text = [NSString stringWithFormat:@"Opening Times: %@", ObjectoToshowFromFourSquare.Hours];
        }
        else{
            cell.textLabel.text = [NSString stringWithFormat:@"Opening Times: %@", ObjectsToShow.Hours];
        }
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        cell.textLabel.textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1];
    }

    
        else if (indexPath.row == 6 ){
        
        static NSString *CellIdentifier = @"ImageCell";
        ImagesCell *myImagecell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (myImagecell == nil) {
            myImagecell = [[ImagesCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
        }
    
            
            UIImage *AImage = [UIImage imageNamed:@"1.png"];
            UIImageView *A = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 26, 25)];
            A.image = AImage;
            [myImagecell.ImageViews addObject:A];
            [myImagecell setImages];
        
            UIImage *BImage = [UIImage imageNamed:@"2.png"];
            UIImageView *B = [[UIImageView alloc] initWithFrame:CGRectMake(70, 0, 26, 25)];
            B.image = BImage;
            [myImagecell.ImageViews addObject:B];
            [myImagecell setImages];
        
            UIImage *CImage = [UIImage imageNamed:@"3.png"];
            UIImageView *C = [[UIImageView alloc] initWithFrame:CGRectMake(130, 0, 26, 25)];
            C.image = CImage;
            [myImagecell.ImageViews addObject:C];
            [myImagecell setImages];
        
            UIImage *DImage = [UIImage imageNamed:@"4.png"];
            UIImageView *D = [[UIImageView alloc] initWithFrame:CGRectMake(190, 0, 26, 25)];
            D.image = DImage;
        
            UIImage *EImage = [UIImage imageNamed:@"5.png"];
            UIImageView *E = [[UIImageView alloc] initWithFrame:CGRectMake(250, 0, 26, 25)];
            E.image = EImage;
        
        
        [myImagecell.ImageViews addObject:D];
        [myImagecell setImages];


        
        return myImagecell;
        
        
    }
    
    
    else if (indexPath.row == 7){
        
         if(foursquare == TRUE){
             cell.textLabel.text = [NSString stringWithFormat:@"Other Info: %@", ObjectoToshowFromFourSquare.Description];
         }
         else{
             cell.textLabel.text = [NSString stringWithFormat:@"Other Info: %@", ObjectsToShow.Description];
         }
        
        cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:12];
        cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textColor = [UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1];
    }
    
    
    else if (indexPath.row == 8){
        
        
//        // Add Horizontal line
//        
//        UIImage *lineImage = [UIImage imageNamed:@"line.png"];
//        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 608, 0.5)];
//        lineImageView.image = lineImage;
//        [cell addSubview:lineImageView];
//
//        UIButton *btnCall = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *CallImage = [UIImage imageNamed:@"call-button.png"];
//        btnCall.frame = CGRectMake(10, 20, 141, 43);
//        [btnCall setImage:CallImage forState:UIControlStateNormal];
//        
//        /*btnCall.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
//        [btnCall setTitleColor:[UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1] forState:UIControlStateNormal];
//        [[btnCall layer] setCornerRadius:8.0f];
//        btnCall.backgroundColor = [UIColor blueColor];
//        [btnCall setTitle:@"Call" forState:UIControlStateNormal]; */
//        [cell addSubview:btnCall];
//        
//        UIButton *getThere = [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *GetThereImage = [UIImage imageNamed:@"get-there-button.png"];
//        getThere.frame = CGRectMake(170, 20, 141, 43);
//        [getThere setImage:GetThereImage forState:UIControlStateNormal];
//        /*getThere.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
//        [getThere setTitleColor:[UIColor colorWithRed:95.0/255.0 green:95.0/255.0 blue:95.0/255.0 alpha:1] forState:UIControlStateNormal];
//        [[getThere layer] setCornerRadius:8.0f];
//        getThere.backgroundColor = [UIColor blueColor];
//        [getThere setTitle:@"Get there" forState:UIControlStateNormal];*/
//        [cell addSubview:getThere];

        
    }
    
    return cell;
}


 -(void)startDirecting:(id)sender {
     
     AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
     BOOL foursquare = appDelegate.FoursquareAPI;
     
      DirectionsViewController *di = [[DirectionsViewController  alloc] initWithNibName:nil bundle:nil];
     
     if(foursquare == TRUE){
         
         di.objectoToshowFromFourSquare = ObjectoToshowFromFourSquare;
        [self.navigationController pushViewController:di animated:YES];
     }
     
     else{
    
     di.destinationToShow = ObjectsToShow;
     [self.navigationController pushViewController:di animated:YES];
         
     }
     
     
 }


-(void)OpenDraw:(id)sender{
    
    SecondView *SecondVC = [[SecondView alloc] init];
    
    
    NSMutableArray *vcs =  [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
    [vcs insertObject:SecondVC atIndex:[vcs count]-1];
    [self.navigationController setViewControllers:vcs animated:NO];
    [self.navigationController popViewControllerAnimated:YES];
}

/*- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
        return view;
} */
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
