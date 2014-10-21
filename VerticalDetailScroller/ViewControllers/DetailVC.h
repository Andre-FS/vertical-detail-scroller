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

@property (nonatomic, strong) UIColor *detailColor;
@property (nonatomic, strong) ArrayDataSource *arrayDataSource;
@property NSInteger detailPosition;
@property BOOL isInteractiveTransition;

@end
