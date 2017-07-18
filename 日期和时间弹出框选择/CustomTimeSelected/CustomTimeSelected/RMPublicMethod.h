//
//  RMPublicMethod.h
//  CustomTimeSelected
//
//  Created by Mr_zhang on 2017/7/18.
//  Copyright © 2017年 Mr_zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface RMPublicMethod : NSObject
/**
 *  获取年龄
 *
 *  @param birthday 用户生日日期, 如1990-08-04 16:01:03
 *
 *  @return 用户年龄
 */
+ (NSString *)userAge:(NSString *)birthday;

/**
 *  获取当前日期和时间
 *
 *  @param format 格式如@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 当前日期和时间
 */
+ (NSString *)todayDate:(NSString *)format;

/**
 *  获取自定义格式的日期
 *
 *  @param nsDate 字符串日期：@"2015-08-21 12:00:00"
 *  @param format 日期格式化：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 返回格式如："05-02 星期二 上午"
 */
+ (NSString *)customDate:(NSString *)nsDate withDateFormat:(NSString *)format;

/**
 *  获取自定义格式的日期
 *
 *  @param nsDate 字符串日期：@"2015-08-21 12:00:00"
 *  @param format 日期格式化：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 返回格式如："05-02 星期二 上午09:00"
 */
+ (NSString *)customDate2:(NSString *)nsDate withDateFormat:(NSString *)format;

/**
 *  根据日期获取当前星期
 *
 *  @param nsDate 字符串日期：@"2015-08-21 12:00:00"
 *  @param format 日期格式化：@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 星期
 */
+ (NSString*)weekdayStringFromDate:(NSString *)nsDate withDateFormat:(NSString *)format;

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
                      cancel:(void(^)())cancelBlock;

/**
 *  字符串转日期
 *
 *  @param dateString 日期字符串
 *  @param format     格式如@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 转换后的日期
 */
+ (NSDate *)dateFromString:(NSString *)dateString withDateFormat:(NSString *)format;


/**
 *  日期转字符串
 *
 *  @param date 日期
 *  @param format     格式如@"yyyy-MM-dd HH:mm:ss"
 *
 *  @return 转换后的字符串
 */
+ (NSString *)stringFromDate:(NSDate *)date withDateFormat:(NSString *)format;

@end
