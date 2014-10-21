//
//  ListCell.m
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import "ListCell.h"

@implementation ListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configureForTitle:(NSString *)title andColor:(UIColor *)cellColor
{
    self.mainTitleLabel.text = title;
    self.backgroundColor = cellColor;
}


@end
