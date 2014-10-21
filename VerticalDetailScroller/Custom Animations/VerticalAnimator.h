//
//  VerticalAnimator.h
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


/**
 *  Transitions the view controllers with a vertical slide.
 *  By default, the slide will be downward.
 */
@interface VerticalAnimator : NSObject <UIViewControllerAnimatedTransitioning>

/**
 *  If YES, the slide will be upward. If NO, it will be downward.
 */
@property BOOL isBottomToTopAnimation;

@end
