//
//  HPMapDetailView.h
//  HartaDePescar
//
//  Created by Chiosa Gabi on 10/24/13.
//  Copyright (c) 2013 Chiosa Gabi. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol HPShowDetailLocationDelegate

// method sent to the delegate
// which will load the detail view
// for za selected location
- (void)showDetailViewToALocation;

@end

@interface HPMapDetailView : UIView
{
    
    id <HPShowDetailLocationDelegate>  detailViewDelegate;


}

@property  id  <HPShowDetailLocationDelegate>  detailViewDelegate;



@property (nonatomic) IBOutlet UILabel *locationType;
@property (nonatomic) IBOutlet UILabel *locationName;
@property (nonatomic) IBOutlet UILabel *numberOfViews;
@property (nonatomic) IBOutlet UILabel *placeName;
@property (nonatomic) IBOutlet UIButton *detailsButton;


- (IBAction)seeMoreDetails:(id)sender;

// send information to display in the detailed view
// for each marker
- (void)populateWithInfo:(NSDictionary*)justALittleBitOfInfo
;


// tell the text fields to rescale the text to fit in
// the text field, avoiding the "..." cases
-(void)setTheTextFields;
@end
