//
//  RMCellTitleModel.m
//  TableViewChoise
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "RMTitleModel.h"

@implementation RMTitleModel

+ (RMTitleModel *)dataWithTitleQuestion:(NSDictionary *)dict
{
    RMTitleModel *titleModel = [[RMTitleModel alloc] init];
    titleModel.cellModels = [RMCellModel modelWithAnswer:dict[@"answer"]];
    titleModel.sectionTitle = dict[@"title"];
    titleModel.sectionSelected = [dict[@"selected"] boolValue];
    return titleModel;
}

- (NSInteger)count
{
    NSInteger num = 0;
    for (int i = 0; i < self.cellModels.count; i++) {
        RMCellModel *model = self.cellModels[i];
        if (model.selected)
        {
            num++;
        }
    }
    return num;
}

@end
