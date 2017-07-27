//
//  RMMultipleChoiceHeadView.h
//  TableViewChoise
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^action)();

typedef void(^clickSelectedBtnMethod)(UIButton *btn);

@interface RMMultipleChoiceHeadView : UITableViewHeaderFooterView <UIGestureRecognizerDelegate>
/** 分区的选择框 */
@property (nonatomic, strong) UIButton *sectionSelectBtn;
/** 展示框 */
@property (nonatomic, strong) UIButton *rightSelectBtn;
/** 分区标题 */
@property (nonatomic, strong) UILabel *sectionTitleLab;
/** 统计cell标题的勾选数量 */
@property (nonatomic, assign) NSInteger count;
/** 点击分区头时的回调，处理是否展开列表的block */
@property (nonatomic, strong) action actionBlock;
/** 点击选择框时的回调,主要是修改刷新数据源 */
@property (nonatomic, strong) clickSelectedBtnMethod selectedBtn;
/** 展示框是否选中 */
@property (nonatomic, assign) BOOL rightSeleted;

/** 接收选中标题的图片字符串 */
@property (nonatomic, copy) NSString *selectedTitleImageStr;
/** 接收未选中标题的图片字符串 */
@property (nonatomic, copy) NSString *unselectedTitleImageStr;
/** 接收右边展开cell列表的图片字符串 */
@property (nonatomic, copy) NSString *openCellImageStr;
/** 接收右边关闭cell列表的图片字符串 */
@property (nonatomic, copy) NSString *closeCellImageStr;
/** 字体大小 */
@property (nonatomic, assign) CGFloat fontSize;
/** 字体颜色 */
@property (nonatomic, strong) UIColor *fontColor;

+(instancetype)headerViewWithTableView:(UITableView *)tableView
                  selecteTitleImageStr:(NSString *)selectedTitleImageStr
               unselectedTitleImageStr:(NSString *)unselectedTitleImageStr
                      openCellImageStr:(NSString *)openCellImageStr
                     closeCellImageStr:(NSString *)closeCellImageStr;
@end
