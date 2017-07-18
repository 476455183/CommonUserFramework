//
//  RMPublicMethod.m
//  CustomTimeSelected
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import "RMPublicMethod.h"


@implementation RMPublicMethod

#pragma mark ------- 日期相关 ------

/**
 *  获取年龄
 *
 *  @param birthday 用户生日日期, 如1990-08-04
 *
 *  @return 用户年龄
 */
+ (NSString *)userAge:(NSString *)birthday
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    //NSDate *doc_date = [dateFormatter dateFromString:@"2010-08-04 16:01:03"];
    NSDate *doc_date = [dateFormatter dateFromString:birthday];
    
    //1代表向后推几天，如果是0则代表是今天，如果是1就代表向后推24小时，如果想向后推12小时，就可以改成dayDelay*12*60*60,让dayDelay＝1
    NSDate *dateNow=[NSDate dateWithTimeIntervalSinceNow:0*24*60*60];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历
    NSDateComponents *comps_now = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps_now = [calendar components:unitFlags fromDate:dateNow];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps = [calendar components:unitFlags fromDate:doc_date];
    
    long age = [comps_now year] - [comps year];
    NSString *age_str = [NSString stringWithFormat:@"%ld", age];
    return age_str;
}

/**
 *  获取当前日期和时间
 *
 *  @param format 格式如@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 当前日期和时间
 */
+ (NSString *)todayDate:(NSString *)format
{
    NSDate *dateNow=[NSDate dateWithTimeIntervalSinceNow:0];
    NSString *today = [self stringFromDate:dateNow withDateFormat:format];
    return today;
}

/**
 *  获取自定义格式的日期
 *
 *  @param nsDate 字符串日期：@"2015-08-21 12:00:00"
 *  @param format 日期格式化：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 返回格式如："05-02 星期二 上午"
 */
+ (NSString *)customDate:(NSString *)nsDate withDateFormat:(NSString *)format
{
    NSString *month_day = [nsDate substringWithRange:NSMakeRange(5, 5)];
    NSString *week = [self weekdayStringFromDate:nsDate withDateFormat:format];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h:mm:ss a"];
    NSDate *date1 = [self dateFromString:nsDate withDateFormat:format];
    NSString *am_pm = [dateFormatter stringFromDate:date1];
    am_pm = [am_pm substringWithRange:NSMakeRange(am_pm.length-2, 2)];
    if ([am_pm isEqualToString:@"AM"])
        am_pm = @"上午";
    else
        am_pm = @"下午";
    
    NSString *nsCustomDate = [NSString stringWithFormat:@"%@ %@ %@",month_day,week,am_pm];
    return nsCustomDate;
}

/**
 *  获取自定义格式的日期
 *
 *  @param nsDate 字符串日期：@"2015-08-21 12:00:00"
 *  @param format 日期格式化：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 返回格式如："05-02 星期二 上午09:00"
 */
+ (NSString *)customDate2:(NSString *)nsDate withDateFormat:(NSString *)format
{
    NSString *month_day = [nsDate substringWithRange:NSMakeRange(5, 5)];
    NSString *week = [self weekdayStringFromDate:nsDate withDateFormat:format];
    NSDate *date1 = [self dateFromString:nsDate withDateFormat:format];
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit ) fromDate:date1];
    //NSLog(@"hour: %ld, min: %ld, sec: %ld", components.hour, components.minute, components.second);
    NSString *am_pm = @"上午";
    if (components.hour >= 12)
        am_pm = @"下午";
    NSString *am_pm_time = [nsDate substringWithRange:NSMakeRange(11, 5)];
    
    NSString *customDate = [NSString stringWithFormat:@"%@ %@ %@%@",month_day,week,am_pm,am_pm_time];
    return customDate;
}

/**
 *  根据日期获取当前星期
 *
 *  @param nsDate 字符串日期：@"2015-08-21 12:00:00"
 *  @param format 日期格式化：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 星期
 */
+ (NSString*)weekdayStringFromDate:(NSString *)nsDate withDateFormat:(NSString *)format
{
    NSDate *inputDate = [self dateFromString:nsDate withDateFormat:format];
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
}

/**
 *  显示日期时间选择器
 *
 *  @param title       显示的标题
 *  @param showDate    弹出时默认显示的日期或时间
 *  @param mode        显示的模式: UIDatePickerModeDate、UIDatePickerModeTime、UIDatePickerModeDateAndTime
 *  @param format      显示的格式
 showDate、mode、format三者须保持一致。如
 showDate为2016-12-01，则mode为UIDatePickerModeDate，format为yyyy-MM-dd；
 showDate为12:01:01，则mode为UIDatePickerModeTime，format为HH:mm:ss
 showDate为2016-12-01 12:01:01，则mode为UIDatePickerModeDateAndTime，format为yyyy-MM-dd HH:mm:ss；
 
 *  @param viewControl 视图控制器
 *  @param myBlock     回调block：其中myDate为选择后输出的日期时间
 *  @param cancelBlock 取消block
 */
+ (void)showSelectDatePicker:(NSString *)title
                    showDate:(NSString *)showDate
                        mode:(UIDatePickerMode)mode
                      format:(NSString *)format
                 viewControl:(UIViewController *)viewControl
                selectedDate:(void(^)(NSString *myDate))myBlock
                      cancel:(void(^)())cancelBlock
{
    //初始化日期选择器
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    
    //当前日期
    NSDate *date = [NSDate date];
    date = [self dateFromString:showDate withDateFormat:format];
    //date = [self dateFromString:@"2016-12-01 12:05:02" withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    datePicker.date = date;
    datePicker.datePickerMode = mode;
    
    [datePicker setLocale:[[NSLocale alloc]initWithLocaleIdentifier:@"zh_Hans_CN"]];
    NSString *title_ = [NSString stringWithFormat:@"%@\n\n\n\n\n\n\n\n\n\n\n", title];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title_ message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    //添加日期选择器
    [alert.view addSubview:datePicker];
    
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                         {
                             NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
                             //实例化一个NSDateFormatter对象
                             [dateFormat setDateFormat:format];//设定时间格式
                             NSString *dateString = [dateFormat stringFromDate:datePicker.date];
                             //回调block
                             myBlock(dateString);
                         }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {cancelBlock();}];
    [alert addAction:ok];
    [alert addAction:cancel];
    
    CGRect frame = datePicker.frame;
    frame.origin.y += 30;
    frame.size.width = alert.view.frame.size.width - 20;
    datePicker.frame = frame;
    
    [viewControl presentViewController:alert animated:YES completion:^{}];
}

/**
 *  字符串转日期
 *
 *  @param dateString 日期字符串
 *  @param format     格式如@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 转换后的日期
 */
+ (NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //[dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat: format];
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    return destDate;
}

/**
 *  日期转字符串
 *
 *  @param date 日期
 *  @param format     格式如@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 转换后的字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)format
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss zzz"];
    //[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setDateFormat:format];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}

@end
