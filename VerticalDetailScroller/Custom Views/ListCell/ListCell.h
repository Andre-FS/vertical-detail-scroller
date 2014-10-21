//
//  ListCell.h
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;


- (void)configureForTitle:(NSString *)title andColor:(UIColor *)cellColor;

@end
