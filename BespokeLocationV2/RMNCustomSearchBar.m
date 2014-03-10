//
//  RMNCustomSearchBar.m
//  BespokeLocationV2
//
//  Created by Aura on 2/10/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNCustomSearchBar.h"

@implementation RMNCustomSearchBar

@synthesize delegate        =   delegate;
@synthesize searchBarView   =   searchBarView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        [self setBackgroundColor:[UIColor clearColor]];

        [self createViews];
    }
    return self;
}

- (void) createViews
{
    // search bar
    searchBarView = [[UISearchBar alloc] initWithFrame:self.frame];
    searchBarView.delegate = self;
    searchBarView.placeholder = NSLocalizedString(@"Search",nil);

    [self addSubview:searchBarView];
    
    
    UIToolbar *cancelToolBar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 30)];
    [cancelToolBar setBarStyle:UIBarStyleBlackTranslucent];
    
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
        [cancelToolBar setBarTintColor:[UIColor whiteColor]];
        [searchBarView setBarTintColor:[UIColor clearColor]];

    }
    
    UIBarButtonItem *buttCancel = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Cancel",nil)
                                                                  style:UIBarButtonItemStyleDone
                                                                 target:self
                                                                 action:@selector(doneWithKeyboard:)];
    cancelToolBar.items = [NSArray arrayWithObjects:
                           buttCancel,
                           nil];
    [cancelToolBar sizeToFit];
    
    searchBarView.inputAccessoryView = cancelToolBar;
    
    searchBarView.keyboardType = UIKeyboardAppearanceLight;
    
    if (IS_IOS7)
    {
        searchBarView.tintColor = CELL_LIGHT_BLUE;
    }
    else
    {
        NSLog(@"Must change here to work on other ios");
    }
    
    
}

- (void) setViewController: (UIViewController *)vController
{
    viewController = vController;
}

- (void) setLocationCoordinate: (CLLocationCoordinate2D) location
{
    // autocomplete view
    
    UITextField *txtSearchField = [searchBarView valueForKey:@"_searchField"];

    // create weak reference to avoid retain cycles
    __weak RMNCustomSearchBar *self_ = self;
    
    autocompleteView = [TRAutocompleteView autocompleteViewBindedTo:txtSearchField usingSource:
                        [[TRGoogleMapsAutocompleteItemsSource alloc]
                                initWithMinimumCharactersToTrigger:3
                                                            apiKey:@"AIzaSyAMkoHHFPdaA3ocQmQtWm0LAaIze-V-NUk"
                                                          location:location]
                                                        cellFactory:[[TRGoogleMapsAutocompletionCellFactory alloc]
                                                                    initWithCellForegroundColor:[UIColor whiteColor]
                                                                                       fontSize:14]
                                                       presentingIn:viewController];
    
    autocompleteView.topMargin = -5;
    autocompleteView.backgroundColor = [UIColor colorWithRed:209.0/255.0 green:82.0/255.0 blue:23.0/255.0 alpha:0.9];
    
    autocompleteView.didAutocompleteWith = ^(id<TRSuggestionItem> item)
    {
        
        [[self_ delegate]userSearched:item.completionText];
    };
    
}


// cancel action
-(void)doneWithKeyboard:(id)sender
{
    autocompleteView.hidden = true;
    
    UITextField *txtSearchField = [searchBarView valueForKey:@"_searchField"];

    [[self delegate]userSearched:txtSearchField.text];
    
    NSLog(@"txtSearchField.text %@",txtSearchField.text);

    //UITextField *txtSearchField = [SearchBar valueForKey:@"_searchField"];
    [searchBarView  resignFirstResponder];
    
    
}


#pragma mark - UISearchBar Delegate Methods

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    if([searchText isEqualToString:@""]){
        
        autocompleteView.hidden = true;
        
        //UITextField *txtSearchField = [SearchBar valueForKey:@"_searchField"];
        [searchBar  resignFirstResponder];
        
    }
    else {
        
        if (autocompleteView.hidden == true){
            
            autocompleteView.hidden = false;
            
        }
    }
    
}


- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
        
    return true;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    
    searchBar.showsCancelButton = NO;
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"Cancel");
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    
    NSLog(@"Cancel");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    UITextField *txtSearchField = [searchBarView valueForKey:@"_searchField"];
    
    [[self delegate]userSearched:txtSearchField.text];
    
    NSLog(@"txtSearchField.text %@",txtSearchField.text);
    
    [searchBar resignFirstResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
