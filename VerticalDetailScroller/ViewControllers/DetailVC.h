//
//  DetailVC.h
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayDataSource.h"


/**
 *  DetailVC shows a UIScrollView with layout built using Interface Builder.
 *
 *  By scrolling beyound the content size of the Scroll View, it is possible to trigger a vertical transition to another (sibling) DetailVC.
 *
 *  This transition can be automatic or interactive. There's a Button on the Navigation Bar to change the transition type.
 */
@interface DetailVC : UIViewController

/**
 *  Used as the background color of the view
 */
@property (nonatomic, strong) UIColor *detailColor;

/**
 *  The same dataSource as the one on ListVC. Used to allow navigation between detail siblings.
 */
@property (nonatomic, strong) ArrayDataSource *arrayDataSource;

/**
 *  The position of this detail on ListVC
 */
@property NSInteger detailPosition;

/**
 *  YES if the selected transition type is Interactive, NO otherwise.
 */
@property BOOL isInteractiveTransition;

@end
