//
//  RMNDistancePageViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 11/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNDistancePageViewController.h"
#import "UIColor+HexRecognition.h"

@interface RMNDistancePageViewController ()

@end

@implementation RMNDistancePageViewController

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
    
    // set localized texts
    self.navigationItem.title = NSLocalizedString(@"Distance",nil);
    self.titleLabel.text = NSLocalizedString(@"Distance",nil);
    [self.milesButt setTitle:NSLocalizedString(@"Miles",nil) forState:UIControlStateNormal];
    [self.kmButt setTitle:NSLocalizedString(@"Kilometres",nil) forState:UIControlStateNormal];

	// Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"e9e9e9"]];

    self.titleLabel.text = [self.titleLabel.text uppercaseString];
    [self.milesButt setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.kmButt    setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];

#warning save value for the first time in appdelegate
    // get unit from user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *currentUnit = [defaults objectForKey:@"distanceCurrentUnit"];
    
    CGRect markFrame = self.selectedMark.frame;
    
    if ([currentUnit isEqualToString:@"miles"]) {
        
        markFrame.origin.y = 121;
    }
    else{
        markFrame.origin.y = 171;
    }
    
    self.selectedMark.frame = markFrame;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseUnitAction:(UIButton *)butt {
    
    CGRect markFrame = self.selectedMark.frame;
    NSString *currentUnit = @"";
    
    if (butt == self.milesButt) {
        markFrame.origin.y = 121;
        currentUnit = @"miles";
    }
    else{
        markFrame.origin.y = 171;
        currentUnit = @"kilometres";
    }
    
    self.selectedMark.frame = markFrame;
    
    // save unit to user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:currentUnit forKey:@"distanceCurrentUnit"];
    [defaults synchronize];
    
}
@end
