//
//  RMMultipleChoiceCell.m
//  TableViewChoise
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "RMMultipleChoiceCell.h"

@implementation RMMultipleChoiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        // 1、初始化设置子控件
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(40, 10, 20, 20);
    [btn addTarget:self action:@selector(selectedMethod:) forControlEvents:UIControlEventTouchUpInside];
    self.cellSelectedBtn = btn;
    [self.contentView addSubview:self.cellSelectedBtn];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(70, 10, self.frame.size.width - 70, 24)];
    self.cellTitle = lab;
    [self.contentView addSubview:self.cellTitle];
}

- (void)setCellModel:(RMCellModel *)cellModel
{
    _cellModel = cellModel;
    self.cellTitle.text = cellModel.cellTitle;
    // 选中时的图片或未选中时的图片
    [self selectedImage:_cellModel];
    // 字体的大小和颜色
    self.cellTitle.font = [UIFont systemFontOfSize:self.fontSize];
    self.cellTitle.textColor = self.fontColor;
}

- (void)selectedMethod:(UIButton *)sender
{
    _cellModel.selected = !_cellModel.selected;
    // 选中时的图片或未选中时的图片
    [self selectedImage:_cellModel];
    
    self.backBlock(sender);
}

#pragma mark - 选中时的图片或未选中时的图片
- (void)selectedImage:(RMCellModel *)cellModel
{
    if (cellModel.selected)
        [self.cellSelectedBtn setImage:[UIImage imageNamed:self.selectedImageStr] forState:UIControlStateNormal];
    else
        [self.cellSelectedBtn setImage:[UIImage imageNamed:self.unselectedImageStr] forState:UIControlStateNormal];
}

@end
