//
//  RMCellTitleModel.h
//  TableViewChoise
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RMCellModel.h"

@interface RMTitleModel : NSObject
/** 题目的标题(分区的标题) */
@property (nonatomic, strong) NSString *sectionTitle;
/** 存放所有答案（cell标题）的模型 */
@property (nonatomic, strong) NSArray *cellModels;
/** 勾选（分区标题，默认为NO） */
@property (nonatomic, assign) BOOL sectionSelected;
/** 统计cell标题的勾选数量 */
@property (nonatomic, assign) NSInteger count;


/**
 生成一个模型

 @param dict 字典
 @return 返回一个RMTitleModel模型
 */
+ (RMTitleModel *)dataWithTitleQuestion:(NSDictionary *)dict;

@end
