//
//  UIColor+JSONInitializer.h
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (JSONInitializer)

/**
 *  Helper method that creates and initializes a UIColor object with a NSDictionary.
 *
 *  @param colorDict A NSDictionary with the following keys: "Red", "Green" and "Blue".
 *
 *  @return A ready to use UIColor object.
 */
+ (UIColor *)colorWithJSONParsedDict:(NSDictionary *)colorDict;

@end
