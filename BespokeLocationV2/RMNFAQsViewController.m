//
//  RMNFAQsViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFAQsViewController.h"
#import "RMNFaqsAnswersViewController.h"

static NSString *CellIdentifier         = @"CellFAQs";
static NSString *CellHeaderIdentifier   = @"CellFAQsHeader";



@interface RMNFAQsViewController ()
{
    NSArray *questions;
    NSArray *answers;
}

@property NSArray *questions;
@property NSArray *answers;
@end


@implementation RMNFAQsViewController

@synthesize questions   =   questions;
@synthesize answers     =   answers;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set the delegates
    [self.tableView setDelegate:self];
    [self.tableView setDataSource:self];
    
    // add rouned cornes to the table
    self.tableView.layer.cornerRadius = 4;
    self.tableView.layer.masksToBounds = YES;
    
    // set a clear background to the table view
    [self.tableView setBackgroundColor:[UIColor whiteColor]];
    self.tableView.contentInset = UIEdgeInsetsMake(-1.0f, 0.0f, 0.0f, 0.0);
    
    
    
    questions = @[NSLocalizedString(@"questionFAQs_0",nil),
                  NSLocalizedString(@"questionFAQs_1",nil),
                  NSLocalizedString(@"questionFAQs_2",nil),
                  NSLocalizedString(@"questionFAQs_3",nil),
                  NSLocalizedString(@"questionFAQs_4",nil),
                  NSLocalizedString(@"questionFAQs_5",nil),
                  NSLocalizedString(@"questionFAQs_6",nil),
                  NSLocalizedString(@"questionFAQs_7",nil),
                  NSLocalizedString(@"questionFAQs_8",nil),
                  NSLocalizedString(@"questionFAQs_9",nil),
                  NSLocalizedString(@"questionFAQs_10",nil),
                  NSLocalizedString(@"questionFAQs_11",nil)];
    
    
    
    answers     = @[NSLocalizedString(@"answerFAQs_0",nil),
                    NSLocalizedString(@"answerFAQs_1",nil),
                    NSLocalizedString(@"answerFAQs_2",nil),
                    NSLocalizedString(@"answerFAQs_3",nil),
                    NSLocalizedString(@"answerFAQs_4",nil),
                    NSLocalizedString(@"answerFAQs_5",nil),
                    NSLocalizedString(@"answerFAQs_6",nil),
                    NSLocalizedString(@"answerFAQs_7",nil),
                    NSLocalizedString(@"answerFAQs_8",nil),
                    NSLocalizedString(@"answerFAQs_9",nil),
                    NSLocalizedString(@"answerFAQs_10",nil),
                    NSLocalizedString(@"answerFAQs_11",nil)];
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Delegate




- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = (indexPath.row == 0) ? CellHeaderIdentifier : CellIdentifier;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];


        [[cell textLabel]setTextColor: [UIColor colorWithHexString:@"5f5f5f"]];
        
    }
    
    UIFont * font;

    if (indexPath.row == 0)
    {
        [[cell textLabel]setText:NSLocalizedString(@"FAQsHeader",nil)];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];

    }
        else
        {
            [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
            [[cell textLabel]setText:[questions objectAtIndex:indexPath.row - 1]];
            font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
        }
    
    [cell.textLabel setFont:font];

    return cell;

}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return;
    
    NSString *segueIdentifier = @"faqsAnswerSegue";
    if (segueIdentifier)
    {
        @try
        {
            [self performSegueWithIdentifier:segueIdentifier sender:self];
        }
        @catch (NSException *exception) {
            NSLog(@"Segue not found: %@ with segue %@", exception,segueIdentifier);
        }
        
    }

}


- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"faqsAnswerSegue"]) {
        RMNFaqsAnswersViewController* detailFAQ = [segue destinationViewController];
        detailFAQ.question  =   [questions  objectAtIndex:[self.tableView indexPathForSelectedRow].row-1];
        detailFAQ.answer    =   [answers    objectAtIndex:[self.tableView indexPathForSelectedRow].row-1];
    }
}
@end
