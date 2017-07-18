//
//  ViewController.m
//  DropDownList(下拉框选择)
//
//  Created by Mr_zhang on 17/1/9.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "ViewController.h"
#import "DropDownList.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (weak, nonatomic) IBOutlet UILabel *listenLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 弹出选择框

 @param sender 按钮
 */
- (IBAction)dropSelectedList:(id)sender
{
    NSArray *dataArray = [[NSArray alloc] initWithObjects:@"听见下雨的声音1",@"听见下雨的声音1",@"听见下雨的声音2",@"听见下雨的声音1",@"听见下雨的声音2",@"听见下雨的声音3",@"听见下雨的声音4", nil];
    
    CGFloat drop_X = self.button.frame.origin.x;
    CGFloat drop_Y = CGRectGetMaxY(self.button.frame);
    CGFloat drop_W = self.button.frame.size.width;
    CGFloat drop_H = dataArray.count * 40 + 10;
    
    DropDownList *dropList = [[DropDownList alloc] initWithFrame:CGRectMake(drop_X, drop_Y, drop_W, drop_H) dataArray:dataArray onTheView:self.view] ;
    
    dropList.myBlock = ^(NSInteger row,NSString *title)
    {
        self.listenLab.text = title;
    };
    
    [self.view addSubview:dropList];

}

@end
