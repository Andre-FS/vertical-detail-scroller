//
//  ArrayDataSource.m
//  VerticalDetailScroller
//
//  Created by André Silva on 20/10/14.
//  Copyright (c) 2014 andrefs. All rights reserved.
//

#import "ArrayDataSource.h"

@interface ArrayDataSource ()


@property (nonatomic, strong) NSArray *sourceArray;
@property (nonatomic, copy) void (^configureCellBlock)(id, id);

@end

@implementation ArrayDataSource


- (instancetype)initWithArray:(NSArray *)itemsArray configureCellBlock:(void (^)(id, id))configureBlock
{
    self = [super init];
    if(self)
    {
        self.sourceArray = itemsArray;
        self.configureCellBlock = configureBlock;
    }
    return self;
}

#pragma mark - DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.sourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"]; //ToDo: add the cell identifier to the ArrayDataSource init. Otherwise, no other cell type can be used by this DataSource.
    
    id item = self.sourceArray[indexPath.row];
    
    self.configureCellBlock(cell, item);
    
    return cell;
}

#pragma mark - Data Exposure

- (id)dataAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row >= self.sourceArray.count)
        return nil; //ToDo: Refactor and expose NSError in this situation
    
    return self.sourceArray[indexPath.row];
}


- (id)nextSiblingWithPosition:(NSInteger)position
{
    if(position >= self.sourceArray.count - 1)
        return nil;
    
    return self.sourceArray[position+1];
}

- (id)previousSiblingWithPosition:(NSInteger)position
{
    if(position <= 0)
        return nil;
    
    return  self.sourceArray[position-1];
}



@end
