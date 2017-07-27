//
//  RMCellModel.h
//  MultipleChoice
//
//  Created by Mr_zhang on 2017/7/26.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RMCellModel : NSObject

/** 题目的答案(cell的标题) */
@property (nonatomic, strong) NSString *cellTitle;
/** 勾选(答案是否选择，默认为NO) */
@property (nonatomic, assign) BOOL selected;


/**
 生成答案模型的数组

 @param answers 答案数组（包含了cell标题和selected两个参数）
 @return 模型答案数组
 */
+ (NSArray *)modelWithAnswer:(NSArray *)answers;

@end
