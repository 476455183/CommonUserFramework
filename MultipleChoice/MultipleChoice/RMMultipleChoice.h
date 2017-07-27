//
//  RMMultipleChoice.h
//  TableViewChoise
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^selectSectionForRowBlock)(NSInteger section, NSInteger row);

@interface RMMultipleChoice : UIView
/** 选中cell时，返回cell所在的section,row */
@property (nonatomic, copy) selectSectionForRowBlock selectedSectionForRowBlock;

/**
 *  创建一个多选的视图
 *
 *  @param frame                  视图的大小frame
 *  @param dataArray              存放数据的数组
 *  @param selectedImageStr       选中的图片字符串
 *  @param unselectedImageStr     没有选中的图片字符串
 *  @param openCellImageStr       展开cell的图片字符串
 *  @param closeCellImageStr      收起cell的图片字符串
 *  @param fontSize               字体的大小
 *  @param fontColor              字体的颜色
 *  @return 视图
 */
- (instancetype)initWithFrame:(CGRect)frame
              dataSourceArray:(NSArray *)dataArray
             selectedImageStr:(NSString *)selectedImageStr
           unselectedImageStr:(NSString *)unselectedImageStr
             openCellImageStr:(NSString *)openCellImageStr
            closeCellImageStr:(NSString *)closeCellImageStr
                     fontSize:(CGFloat)fontSize
                    fontColor:(UIColor *)fontColor;

/**
 *  获取所有勾选中的问题答案
 *
 *  @return 答案数组
 */
- (NSArray *)getAlltheSelectedAnswers;

@end
