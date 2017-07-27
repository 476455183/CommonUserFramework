//
//  RMMultipleChoice.m
//  TableViewChoise
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "RMMultipleChoice.h"
#import "RMMultipleChoiceHeadView.h"
#import "RMTitleModel.h"
#import "RMMultipleChoiceCell.h"

NSString *key;
@interface RMMultipleChoice()<UITableViewDataSource,UITableViewDelegate>
/** 视图 */
@property (nonatomic, strong) UITableView *tableView;
/** 数据 */
@property (nonatomic, strong) NSArray *dataArray;
/** 装载section的字典 */
@property (nonatomic, strong) NSMutableDictionary *mutableDic;
/** 字体的颜色 */
@property (nonatomic, strong) UIColor *fontColor;
/** 字体的大小 */
@property (nonatomic, assign) CGFloat fontSize;
/**  选中的图片字符串 */
@property (nonatomic, strong) NSString *selectedImageStr;
/** 没有选中的图片字符串 */
@property (nonatomic, strong) NSString *unselectedImageStr;
/** 展开cell的图片字符串 */
@property (nonatomic, strong) NSString *openCellImageStr;
/** 收起cell的图片字符串 */
@property (nonatomic, strong) NSString *closeCellImageStr;


@end

@implementation RMMultipleChoice

-(NSArray *)dataArray
{
    if(!_dataArray)
    {
        _dataArray = [NSArray array];
    }
    return _dataArray;
}

- (NSMutableDictionary *)mutableDic
{
    if (!_mutableDic)
    {
        _mutableDic = [[NSMutableDictionary alloc] init];
    }
    return  _mutableDic;
}


- (instancetype)initWithFrame:(CGRect)frame
              dataSourceArray:(NSArray *)dataArray
             selectedImageStr:(NSString *)selectedImageStr
           unselectedImageStr:(NSString *)unselectedImageStr
             openCellImageStr:(NSString *)openCellImageStr
            closeCellImageStr:(NSString *)closeCellImageStr
                     fontSize:(CGFloat)fontSize
                    fontColor:(UIColor *)fontColor
{
    if (self = [super initWithFrame:frame])
    {
        // 1、解析成模型数据
        NSMutableArray *mutaArrs = [[NSMutableArray alloc] init];
        for (NSDictionary *question in dataArray) {
            RMTitleModel *titleModel = [RMTitleModel dataWithTitleQuestion:question];
            [mutaArrs addObject:titleModel];
        }
        self.dataArray = [mutaArrs copy];
        
        self.selectedImageStr = selectedImageStr;
        
        self.unselectedImageStr = unselectedImageStr;
        
        self.openCellImageStr = openCellImageStr;
        
        self.closeCellImageStr = closeCellImageStr;
        
        self.fontSize = fontSize;
        
        self.fontColor = fontColor;
        
        //2、设置子控件
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView
{
    UITableView *mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    mainTableView.delegate = self;
    mainTableView.dataSource = self;
    self.tableView = mainTableView;
    [self addSubview:mainTableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.mutableDic objectForKey:[NSString stringWithFormat:@"%ld",section]])
    {
        RMTitleModel *titleModel = self.dataArray[section];
        return titleModel.cellModels.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RMMultipleChoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil)
    {
        cell = [[RMMultipleChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectedImageStr = _selectedImageStr;
        cell.unselectedImageStr = _unselectedImageStr;
        cell.fontSize = _fontSize;
        cell.fontColor = _fontColor;
    }
    
    RMTitleModel *titleModel = self.dataArray[indexPath.section];
    cell.cellModel = titleModel.cellModels[indexPath.row];
    
    cell.backBlock = ^(UIButton *btn)
    {
        // 表头button随着count不为0而确定是否选中
        RMMultipleChoiceHeadView *view = (RMMultipleChoiceHeadView *)[tableView headerViewForSection:indexPath.section];
        NSLog(@"%ld",(long)titleModel.count);
        [view setCount:titleModel.count];
    };
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    RMMultipleChoiceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell selectedMethod:cell.cellSelectedBtn];
    
    // 表头button随着count不为0而确定是否选中
    RMTitleModel *titleModel = self.dataArray[indexPath.section];
    RMMultipleChoiceHeadView *view = (RMMultipleChoiceHeadView *)[tableView headerViewForSection:indexPath.section];
    [view setCount:titleModel.count];
    
   // __weak typeof(self) weakSelf = self;
    if (self.selectedSectionForRowBlock)
        self.selectedSectionForRowBlock(indexPath.section,indexPath.row);
    
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //分区头的内容
    RMMultipleChoiceHeadView *view = [RMMultipleChoiceHeadView headerViewWithTableView:tableView selecteTitleImageStr:self.selectedImageStr unselectedTitleImageStr:self.unselectedImageStr openCellImageStr:self.openCellImageStr closeCellImageStr:self.closeCellImageStr];
    RMTitleModel *titleModel = self.dataArray[section];
    view.count = titleModel.count;
    if (titleModel.count > 0)
        titleModel.sectionSelected = YES;
    else
        titleModel.sectionSelected = NO;
    view.sectionTitleLab.text = titleModel.sectionTitle;
    view.sectionTitleLab.font = [UIFont systemFontOfSize:_fontSize];
    view.sectionTitleLab.textColor = _fontColor;
    if ([self.mutableDic objectForKey:[NSString stringWithFormat:@"%@",@(section)]])
        //[view.rightSelectBtn setImage:[UIImage imageNamed:@"choose_select"] forState:UIControlStateNormal];
        [view.rightSelectBtn setImage:[UIImage imageNamed:_openCellImageStr] forState:UIControlStateNormal];
    else
        [view.rightSelectBtn setImage:[UIImage imageNamed:_closeCellImageStr] forState:UIControlStateNormal];
    
    __strong typeof(RMMultipleChoiceHeadView *) headView = view;
    __weak typeof(self) weakSelf = self;
    
    // 展开或收起section的cell
    view.actionBlock = ^(){
        key = [NSString stringWithFormat:@"%@",@(section)];
        if(![weakSelf.mutableDic objectForKey:key])
        {
            [weakSelf.mutableDic setObject:@"1" forKey:key];
            [headView.rightSelectBtn setImage:[UIImage imageNamed:_openCellImageStr] forState:UIControlStateNormal];
        }
        else
        {
            [weakSelf.mutableDic removeObjectForKey:key];
            [headView.rightSelectBtn setImage:[UIImage imageNamed:_closeCellImageStr] forState:UIControlStateNormal];
        }
        [tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationFade];
    };
    
    // 修改数据源，然后刷新tableView
    view.selectedBtn = ^(UIButton *btn)
    {
        RMTitleModel *titleModel = self.dataArray[section];
        if (btn.selected)
        {
            for (RMCellModel *cellModel in titleModel.cellModels) {
                cellModel.selected = NO;
            }
        }
        else
        {
            for (RMCellModel *cellModel in titleModel.cellModels) {
                cellModel.selected = YES;
            }
        }
        [weakSelf.tableView reloadData];
        
    };
    return view;
}

- (NSArray *)getAlltheSelectedAnswers
{
    NSMutableArray *titleAndQuetions = [[NSMutableArray alloc] init];
    for (RMTitleModel *titleModel in self.dataArray) {
        if (titleModel.sectionSelected)
        {
            NSMutableArray *mutaArr = [[NSMutableArray alloc] init];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
            for (RMCellModel *cellModel in titleModel.cellModels) {
                if (cellModel.selected)
                    [mutaArr addObject:cellModel.cellTitle];
            }
            [dict setValue:[mutaArr copy] forKey:titleModel.sectionTitle];
            [titleAndQuetions addObject:dict];
        }
    }
    return [titleAndQuetions copy];
}


@end
