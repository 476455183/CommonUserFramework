//
//  DropDownList.h
//  DropDownList(下拉框选择)
//
//  Created by Mr_zhang on 17/1/9.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropDownList : UIView<UITableViewDelegate,UITableViewDataSource>

/**
 闭包回调,传值
 */
@property (nonatomic, copy) void(^myBlock)(NSInteger row, NSString *title);

// tableview的模型数据
@property (nonatomic, strong) NSArray *dataArray;


/**
 初始化下拉框

 @param frame 下拉框的大小
 @param dataArray 数据
 @param view 加载的视图
 @return 实例对象
 */
- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray onTheView:(UIView *)view;

@end
