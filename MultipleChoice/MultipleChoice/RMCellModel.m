//
//  RMCellModel.m
//  MultipleChoice
//
//  Created by Mr_zhang on 2017/7/26.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "RMCellModel.h"

@implementation RMCellModel

+ (NSArray *)modelWithAnswer:(NSArray *)answers;
{
    NSMutableArray *cellModels = [[NSMutableArray alloc] init];
    for (NSDictionary *dict in answers) {
        RMCellModel *cellModel = [[self alloc] init];
        cellModel.selected = [dict[@"selected"] boolValue];
        cellModel.cellTitle = dict[@"cellTitle"];
        [cellModels addObject:cellModel];
    }
   
    return cellModels;
}

@end
