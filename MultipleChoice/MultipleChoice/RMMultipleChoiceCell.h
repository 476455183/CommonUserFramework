//
//  RMMultipleChoiceCell.h
//  TableViewChoise
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RMTitleModel.h"


typedef void(^selectedbackBlock)(UIButton *btn);

@interface RMMultipleChoiceCell : UITableViewCell
/** 标题 */
@property (nonatomic, strong) UILabel *cellTitle;
/** 勾选框 */
@property (nonatomic, strong) UIButton *cellSelectedBtn;
/** 模型 */
@property (nonatomic, strong) RMCellModel *cellModel;
/** 选中cell时或勾选框时的回调 */
@property (nonatomic ,strong) selectedbackBlock backBlock;


/** 接收选中标题的图片字符串 */
@property (nonatomic, copy) NSString *selectedImageStr;
/** 接收未选中标题的图片字符串 */
@property (nonatomic, copy) NSString *unselectedImageStr;
/** 字体大小 */
@property (nonatomic, assign) CGFloat fontSize;
/** 字体颜色 */
@property (nonatomic, strong) UIColor *fontColor;

/**
 *  勾选框的点击方法
 *
 *  @sender 点击的勾选框btn
 */
- (void)selectedMethod:(UIButton *)sender;
@end
