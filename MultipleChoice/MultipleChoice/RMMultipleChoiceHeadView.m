//
//  RMMultipleChoiceHeadView.m
//  TableViewChoise
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "RMMultipleChoiceHeadView.h"

@implementation RMMultipleChoiceHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

+(instancetype)headerViewWithTableView:(UITableView *)tableView
                  selecteTitleImageStr:(NSString *)selectedTitleImageStr
               unselectedTitleImageStr:(NSString *)unselectedTitleImageStr
                      openCellImageStr:(NSString *)openCellImageStr
                     closeCellImageStr:(NSString *)closeCellImageStr
{
    RMMultipleChoiceHeadView *headView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"headView"];
    if (!headView)
    {
        headView = [[RMMultipleChoiceHeadView alloc] initWithReuseIdentifier:@"headView"];
        headView.selectedTitleImageStr = selectedTitleImageStr;
        headView.unselectedTitleImageStr = unselectedTitleImageStr;
        headView.openCellImageStr = openCellImageStr;
        headView.closeCellImageStr = closeCellImageStr;
    }
    return headView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier])
    {
        UIButton *selectedBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        selectedBtn.frame = CGRectMake(10, 10, 20, 20);
        [selectedBtn addTarget:self action:@selector(selectedMethod:) forControlEvents:UIControlEventTouchUpInside];
        self.sectionSelectBtn = selectedBtn;
        [self.contentView addSubview:self.sectionSelectBtn];
        
        UILabel *questionLab = [[UILabel alloc] initWithFrame:CGRectMake(40, 10, [UIScreen mainScreen].bounds.size.width - 60, 20)];
        self.sectionTitleLab = questionLab;
        [self.contentView addSubview:self.sectionTitleLab];
        
        UIButton *rightSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        rightSelectBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 30, 10, 20, 20);
        [rightSelectBtn addTarget:self action:@selector(openCell:) forControlEvents:UIControlEventTouchUpInside];
        // [rightSelectBtn setImage:[UIImage imageNamed:@"choose_nomal"] forState:UIControlStateNormal];
        self.rightSelectBtn = rightSelectBtn;
        [self.contentView addSubview:self.rightSelectBtn];
        
        //添加headView手势,触发分区cell的展开与收缩
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(openCell:)];
        tap.numberOfTapsRequired = 1;
        tap.delegate = self;
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setCount:(NSInteger)count
{
    if (count > 0)
    {
        self.sectionSelectBtn.selected = YES;
        [self.sectionSelectBtn setImage:[UIImage imageNamed:self.selectedTitleImageStr] forState:UIControlStateNormal];
    }
    else
    {
        self.sectionSelectBtn.selected = NO;
        [self.sectionSelectBtn setImage:[UIImage imageNamed:self.unselectedTitleImageStr] forState:UIControlStateNormal];
    }
}

- (void)openCell:(UITapGestureRecognizer *)tap
{
    self.actionBlock();
}

- (void)openCellList:(UIButton *)sender
{
    self.rightSeleted = !self.rightSeleted;
    if (self.rightSeleted)
        [sender setImage:[UIImage imageNamed:self.openCellImageStr] forState:UIControlStateNormal];
    else
        [sender setImage:[UIImage imageNamed:self.closeCellImageStr] forState:UIControlStateNormal];
    self.actionBlock();
}

- (void)selectedMethod:(UIButton *)sender
{
    // 回调，修改数据源
    self.selectedBtn(sender);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"])
    {
        return NO;
    }
    return YES;
}

@end
