//
//  UIColor+JSONInitializer.m
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import "UIColor+JSONInitializer.h"

@implementation UIColor (JSONInitializer)


+ (UIColor *)colorWithJSONParsedDict:(NSDictionary *)colorDict
{
    UIColor *color = [UIColor colorWithRed:[colorDict[@"Red"] integerValue]/255.0 green:[colorDict[@"Green"] integerValue]/255.0 blue:[colorDict[@"Blue"] integerValue]/255.0 alpha:1];
    
    return color;
}

@end
