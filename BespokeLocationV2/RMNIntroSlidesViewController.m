//
//  RMNIntroSlidesViewController.m
//  BespokeLocationV2
//
//  Created by Chiosa Gabi on 13/02/14.
//  Copyright (c) 2014 Hogarth. All rights reserved.
//

#import "RMNIntroSlidesViewController.h"
#import "RMNIntroSlideContentViewController.h"

@interface RMNIntroSlidesViewController ()
{
    NSArray *pageTitles;
    NSArray *pageSubtitles;

    NSArray *pageImages;
}
@end

@implementation RMNIntroSlidesViewController

@synthesize pageTitles      =   pageTitles;
@synthesize pageImages      =   pageImages;
@synthesize pageSubtitles   =   pageSubtitles;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    pageTitles = @[@"Find places to smoke",
                   @"Filter the places to what you want",
                   @"Rate a venue on smoke ability",
                   @"Add a venue to your list of favourites"];
    
    pageSubtitles= @[@"Aliquam erat volutpat. Nulla nec mi fermentum, porttitor quam pulvinar, condimentum magna. Aliquam ornare quam eget tempus ",
                     @"Aliquam erat volutpat. Nulla nec mi fermentum, porttitor quam pulvinar, condimentum magna. Aliquam ornare quam eget tempus condimentum",
                     @"Aliquam erat volutpat. Nulla nec mi fermentum, porttitor quam pulvinar, condimentum magna. Aliquam ornare quam eget tempus condimentum",
                     @"Aliquam erat volutpat. Nulla nec mi fermentum, porttitor quam pulvinar, condimentum magna. Aliquam ornare quam eget tempus condimentum"];

    
    pageImages = @[@"slide_0_Zurich",
                   @"slide_1_Zurich",
                   @"slide_2_Zurich",
                   @"slide_3_Zurich"];
    

    
    [self.startAppButton setHidden:YES];

    
    // Create page view controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource  =   self;
    self.pageViewController.delegate    =   self;
    
    RMNIntroSlideContentViewController *startingViewController = [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[startingViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the size of page view controller
    self.pageViewController.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width,
                                                    [[UIScreen mainScreen] bounds].size.height + 30.0);
    
    

    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
    
    self.customPageController.numberOfPages = [pageImages count];
    


    // add on top elements which need to be always on top
#warning Must change frames for iphone 4 && 4s
    [self.view addSubview:self.customPageController];
    [self.view addSubview:self.skipIntroSlidesButton];
    
    
    
    if (!IS_IPHONE_5)
    {
        CGRect footerFrame = self.customFooter.frame;
        footerFrame.origin.y -= footerFrame.size.height;
        [self.customFooter setFrame:footerFrame];
    }
    [self.view addSubview:self.customFooter];
    
    
}


#pragma mark - Page View Controller Data Source



- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = ((RMNIntroSlideContentViewController*) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = ((RMNIntroSlideContentViewController*) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageTitles count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
}


- (RMNIntroSlideContentViewController *)viewControllerAtIndex:(NSUInteger)index
{
    if (([self.pageTitles count] == 0) || (index >= [self.pageTitles count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    RMNIntroSlideContentViewController *pageContentViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageContentViewController"];
    pageContentViewController.imageFile     = self.pageImages[index];
    pageContentViewController.titleText     = self.pageTitles[index];
    pageContentViewController.subtitleText  = self.pageSubtitles[index];
    pageContentViewController.pageIndex     = index;
    
    return pageContentViewController;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageTitles count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}


- (void)pageViewController:(UIPageViewController *)viewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{

    [self updatePageController:completed];
    
}

- (void)updatePageController:(BOOL)completed
{
    NSLog(@"A AJUNS SI IN DELEGAT");
    if (!completed){return;}
    RMNIntroSlideContentViewController *currentViewController = (RMNIntroSlideContentViewController *)[self.pageViewController.viewControllers lastObject];
    NSUInteger index = currentViewController.pageIndex;
    self.customPageController.currentPage = index;
    
    
    BOOL isLastSlide = NO;
    NSLog(@"INDEX %d page images %d",index,[pageImages count]-1);
    isLastSlide =  (index >= [pageImages count]-1) ? YES : NO;
    [self.nextButton setHidden:isLastSlide];
    if (isLastSlide) NSLog(@"DAAAMN ESTE TRUE");
    [self.startAppButton setHidden:!isLastSlide];
}

- (IBAction)nextSlideAction:(id)sender
{

    switch (((UIButton*)sender).tag)
    {
        case 0:
        {
            
            //if the user touches the next button, the slider changes its content
            //to the next slide
            
            // create weak reference to avoid retain cycles
            __weak RMNIntroSlidesViewController *self_ = self;

            RMNIntroSlideContentViewController *currentViewController = (RMNIntroSlideContentViewController *)[self.pageViewController.viewControllers lastObject];
            NSUInteger index = currentViewController.pageIndex;
            index++;
            RMNIntroSlideContentViewController *startingViewController = [self viewControllerAtIndex:MIN(index,[pageImages count]-1)];
            NSArray *viewControllers = @[startingViewController];
            
            
            
            [self.pageViewController setViewControllers:viewControllers
                                              direction:UIPageViewControllerNavigationDirectionForward
                                               animated:YES
                                             completion:^(BOOL finished)
             {
                 [self_ updatePageController:finished];
             }];

            break;
        }
        case 1:
        case 2:
        {
             [[self navigationController] setNavigationBarHidden:NO animated:NO];
             [self performSegueWithIdentifier:@"loginFinalStepSegue" sender:self];
            break;
        }

        default:
            break;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startAppAction:(id)sender {
}
@end
