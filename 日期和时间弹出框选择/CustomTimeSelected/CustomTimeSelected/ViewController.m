//
//  ViewController.m
//  CustomTimeSelected
//
//  Created by Mr_zhang on 17/2/6.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "ViewController.h"
#import "GZPublicMethod.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *seletedDate;
@property (weak, nonatomic) IBOutlet UIButton *selectedTime;
@property (weak, nonatomic) IBOutlet UIButton *selectedDateAndTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
    
}

// 选择日期
- (IBAction)opentData:(id)sender
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    [GZPublicMethod showSelectDatePicker:@"选择日期" showDate:dateString mode:UIDatePickerModeDate format:@"yyyy-MM-dd" viewControl:self selectedDate:^(NSString *myDate) {
        [self.seletedDate setTitle:myDate forState:UIControlStateNormal];
    } cancel:^{
        NSLog(@"FAILE");
    }];
}

// 选择时间
- (IBAction)openTime:(id)sender
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    [GZPublicMethod showSelectDatePicker:@"选择时间" showDate:dateString mode:UIDatePickerModeTime format:@"HH:mm:ss" viewControl:self selectedDate:^(NSString *myDate) {
        [self.selectedTime setTitle:myDate forState:UIControlStateNormal];
    } cancel:^{
        NSLog(@"FAILE");
    }];
}

// 选择日期和时间
- (IBAction)openDateAndTime:(id)sender
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    [GZPublicMethod showSelectDatePicker:@"选择日期和时间" showDate:dateString mode:UIDatePickerModeDateAndTime format:@"yyyy-MM-dd HH:mm:ss" viewControl:self selectedDate:^(NSString *myDate) {
        [self.selectedDateAndTime setTitle:myDate forState:UIControlStateNormal];
    } cancel:^{
        NSLog(@"FAILE");
    }];
}

@end
