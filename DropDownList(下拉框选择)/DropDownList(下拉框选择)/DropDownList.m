//
//  DropDownList.m
//  DropDownList(下拉框选择)
//
//  Created by Mr_zhang on 17/1/9.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "DropDownList.h"

@interface DropDownList()

@property (nonatomic, strong) UITableView *dropDownTableView;

@property (nonatomic, strong) UILabel *label;

@property (nonatomic, strong) UIView *coverView;

@end

@implementation DropDownList

- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray onTheView:(UIView *)view
{
    if (self = [super initWithFrame:frame])
    {
        /* 0.弹出遮挡页面遮挡界面 */
        self.coverView = [[UIView alloc] initWithFrame:view.frame];
        _coverView.backgroundColor = [UIColor blackColor];
        _coverView.alpha = 0.1f;
        UITapGestureRecognizer *coverTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moveTheCoverView)];
        [_coverView addGestureRecognizer:coverTap];
        [view addSubview:_coverView];
        
        /* 1.设置view的背景图片，背景图片为imageView担任 */
        // 图片拉伸处理
        UIImage *image = [UIImage imageNamed:@"selected_popup.png"];
        // 上左下右拉伸不拉伸部分的距离
        CGFloat top = 20;
        CGFloat left = 10;
        CGFloat bottom = 20;
        CGFloat right = 40;
        UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
        image = [image resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
        
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        imageView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        [self addSubview:imageView];
        
        /* 2.定义tableview */
        self.dropDownTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, frame.size.width, frame.size.height - 10) style:UITableViewStylePlain];
        self.dropDownTableView.layer.cornerRadius = 5;
        self.dropDownTableView.layer.masksToBounds = YES;
        self.dropDownTableView.delegate = self;
        self.dropDownTableView.dataSource = self;
        self.dropDownTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.dropDownTableView];
        
        /* 3.传值 */
        // 赋值
        self.dataArray = dataArray;
        
    }
    return self;
}

#pragma mark UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 选中时的颜色不显示
    [self.dropDownTableView deselectRowAtIndexPath:indexPath animated:NO];
    
    // 调用block传值
    self.myBlock(indexPath.row,self.dataArray[indexPath.row]);
    
    // 移除遮挡页面和tableview
    [self moveTheCoverView];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

#pragma mark 移除遮挡页面和tableview
- (void)moveTheCoverView
{
    [self.coverView removeFromSuperview];
    [self removeFromSuperview];
}


@end
