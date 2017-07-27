//
//  ViewController.m
//  MultipleChoice
//
//  Created by Mr_zhang on 2017/7/21.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "ViewController.h"
#import "RMMultipleChoice.h"

@interface ViewController ()

@property (nonatomic, strong) NSMutableDictionary *mutaDic;

@property (nonatomic, strong) RMMultipleChoice *multipe;

@end

@implementation ViewController

- (NSMutableDictionary *)mutaDic
{
    if (!_mutaDic)
    {
        _mutaDic = [[NSMutableDictionary alloc] init];
    }
    return _mutaDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏的风格和字体颜色
    self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    self.navigationItem.title = @"多选展开和收缩";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"获取所有答案" style:UIBarButtonItemStylePlain target:self action:@selector(getAllQuestionsAnswer)];
    
    // 从plist文件中获取数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"plist"];
    NSArray *dataArray = [[NSDictionary dictionaryWithContentsOfFile:path] objectForKey:@"question"];
    
    
    self.multipe = [[RMMultipleChoice alloc] initWithFrame:self.view.frame dataSourceArray:dataArray selectedImageStr:@"selected" unselectedImageStr:@"unselected" openCellImageStr:@"choose_select" closeCellImageStr:@"choose_nomal" fontSize:13 fontColor:[UIColor redColor]];
    [self.view addSubview:_multipe];
    
    self.multipe.selectedSectionForRowBlock = ^(NSInteger section, NSInteger row) {
        NSLog(@"你选择了第%ld个问题的第%ld个答案",section+1,row+1);
    };
    
}

- (void)getAllQuestionsAnswer
{
    NSArray *answers = [self.multipe getAlltheSelectedAnswers];
    NSLog(@"answers:%@",answers);
}

@end
