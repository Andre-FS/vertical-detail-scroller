//
//  ArrayDataSource.h
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  ArrayDataSource can be used as the DataSource for a UITableView.
 */
@interface ArrayDataSource : NSObject <UITableViewDataSource>

/**
 *  Returns the item at position indexPath.row of the dataSource.
 *
 *  @param indexPath
 *
 *  @return Item at position indexPath.row of the dataSource array.
 */
- (id)dataAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  
 *
 *  @param itemsArray     Array with items to be used for each cell
 *  @param configureBlock Block that will be called to configure each cell
 *
 *  @return An initialized object, or nil if an object could not be created for some reason that would not result in an exception.
 */
- (instancetype)initWithArray:(NSArray *)itemsArray configureCellBlock:(void (^)(id cell, id item))configureBlock;

/**
 *  @param position The position to use when checking for the next sibling.
 *
 *  @return The next sibling for a certain position. Nil if out of bounds.
 */
- (id)nextSiblingWithPosition:(NSInteger)position;

/**
 *  @param position The position to use when checking the previous sibling.
 *
 *  @return The previous sibling for a certain position. Nil if out of bounds.
 */
- (id)previousSiblingWithPosition:(NSInteger)position;

@end
