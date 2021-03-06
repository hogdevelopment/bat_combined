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
{
    UIButton         *uploadPhoto;
}
@synthesize cellDelegate, uploadPhoto = uploadPhoto;


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
    
    
    uploadPhoto  = [[UIButton alloc] initWithFrame:CGRectMake(105, (_cellHeight - 70), 110, 30)];
    [uploadPhoto setTitle:NSLocalizedString(@"Upload photo",nil) forState:UIControlStateNormal];
    [uploadPhoto.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    [uploadPhoto setTitleColor:[UIColor colorWithHexString:@"cf5117"] forState:UIControlStateNormal];
    [uploadPhoto.layer setCornerRadius:5];
    [uploadPhoto setBackgroundColor:[UIColor whiteColor]];
    
    [uploadPhoto addTarget:self action:@selector(uploadPhotoAction) forControlEvents:UIControlEventTouchUpInside];
    
    self.noPhotoYetLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 95, 300, 30)];
    [self.noPhotoYetLabel setTextAlignment:NSTextAlignmentCenter];
    [self.noPhotoYetLabel setTextColor:[UIColor whiteColor]];
    [self.noPhotoYetLabel setText:NSLocalizedString(@"Currently no photos available",nil)];
    [self.noPhotoYetLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:12.0f]];
    
    
    [self.contentView addSubview:self.noPhotoYetLabel];
    [self.contentView addSubview:uploadPhoto];
    
    //hide upload stuff
    uploadPhoto.hidden = YES;
    self.noPhotoYetLabel.hidden = YES;

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
    self.venueSmokingAbilityRatingView = [[RMNSmokeAbilityRatingView alloc] initWithFrame:CGRectMake(0, 75, 310, 30)];
    
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
    [self.contentView addSubview:self.venueSmokingAbilityRatingView];
    [self.contentView addSubview:lineView];
    [self.contentView addSubview:self.venueOpeningTimes];

    
}


- (void) createAttributesView
{
    [self.contentView setBackgroundColor:[UIColor whiteColor]];
    
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
    [self.venueDescriptionBody setNumberOfLines:1000];
    [self.venueDescriptionBody setTextColor:[UIColor colorWithHexString:@"818181"]];
    [self.venueDescriptionBody setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    
    
    // price
    self.venuePrice = [[UILabel alloc] initWithFrame:CGRectMake(10, 140, 320, 30)];
    [self.venuePrice setTextAlignment:NSTextAlignmentLeft];
    [self.venuePrice setTextColor:[UIColor colorWithHexString:@"818181"]];
    [self.venuePrice setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]];
    
    
    // website
    self.venueSiteButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 160, 310, 30)];  //[[UILabel alloc] initWithFrame:CGRectMake(10, 160, 320, 30)];
    [self.venueSiteButton setTitleColor:[UIColor colorWithHexString:@"d65019"] forState:UIControlStateNormal];
    [self.venueSiteButton.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]]; //colorWithHexString:@"d65019"
    [self.venueSiteButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];

    [self.venueSiteButton addTarget:self action:@selector(clickOnSiteURL) forControlEvents:UIControlEventTouchUpInside];

    // add views to cell
    [self.contentView addSubview:self.venueDescriptionTitle];
    [self.contentView addSubview:self.venueDescriptionBody];
    [self.contentView addSubview:self.venuePrice];
    [self.contentView addSubview:self.venueSiteButton];

}


- (void) createRatingView
{
    self.smokeRatingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, _cellHeight)];
    [self.smokeRatingView setBackgroundColor:[UIColor colorWithHexString:@"f2f2f2"]];
    [self.smokeRatingView.layer setBorderColor:[UIColor whiteColor].CGColor];
    [self.smokeRatingView.layer setBorderWidth:1.0];
    
    self.ratingStars = [[ASStarRatingView alloc] initWithFrame:CGRectMake(0, -10, 220, 100)];
    
    UIButton *rateButt = [[UIButton alloc] initWithFrame:CGRectMake(320-80, (_cellHeight - 36)/2, 70, 36)];
    [rateButt setTitle:@"Rate it" forState:UIControlStateNormal];
    [rateButt.titleLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15]];
    [rateButt.titleLabel setTextColor:[UIColor whiteColor]];
    [rateButt.layer setCornerRadius:5];
    [rateButt setBackgroundColor:[UIColor colorWithHexString:@"cf5117"]];
    [rateButt setTag:13];
    
    [rateButt addTarget:self action:@selector(addRating) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:rateButt];
    
    [self.contentView addSubview:self.smokeRatingView];
    [self.contentView addSubview:self.ratingStars];
    [self.contentView addSubview:rateButt];


}

# pragma Seting the values

- (void) setImagesArray: (NSArray *) arrayOfImages
{
    if ([arrayOfImages count] > 0) {
        
        [[self.galleryScrollView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

        [self addImagesFromArray:arrayOfImages toScrollView:self.galleryScrollView];
    }
    else{
        // no photos yet, we need to show the upload stuff
        uploadPhoto.hidden = NO;
        self.noPhotoYetLabel.hidden = NO;
        
        [self.galleryScrollView setAlpha:0];
        [self.pageControl setAlpha:0];
        
        [self.contentView setBackgroundColor:[UIColor grayColor]];
    
    }
}


- (void) setOpeningTimes: (NSString *) opening{
    
    self.venueOpeningTimes.text = [NSString stringWithFormat:@"Opening Times: %@", opening];
    
    if ([opening rangeOfString:@"null"].location != NSNotFound) {
        self.venueOpeningTimes.alpha = 0;
    }
}

- (void) setVenueSmokeAbilityRating: (int) rating andCountRatings: (int) count
{
    [self.venueSmokingAbilityRatingView updateWithRating:rating andCountRatings:count];
}


- (void) setAttributesArray: (NSArray *) arrayOfAttributes{
    
    int nrOfRows = [arrayOfAttributes count]/4 + 1;
    
    if ([arrayOfAttributes count]%4 == 0) {
        nrOfRows -=1;
    }
    
    _cellHeight = nrOfRows * 50;
    
    [self.attributesView setFrame:CGRectMake(0, 0, 320 - 50, _cellHeight)];
    
    [[self.attributesView subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];

    for (int i = 0; i < [arrayOfAttributes count]; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"attributePlaceHolder"]]; //[arrayOfAttributes objectAtIndex:i]
        [imgView setContentMode:UIViewContentModeScaleAspectFit];
        
        CGFloat yValue = i/4 * 35 + 10 * (i/4 + 1);
        
        CGFloat xValue = 50 * (i%4) + 15 * (i%4 + 1);
        [imgView setFrame:CGRectMake(xValue, yValue, 30, 30)];

//        NSLog(@"y = %f", yValue);
        
        [self.attributesView addSubview:imgView];
    }
    
    UIButton *addMore = (UIButton *)[self.contentView viewWithTag:11];
    [addMore setFrame:CGRectMake(320-50, _cellHeight - 50, 50, 50)];
    
}


- (void) setPrice: (int) price
{
    [self.venuePrice setText:[NSString stringWithFormat:@"Price: %u", price]];
    
    if (price == 0) {
        self.venuePrice.alpha = 0;
    }
    
#warning Update liras!
}


- (void) setVenueURL: (NSString *) urlString
{
    if (urlString.length != 0) {
        
        CGSize maximumLabelSize = CGSizeMake(310,30);
        
        CGSize expectedLabelSize = [urlString sizeWithFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:15.0f]
                                                 constrainedToSize:maximumLabelSize
                                                     lineBreakMode:NSLineBreakByWordWrapping];
        //set the new width needed for title label of the button.
        self.venueSiteButton.frame = CGRectMake(10, _cellHeight - 35, expectedLabelSize.width, 30);
        
        [self.venueSiteButton setTitle:urlString forState:UIControlStateNormal];
        self.venueSiteButton.alpha = 1;
    }
    else
        self.venueSiteButton.alpha = 0;
}

- (void) setNewCalculatedHeight: (CGFloat) newHeight
{
    _cellHeight = newHeight;
    
    // arrange labels
    self.venueDescriptionBody.frame     = CGRectMake(10, 30, 310, _cellHeight - 90);
    self.venuePrice.frame               = CGRectMake(10, _cellHeight - 60, 320, 30);
    self.venueSiteButton.frame          = CGRectMake(10, _cellHeight - 35, 300, 30);
}


#pragma Local Methods
- (void) addImagesFromArray: (NSArray *) arrayOfImages toScrollView: (UIScrollView *) scrollView{
    
    for (int i = 0; i<[arrayOfImages count]; i++) {
        
//        NSLog(@"ajunge si o sa trimita la%@ ",[arrayOfImages objectAtIndex:i]);
        UIActivityIndicatorView *indicatorActiv = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [indicatorActiv startAnimating];
        [indicatorActiv setFrame:CGRectMake(320 * i, 0, 320, _cellHeight)];
        [scrollView addSubview:indicatorActiv];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:[arrayOfImages objectAtIndex:i]]];
        
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse * response,
                                                   NSData * data,
                                                   NSError * error) {
                                   if (!error){
//                                       NSLog(@"CICA TERMINA DE INCARCAT");
                                       // load the image and add it to the view
                                       UIImageView *view = [[UIImageView alloc] initWithImage:[UIImage imageWithData:data]];
                                       [view setBackgroundColor:[UIColor blackColor]];
                                       [view setContentMode:UIViewContentModeScaleAspectFit];
                                       [view setFrame:CGRectMake(320 * i, 0, 320, _cellHeight)];
                                      
                                       [scrollView addSubview:view];
                                       
                                       [indicatorActiv removeFromSuperview];
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
    

    [[self cellDelegate] userDidPressAddRating: self.ratingStars.rating];
    
    
    
    
}

- (void) uploadPhotoAction{
    
    [[self cellDelegate] userDidPressUploadPhoto];
}

- (void) clickOnSiteURL
{
    [[self cellDelegate] userDidPressUOnSiteURL];
}

#pragma UIScrollView delegate methods

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    // update the page control when more than 50% of the previous/next page is visible
    
    CGFloat pageWidth = self.galleryScrollView.frame.size.width;
    int page = floor((self.galleryScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    
    self.pageControl.currentPage = page;
}


@end
