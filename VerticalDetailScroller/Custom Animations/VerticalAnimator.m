//
//  VerticalAnimator.m
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import "VerticalAnimator.h"

const CGFloat PRESENT_DURATION = 0.5;

@implementation VerticalAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    CGRect sourceRect = [transitionContext initialFrameForViewController:fromVC];
    
    UIView *container = [transitionContext containerView];
    
    [container addSubview:toVC.view];
    
    if(self.isBottomToTopAnimation)
    {
        CGRect newOriginFrame = sourceRect;
        newOriginFrame.origin.y -= newOriginFrame.size.height;
        
        CGRect newDestinationFrame = sourceRect;
        newDestinationFrame.origin.y += newDestinationFrame.size.height;
        toVC.view.frame = newDestinationFrame;
        
        [UIView animateWithDuration:PRESENT_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            toVC.view.frame = sourceRect;
            fromVC.view.frame = newOriginFrame;
            fromVC.view.alpha = 0;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }else
    {
        CGRect newOriginFrame = sourceRect;
        newOriginFrame.origin.y += newOriginFrame.size.height;
        
        CGRect newDestinationFrame = sourceRect;
        newDestinationFrame.origin.y -= newDestinationFrame.size.height;
        toVC.view.frame = newDestinationFrame;
        
        [UIView animateWithDuration:PRESENT_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
            toVC.view.frame = sourceRect;
            fromVC.view.frame = newOriginFrame;
            fromVC.view.alpha = 0;
            
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
        }];
    }
    
    
    
}

@end
