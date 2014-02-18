//
//  RMNFAQsViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 18/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNFAQsViewController.h"

static NSString *CellIdentifier = @"CellFAQs";


@interface RMNFAQsViewController ()<UITableViewDataSource,UITableViewDelegate>

@end


@implementation RMNFAQsViewController



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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View Delegate


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1f;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view    = [[UIView alloc]init];
    UILabel *label  = [[UILabel alloc]init];
    [label setFrame:CGRectMake(0, 0, 300, 50)];
    [label setText:@"Frequently asked questions"];
    [view addSubview:label];
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    return view;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
    }

    
    [[cell textLabel]setText:@"Custom"];
    return cell;

}
@end
