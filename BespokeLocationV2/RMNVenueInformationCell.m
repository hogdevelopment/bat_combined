//
//  RMNVenueInformationCell.m
//  BespokeLocationV2
//
//  Created by infodesign on 2/21/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNVenueInformationCell.h"
#import "UIColor+HexRecognition.h"
#import "ASStarRatingView.h"

static NSString *CellImageIdentifier            = @"ImageCellIdentifier";
static NSString *CellDetailsIdentifier          = @"DetailsCellIdentifier";
static NSString *CellAttributesIdentifier       = @"AttributesCellIdentifier";
static NSString *CellDescriptionIdentifier      = @"DescriptionCellIdentifier";
static NSString *CellRatingIdentifier           = @"RatingCellIdentifier";


@implementation RMNVenueInformationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self setBackgroundColor:[UIColor clearColor]];
       
        if ([reuseIdentifier isEqualToString:CellImageIdentifier]) {
            
            _cellHeight = 200;
            [self createGalleryViews];
        }
        else
            if ([reuseIdentifier isEqualToString:CellDetailsIdentifier]) {
                
                _cellHeight = 160;
                [self createDetailsLabels];
            }
        else if ([reuseIdentifier isEqualToString:CellAttributesIdentifier]) {
            
                _cellHeight = 60;
                [self createAttributesView];
        }
        else if ([reuseIdentifier isEqualToString:CellDescriptionIdentifier]) {
            
                _cellHeight = 200;
                [self createDescriptionLabels];
            
            }
        else if ([reuseIdentifier isEqualToString:CellRatingIdentifier]) {
            
                _cellHeight = 80;
                [self createRatingView];
            }
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


#pragma  Initiate methods for each custom cell

- (void) createGalleryViews
{
    // scroll view for images
    self.galleryScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, _cellHeight)];
    [self.galleryScrollView setDelegate:self];
    [self.galleryScrollView setPagingEnabled:YES];
    [self.galleryScrollView setContentSize:CGSizeMake(320, _cellHeight)];
    [self.galleryScrollView setScrollEnabled:YES];
    self.galleryScrollView.showsHorizontalScrollIndicator = YES;
    self.galleryScrollView.showsVerticalScrollIndicator = NO;
    
    // page controller
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, _cellHeight - 50, 320, 50)];
    [self.pageControl setUserInteractionEnabled:YES];
    [self.pageControl setNumberOfPages:1];
    [self.pageControl setCurrentPage:0];
    
    [self.contentView addSubview:self.galleryScrollView];
    [self.contentView addSubview:self.pageControl];
    
    self.arrayWithImages = [[NSMutableArray alloc] init];
}


- (void) createDetailsLabels
{
    // title
    self.venueTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 310, 30)];
    [self.venueTitle setTextAlignment:NSTextAlignmentLeft];
    [self.venueTitle setTextColor:[UIColor colorWithHexString:@"3c8cbf"]];
    [self.venueTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:21.0f]];
    
    
    // address
    self.venueAddress = [[UILabel alloc] initWithFrame:CGRectMake(10, 45, 310, 30)];
    [self.venueAddress setTextAlignment:NSTextAlignmentLeft];
    [self.venueAddress setTextColor:[UIColor colorWithHexString:@"818181"]];
    [self.venueAddress setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18.0f]];
    
    
    // smoke rating
    self.venueSmokingRatingView = [[UIView alloc] initWithFrame:CGRectMake(0, 75, 310, 30)];
    
    UILabel *smokeLbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 30)];
    [smokeLbl setTextAlignment:NSTextAlignmentLeft];
    [smokeLbl setTextColor:[UIColor colorWithHexString:@"818181"]];
    [smokeLbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f]];
    [smokeLbl setText:@"Smoke Ability"];
    [smokeLbl setTag:1];
    
    UILabel *ratingLbl = [[UILabel alloc] initWithFrame:CGRectMake(200, 0, 100, 30)];
    [ratingLbl setTextAlignment:NSTextAlignmentLeft];
    [ratingLbl setTextColor:[UIColor colorWithHexString:@"818181"]];
    [ratingLbl setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:17.0f]];
    [ratingLbl setText:@"(ratings)"];
    [ratingLbl setTag:2];
    
    [self.venueSmokingRatingView addSubview:smokeLbl];
    [self.venueSmokingRatingView addSubview:ratingLbl];
    
    
    // gray line
    UIImageView *lineView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 107, 300, 1)];
    [lineView setBackgroundColor:[UIColor colorWithHexString:@"e4e3e3"]];
    
    
    // opening times
    self.venueOpeningTimes = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 310, 30)];
    [self.venueOpeningTimes setTextAlignment:NSTextAlignmentLeft];
    [self.venueOpeningTimes setTextColor:[UIColor colorWithHexString:@"818181"]];
    [self.venueOpeningTimes setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    
    
    // add views to cell
    [self.contentView addSubview:self.venueTitle];
    [self.contentView addSubview:self.venueAddress];
    [self.contentView addSubview:self.venueSmokingRatingView];
    [self.contentView addSubview:lineView];
    [self.contentView addSubview:self.venueOpeningTimes];

    
}


- (void) createAttributesView
{
    self.attributesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320 - 50, _cellHeight)];
    [self.attributesView setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    
    UIButton *addAttributesButt = [[UIButton alloc] initWithFrame:CGRectMake(320-50, _cellHeight - 50, 50, 50)];
    [addAttributesButt setTitle:@"+" forState:UIControlStateNormal];
    [addAttributesButt.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:50]];
    [addAttributesButt.layer setBorderColor:[UIColor whiteColor].CGColor];
    [addAttributesButt.layer setBorderWidth:1.0];
    [addAttributesButt setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    [addAttributesButt setTag:11];
    
    [addAttributesButt addTarget:self action:@selector(addMoreAttributes) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:addAttributesButt];
    [self.contentView addSubview:self.attributesView];
    
}


- (void) createDescriptionLabels
{
    // description title
    self.venueDescriptionTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 320, 30)];
    [self.venueDescriptionTitle setTextAlignment:NSTextAlignmentLeft];
    [self.venueDescriptionTitle setTextColor:[UIColor colorWithHexString:@"818181"]];
    [self.venueDescriptionTitle setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    
    
    // description body
    self.venueDescriptionBody = [[UILabel alloc] initWithFrame:CGRectMake(10, 30, 310, 100)];
    [self.venueDescriptionBody setTextAlignment:NSTextAlignmentLeft];
    [self.venueDescriptionBody setLineBreakMode:NSLineBreakByWordWrapping];
    [self.venueDescriptionBody setNumberOfLines:10];
    [self.venueDescriptionBody setTextColor:[UIColor colorWithHexString:@"818181"]];
    [self.venueDescriptionBody setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    
    
    // price
    self.venuePrice = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 320, 30)];
    [self.venuePrice setTextAlignment:NSTextAlignmentLeft];
    [self.venuePrice setTextColor:[UIColor colorWithHexString:@"818181"]];
    [self.venuePrice setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    
    
    // website
    self.venueSite = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 320, 30)];
    [self.venueSite setTextAlignment:NSTextAlignmentLeft];
    [self.venueSite setTextColor:[UIColor colorWithHexString:@"d65019"]];
    [self.venueSite setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
 
    // add views to cell
    [self.contentView addSubview:self.venueDescriptionTitle];
    [self.contentView addSubview:self.venueDescriptionBody];
    [self.contentView addSubview:self.venuePrice];
    [self.contentView addSubview:self.venueSite];

}


- (void) createRatingView
{
    self.smokeRatingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, _cellHeight)];
    ASStarRatingView *stars = [[ASStarRatingView alloc] initWithFrame:CGRectMake(0, -10, 220, 100)];

    
    [self.smokeRatingView setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    
    [self.contentView addSubview:self.smokeRatingView];
    [self.contentView addSubview:stars];

}

# pragma Seting the values

- (void) setImagesArray: (NSArray *) arrayOfImages
{
    if ([arrayOfImages count] > 0) {
        
        [[self.galleryScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

        [self addImagesFromArray:arrayOfImages toScrollView:self.galleryScrollView];
    }
    else{
        // no photos yet, we need to show the upload button
        [self.galleryScrollView setAlpha:0];
        [self.pageControl setAlpha:0];
    }
    

}


- (void) setOpeningTimes: (NSString *) opening{
    
    self.venueOpeningTimes.text = [NSString stringWithFormat:@"Opening Times: %@", opening];
}

- (void) setVenueSmokeRating: (int) rating
{
    UILabel *ratingLabel = (UILabel *)[self.venueSmokingRatingView viewWithTag:2];
    [ratingLabel setText:[NSString stringWithFormat:@"(%u ratings)", rating]];
    
#warning Update stars!
    
}


- (void) setAttributesArray: (NSArray *) arrayOfAttributes{
    
    int nrOfRows = [arrayOfAttributes count]/4 + 1;
    
    if ([arrayOfAttributes count]%4 == 0) {
        nrOfRows -=1;
    }
    
    _cellHeight = nrOfRows * 50;
    
    [[self.attributesView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    for (int i = 0; i < [arrayOfAttributes count]; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[arrayOfAttributes objectAtIndex:i]]];
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        
        CGFloat yValue = i%4 == 0 ? i/4 + 1 : i/4;
        [imgView setFrame:CGRectMake(60 * (i%4), yValue, 50, _cellHeight)];
    
        NSLog(@"x is %d", i%4);
        
        [self.attributesView addSubview:imgView];
    }
    
    UIButton *addMore = (UIButton *)[self.contentView viewWithTag:11];
    [addMore setFrame:CGRectMake(320-50, _cellHeight - 50, 50, 50)];
    
}


- (void) setPrice: (int) price
{
    [self.venuePrice setText:[NSString stringWithFormat:@"Price: %u", price]];
    
#warning Update liras!

}


#pragma Local Methods
- (void) addImagesFromArray: (NSArray *) arrayOfImages toScrollView: (UIScrollView *) scrollView{
    
    for (int i = 0; i<[arrayOfImages count]; i++) {
        
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[arrayOfImages objectAtIndex:i]]];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   if (!error){
                                       
                                       // load the image and add it to the view
                                       UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
                                       [view setBackgroundColor:[UIColor blackColor]];
                                       [view setContentMode:UIViewContentModeScaleAspectFit];
                                       [view setFrame:CGRectMake(320 * i, 0, 320, _cellHeight)];
                                      
                                       [scrollView addSubview:view];

                                   }
                               }];
        
    }
    
    // update the content size for scroll view
    [self.galleryScrollView setContentSize:CGSizeMake(320 * [arrayOfImages count], _cellHeight)];
    
    // update page control
    [self.pageControl setNumberOfPages:[arrayOfImages count]];
}





#pragma UIButtons methods

- (void) addMoreAttributes{
    
    [[self cellDelegate] userDidPressAddAttribute];
}

- (void) addRating{
    
    [[self cellDelegate] userDidPressAddRating];

}



#pragma UIScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // update the page control when more than 50% of the previous/next page is visible
    
    CGFloat pageWidth = self.galleryScrollView.frame.size.width;
    int page = floor((self.galleryScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.pageControl.currentPage = page;
}


@end
