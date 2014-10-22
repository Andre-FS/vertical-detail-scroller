//
//  VerticalAnimator.m
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import "VerticalAnimator.h"

#define PRESENT_DURATION 0.7f
#define FROM_VIEW_FINAL_ALPHA 0.3f

@implementation VerticalAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return PRESENT_DURATION;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];
    
    UIView *container = [transitionContext containerView];
    
    [container addSubview:toVC.view];
    
    CGRect newOriginFrame = sourceRect;
    CGRect newDestinationFrame = sourceRect;
    
    if(self.isBottomToTopAnimation)
    {
        newOriginFrame.origin.y -= newOriginFrame.size.height;
        newDestinationFrame.origin.y += newDestinationFrame.size.height;
    }else
    {
        newOriginFrame.origin.y += newOriginFrame.size.height;
        newDestinationFrame.origin.y -= newDestinationFrame.size.height;
    }
    
    toVC.view.frame = newDestinationFrame;
    
    [UIView animateWithDuration:PRESENT_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        toVC.view.frame = sourceRect;
        fromVC.view.frame = newOriginFrame;
        fromVC.view.alpha = FROM_VIEW_FINAL_ALPHA;
        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
