//
//  ViewController.m
//  CustomTimeSelected
//
//  Created by Mr_zhang on 17/2/6.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "ViewController.h"
#import "RMPublicMethod.h"

@interface ViewController ()
/** 获取年龄的textfield */
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

/** 自定义日期textfield */
@property (weak, nonatomic) IBOutlet UITextField *customDateTextField;

/** 获取当前星期textfield */
@property (weak, nonatomic) IBOutlet UITextField *weekDaysTextField;

/** 选择日期 */
@property (weak, nonatomic) IBOutlet UIButton *seletedDate;

/** 选择时间 */
@property (weak, nonatomic) IBOutlet UIButton *selectedTime;

/** 选择日期和时间 */
@property (weak, nonatomic) IBOutlet UIButton *selectedDateAndTime;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - 获取年龄
- (IBAction)getTheAge:(UIButton *)sender
{
    // 注意：self.ageTextField.text 为 2015-08-21 12:00:00 这类型的格式。
    NSString *age = [RMPublicMethod userAge:self.ageTextField.text];
    [sender setTitle:age forState:UIControlStateNormal];
}

#pragma mark - 获取自定义格式的日期
- (IBAction)getTheCustomDate:(UIButton *)sender
{
    // 注意：customDateTextField 为 2015-08-21 12:00:00 这类型的格式
    NSString *date = [RMPublicMethod customDate2:self.customDateTextField.text withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [sender setTitle:date forState:UIControlStateNormal];
}

#pragma mark - 根据日期获取当前星期
- (IBAction)getTheWeekDays:(UIButton *)sender
{
    // 注意：customDateTextField 为 2015-08-21 12:00:00 这类型的格式
    NSString *date = [RMPublicMethod weekdayStringFromDate:self.weekDaysTextField.text withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [sender setTitle:date forState:UIControlStateNormal];
}


#pragma mark - 选择日期
- (IBAction)opentData:(id)sender
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    [RMPublicMethod showSelectDatePicker:@"选择日期" showDate:dateString mode:UIDatePickerModeDate format:@"yyyy-MM-dd" viewControl:self selectedDate:^(NSString *myDate) {
        [self.seletedDate setTitle:myDate forState:UIControlStateNormal];
    } cancel:^{
        NSLog(@"FAILE");
    }];
}

#pragma mark - 选择时间
- (IBAction)openTime:(id)sender
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    [RMPublicMethod showSelectDatePicker:@"选择时间" showDate:dateString mode:UIDatePickerModeTime format:@"HH:mm:ss" viewControl:self selectedDate:^(NSString *myDate) {
        [self.selectedTime setTitle:myDate forState:UIControlStateNormal];
    } cancel:^{
        NSLog(@"FAILE");
    }];
}

#pragma mark - 选择日期和时间
- (IBAction)openDateAndTime:(id)sender
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSString *dateString = [dateFormatter stringFromDate:currentDate];
    [RMPublicMethod showSelectDatePicker:@"选择日期和时间" showDate:dateString mode:UIDatePickerModeDateAndTime format:@"yyyy-MM-dd HH:mm:ss" viewControl:self selectedDate:^(NSString *myDate) {
        [self.selectedDateAndTime setTitle:myDate forState:UIControlStateNormal];
    } cancel:^{
        NSLog(@"FAILE");
    }];
}

@end
