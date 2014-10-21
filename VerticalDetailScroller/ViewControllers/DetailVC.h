//
//  DetailVC.h
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ArrayDataSource.h"

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
