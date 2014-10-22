//
//  DetailVC.m
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import "DetailVC.h"
#import "VerticalAnimator.h"
#import "UIColor+JSONInitializer.h"

#define OVERSCROLL_THRESHOLD_AUTOMATIC 100
#define OVERSCROLL_THRESHOLD_INTERACTIVE 20

@interface DetailVC () <UIScrollViewDelegate, UINavigationControllerDelegate>
{
    /**
     *  Stores the value of the Y scroll offset when a swipe gesture is detected.
     */
    CGFloat overscrollSwipeOriginY;
    
    /**
     *  YES if transitioning to the next sibling, NO otherwise.
     */
    BOOL isGoingForward;
    
    /**
     *  Control flag to validate if it is possible to start a new transition at the moment.
     */
    BOOL canStartTransition;
    
    /**
     *  YES if an animation is taking place, NO otherwise.
     */
    BOOL isAnimating;
    
    /**
     *  YES if there is a next sibling.
     */
    BOOL isNextSiblingAvailable;
    
    /**
     *  YES if there is a previous sibling.
     */
    BOOL isPreviousSiblingAvailable;
    
    /**
     *  Overscroll required to trigger a transition.
     *  OVERSCROLL_THRESHOLD_INTERACTIVE for interactive transitions.
     *  OVERSCROLL_THRESHOLD_AUTOMATIC otherwise.
     */
    NSInteger overscrollThreshold;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *scrollViewSpacer;
@property (weak, nonatomic) IBOutlet UILabel *labelPreviousSiblingHint;
@property (weak, nonatomic) IBOutlet UILabel *labelNextSiblingHint;

@property (nonatomic, strong) UIBarButtonItem *interactiveToggle;

@property (strong, nonatomic) VerticalAnimator *animator;
@property (strong, nonatomic) UIPercentDrivenInteractiveTransition *interactionController;

@end

@implementation DetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.isInteractiveTransition)
        overscrollThreshold = OVERSCROLL_THRESHOLD_INTERACTIVE;
    else
        overscrollThreshold = OVERSCROLL_THRESHOLD_AUTOMATIC;
    
    canStartTransition = NO;
    
    self.scrollView.backgroundColor = [UIColor lightGrayColor];
    self.scrollViewSpacer.backgroundColor = self.detailColor;
    
    [self.scrollView setDelegate:self];
    
    self.animator = [[VerticalAnimator alloc] init];
    
    [self setupSiblingInformation];
    [self setupNavBarButton];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didChangeOrientation:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    canStartTransition = YES;
    
    //To make sure the viewControllers in the navigation controller stack only have one DetailVC.
    NSArray *viewControllersInTheStack = self.navigationController.viewControllers;
    NSArray *newStackOfViewControllers = @[viewControllersInTheStack.firstObject, viewControllersInTheStack.lastObject];
    [self.navigationController setViewControllers:newStackOfViewControllers animated:NO];
    
    [self.navigationController setDelegate:self];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.navigationController setDelegate:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

/**
 *  Check siblings and adjust UI accordingly.
 */
- (void)setupSiblingInformation
{
    id item = [self.arrayDataSource nextSiblingWithPosition:self.detailPosition];
    if(item)
    {
        isNextSiblingAvailable = YES;
        self.labelNextSiblingHint.text = @"That's right. Keep going :)";
        
    }else
    {
        isNextSiblingAvailable = NO;
        self.labelNextSiblingHint.text = @"Nothing to see here.\nTry scrolling the other way...";
    }
    
    item = [self.arrayDataSource previousSiblingWithPosition:self.detailPosition];
    if(item)
    {
        isPreviousSiblingAvailable = YES;
        self.labelPreviousSiblingHint.text = @"That's right. Keep going :)";
    }else
    {
        isPreviousSiblingAvailable = NO;
        self.labelPreviousSiblingHint.text = @"Nothing to see here.\nTry scrolling the other way...";
    }
}


/**
 *  Create and add the Interactive Transition Toggle
 */
- (void)setupNavBarButton
{
    self.interactiveToggle = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(toggleInteractiveTransition)];
    
    if(self.isInteractiveTransition)
        [self.interactiveToggle setTitle:@"Switch to Automatic"];
    else
        [self.interactiveToggle setTitle:@"Switch to Interactive"];
    
    [self.navigationItem setRightBarButtonItem:self.interactiveToggle];
}

#pragma mark - Actions

- (void)toggleInteractiveTransition
{
    self.isInteractiveTransition = !self.isInteractiveTransition;
    
    if(self.isInteractiveTransition)
    {
        overscrollThreshold = OVERSCROLL_THRESHOLD_INTERACTIVE;
        [self.interactiveToggle setTitle:@"Switch to Automatic"];
    }else
    {
        overscrollThreshold = OVERSCROLL_THRESHOLD_AUTOMATIC;
        [self.interactiveToggle setTitle:@"Switch to Interactive"];
    }
}


#pragma mark - Navigation

/**
 *  Trigger forward navigation.
 */
- (void)navigateToNextSibling
{
    isAnimating = YES;
    isGoingForward = YES;
    canStartTransition = NO;
    if(self.isInteractiveTransition)
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    
    DetailVC *destination = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"DetailVC"];
    
    id item = [self.arrayDataSource nextSiblingWithPosition:self.detailPosition];
    
    destination.arrayDataSource = self.arrayDataSource;
    destination.detailPosition = self.detailPosition+1;
    destination.detailColor = [UIColor colorWithJSONParsedDict:item[@"color"]];
    destination.isInteractiveTransition = self.isInteractiveTransition;
    
    [self.navigationController pushViewController:destination animated:YES];
}

/**
 *  Trigger backward navigation.
 */
- (void)navigateToPreviousSibling
{
    isAnimating = YES;
    isGoingForward = NO;
    canStartTransition = NO;
    if(self.isInteractiveTransition)
        self.interactionController = [[UIPercentDrivenInteractiveTransition alloc] init];
    
    DetailVC *destination = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"DetailVC"];
    
    id item = [self.arrayDataSource previousSiblingWithPosition:self.detailPosition];
    
    destination.arrayDataSource = self.arrayDataSource;
    destination.detailPosition = self.detailPosition-1;
    destination.detailColor = [UIColor colorWithJSONParsedDict:item[@"color"]];
    destination.isInteractiveTransition = self.isInteractiveTransition;
    
    [self.navigationController pushViewController:destination animated:YES];
}


#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(isAnimating)
    {
        if(!self.interactionController || !self.isInteractiveTransition)
            return;
        
        CGFloat currentScrollValue = abs(scrollView.contentOffset.y);
        CGFloat completionPercentage = [self completionPercentageForScrollOffset:currentScrollValue];
        [self.interactionController updateInteractiveTransition:completionPercentage / 100];
        if(completionPercentage >= 80)
        {
            [self.interactionController finishInteractiveTransition];
            self.interactionController = nil;
        }
        return;
    }
    else if(canStartTransition)
    {
        int screenHeight = self.view.frame.size.height;
        
        if(isNextSiblingAvailable &&
           [self isForwardOverscrollOriginValid] &&
           overscrollSwipeOriginY < scrollView.contentOffset.y &&
           scrollView.contentOffset.y > self.scrollView.contentSize.height - screenHeight + overscrollThreshold)
        {
            [self navigateToNextSibling];
            
        }else if(isPreviousSiblingAvailable &&
                 [self isBackwardOverscrollOriginValid] &&
                 scrollView.contentOffset.y < - overscrollThreshold)
        {
            [self navigateToPreviousSibling];
        }
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if(isAnimating)
    {
        if(self.interactionController)
        {
            CGFloat currentScrollValue = abs(scrollView.contentOffset.y);
            CGFloat completionPercentage = [self completionPercentageForScrollOffset:currentScrollValue];
            if(completionPercentage > 60)
            {
                [self.interactionController finishInteractiveTransition];
            }else
            {
                [self.interactionController cancelInteractiveTransition];
            }
            self.interactionController = nil;
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                isAnimating = NO;
            });
        }
    }
}


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    overscrollSwipeOriginY = scrollView.contentOffset.y;
}

/**
 *  @return YES if the swipe origin is valid for triggering a backward navigation. NO otherwise.
 */
- (BOOL)isBackwardOverscrollOriginValid
{
    if(overscrollSwipeOriginY <= 100)
        return YES;
    else
        return NO;
}

/**
 *  @return YES if the swipe origin is valid for triggering a forward navigation. NO otherwise.
 */
- (BOOL)isForwardOverscrollOriginValid
{
    if(overscrollSwipeOriginY < 0)
        return NO;
    
    int yThreshold = (self.scrollView.contentSize.height - self.scrollView.frame.size.height) - overscrollSwipeOriginY;
    
    if(yThreshold <= 75)
        return YES;
    else
        return NO;
}


#pragma mark - Interactive Transition Progress

/**
 *  Calculates the completion percentage of the interactive transition for the current scroll offset.
 *
 *  @return A value from 0 to 100 representing the completion percentage.
 */
- (CGFloat)completionPercentageForScrollOffset:(CGFloat)currentScrollValue
{
    if(isGoingForward)
    {
        return (currentScrollValue - (self.scrollView.contentSize.height - self.scrollView.frame.size.height) - overscrollThreshold) * 100 / 200;
    }else
    {
        return (currentScrollValue - overscrollThreshold) * 100 / 200;
    }
}


#pragma mark - Orientation Notification

- (void)didChangeOrientation:(NSNotification *)notification
{
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (orientation == UIInterfaceOrientationPortrait || orientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        
    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight)
    {
        //ToDo: Change minimum completion values for the interactive transition
    }
}



#pragma mark - UINavigationControllerDelegate

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC
{
    if (operation == UINavigationControllerOperationPush)
    {
        self.animator.isBottomToTopAnimation = isGoingForward;
        return self.animator;
    }
    return nil;
}

- (id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController*)navigationController
                          interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController
{
    return self.interactionController;
}


@end
