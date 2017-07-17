//
//  GZPublicMethod.h
//  GZMoFramework
//
//  Created by mojx on 16/7/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "GZPublicEnum.h"

@interface GZPublicMethod : NSObject


#pragma mark - APP相关

/**
 *  获取APP软件版本
 *
 *  @return 软件版本
 */
+ (NSString *)appVersion;

/**
 检查手机设备类型
 
 @return 手机设备类型
 */
//+ (CurrentDeviceType)checkDeviceType;

/**
 *  设置导航条背景图片和标题颜色
 *
 *  @param backgroundImage 背景图片
 *  @param titleColor      标题颜色
 */
+ (void)navigationBarInit:(UIImage *)backgroundImage titleColor:(UIColor *)titleColor;

/**
 设置导航条颜色
 
 @param backgroundColor 导航条背景颜色
 @param backColor 导航条返回按钮颜色
 @param titleColor 导航条标题颜色
 */
+ (void)navigationBarInitWithColor:(UIColor *)backgroundColor backColor:(UIColor *)backColor titleColor:(UIColor *)titleColor;

/**
 *  提示对话框
 *
 *  @param message 提示的消息
 *  @param control 弹出对话框的控制器
 */
+ (void)showAlertOK:(NSString *)message control:(UIViewController *)control;

/**
 提示对话框
 
 @param message 提示的消息
 @param control 弹出对话框的控制器
 @param isPopView 是否返回上一级视图
 @param isPopToRootView 是否返回根视图，最优先级
 */
+ (void)showAlertOK:(NSString *)message
            control:(UIViewController *)control isPopView:(BOOL)isPopView
    isPopToRootView:(BOOL)isPopToRootView;


#pragma mark - 日期相关

/**
 *  获取年龄
 *
 *  @param birthday 用户生日日期, 如1990-08-04 16:01:03
 *
 *  @return 用户年龄
 */
+ (NSString *)userAge:(NSString *)birthday;

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
 *  传入 秒 得到 xx:xx:xx
 *
 *  @param seconds 传入的时间（秒）
 *
 *  @return xx:xx:xx
 */
+ (NSString *)timeHHMMSSFromSS:(long)seconds;

/**
 *  传入 秒 得到  xx:xx(xx分钟xx秒)
 *
 *  @param seconds 传入的时间（秒）
 *
 *  @return xx:xx:xx
 */
+ (NSString *)timeMMSSFromSS:(long)seconds;


#pragma mark - 网络处理

/**
 *  检查网络是否可用
 *
 *  @return YES：网络可用；NO：网络不可用
 */
+ (BOOL)connectedToNetwork;

/**
 *  从网络上异步下载一张图片
 *
 *  @param url url地址
 *
 *  @return 下载后的图片
 */
+ (UIImage *)netWorkPhoto_asynchronous:(NSString *)url;

/**
 *  从网络上同步下载一张图片
 *
 *  @param url url地址
 *
 *  @return 下载后的图片
 */
+ (UIImage *)netWorkPhoto_synchronous:(NSString *)url;


#pragma mark - 图像处理

/**
 *  图片缩放
 *
 *  @param image   原图片
 *  @param newsize 新图片大小
 *
 *  @return 缩放后的照片
 */
+ (UIImage *)scaleToSize:(UIImage *)image newsize:(CGSize)newsize;

/**
 *  图片缩放
 *
 *  @param image 原图片
 *  @param scale 缩放比例，如0.1表示缩放至原图的10%
 *
 *  @return 缩放后的照片
 */
+ (UIImage *)zoomToScale:(UIImage *)image scale:(CGFloat)scale;

/**
 *  图片拉伸（创建一个内容可拉伸，而边角不拉伸的图片）
 *
 *  @param image        需要拉伸的图片
 *  @param leftCapWidth 左边不拉伸区域的宽度
 *  @param topCapHeight 上面不拉伸的高度
 *
 *  @return 图片拉伸后放置的UIImageView
 */
+ (UIImageView *)imageStretchable:(UIImage *)image leftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight;


#pragma mark - 数据验证

/**
 *  检测是否是手机号码
 *
 *  @param mobileNum 手机号码
 *
 *  @return YES/NO
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

/**
 *  判断身份证号是否合法
 *
 *  @param identityCard 身份证号
 *
 *  @return 合法YES，非法NO
 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard;


#pragma mark - 数据转换

/**
 *  字典转json字符串
 *
 *  @param dict 字典
 *
 *  @return 转换后的结果
 */
+ (NSString *)jsonStringWithDictionary:(NSMutableDictionary *)dict;

/**
 *  json字符串转字典
 *
 *  @param jsonString json字符串
 *
 *  @return 转换后的结果
 */
+ (NSMutableDictionary *)jsonDictionaryWithString:(NSString *)jsonString;


#pragma mark - 文件处理

/**
 *  创建目录（文件夹）至沙盒
 *
 *  @param dirName 目录名称
 *
 *  @return 创建成功返回YES, 否则NO
 */
+ (BOOL)createDir:(NSString*)dirName;

/**
 *  获取沙盒目录下的所有文件
 *
 *  @param dirName 目录名称
 *
 *  @return 指定目录下的所有文件
 */
+ (NSArray *)dirAllFileNames:(NSString *)dirName;

/**
 *  删除沙盒中的目录（文件夹）及其下的所有子文件
 *
 *  @param dirName 目录名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)deleteDir:(NSString*)dirName;

/**
 *  删除沙盒中的文件
 *
 *  @param filePath 文件路径
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)deleteFile:(NSString*)filePath;

/**
 *  删除沙盒中的文件
 *
 *  @param fileName 文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)deleteFileWithFileName:(NSString *)fileName;

/**
 *  保存照片至沙盒中指定的目录
 *
 *  @param dirName   目录名称
 *  @param saveImage 保存的Image
 *  @param fileName  保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveImageToDir:(NSString*)dirName saveImage:(UIImage *)saveImage fileName:(NSString *)fileName;

/**
 *  保存网络照片至沙盒中指定的目录
 *
 *  @param dirName  目录名称
 *  @param imageUrl 保存的Image url
 *  @param fileName 保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveImageToDirWithImageUrl:(NSString*)dirName imageUrl:(NSString *)imageUrl fileName:(NSString *)fileName;

/**
 *  保存文本文件至沙盒中指定的目录
 *
 *  @param dirName        目录名称
 *  @param txtFileContent 保存的文本文件内容
 *  @param fileName       保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveTxtFileToDir:(NSString*)dirName txtFileContent:(NSString *)txtFileContent fileName:(NSString *)fileName;

/**
 *  保存任意文件至沙盒指定的目录
 *
 *  @param dirName     目录名称
 *  @param anyFileData 保存的文件内容
 *  @param fileName    保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveAnyFileToDir:(NSString*)dirName anyFileData:(NSData *)anyFileData fileName:(NSString *)fileName;

/**
 *  读取文件内容
 *
 *  @param filePath 文件路径
 *
 *  @return 文件内容
 */
+ (NSData *)readFileDataFromFilePath:(NSString*)filePath;

/**
 *  读取文件内容
 *
 *  @param dirName  目录名称
 *  @param fileName 文件名称
 *
 *  @return 文件内容
 */
+ (NSData *)readFileDataFromDir:(NSString*)dirName fileName:(NSString *)fileName;

/**
 *  保存照片至沙盒
 *
 *  @param image    保存的照片
 *  @param fileName 保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveImage:(UIImage *)image fileName:(NSString *)fileName;

/**
 *  从沙盒中读取照片
 *
 *  @param fileName 文件名称
 *
 *  @return 读取到的照片
 */
+ (UIImage *)imageWithFileName:(NSString *)fileName;

/**
 *  检查文件是否存在于沙盒中
 *
 *  @param fileName 文件名
 *
 *  @return 存在YES，否则NO
 */
+ (BOOL)checkFileIsExists:(NSString *)fileName;

/**
 *  计算单个文件大小
 *
 *  @param path 文件路径
 *
 *  @return 文件大小M
 */
+ (float)fileSizeAtPath:(NSString *)path;

/**
 *  计算文件夹大小
 *
 *  @param path 文件夹路径
 *
 *  @return 文件夹大小M
 */
+ (float)folderSizeAtPath:(NSString *)path;


#pragma mark - 缓存处理

/**
 *  获取缓存大小
 *
 *  @return 缓存大小
 */
+ (float)cachesSize;

/**
 *  清理缓存文件
 */
+ (void)clearCaches;


#pragma mark - 消息通知

/**
 *  推送处理[注册本地消息通知]
 *
 *  @param application 推送的应用
 */
+ (void)registerLocalNotification:(UIApplication*)application;

/**
 *  添加本地通知
 *
 *  @param alertBody    通知的正文内容
 *  @param alertAction  通知行为
 *  @param timeInterval 触发时间
 *  @param isSound      是否声音提醒
 *  @param soundID      声音ID
 *  @param isVibration  是否震动提醒
 */
+ (void)addLocalNotification:(NSString *)alertBody alertAction:(NSString *)alertAction timeInterval:(NSTimeInterval)timeInterval isSound:(BOOL)isSound soundID:(SystemSoundID)soundID isVibration:(BOOL)isVibration;

/**
 *  创建系统声音ID
 *
 *  @param resourceFileName 资源文件名称
 *  @param fileType         文件类型
 *
 *  @return 声音ID
 */
+ (SystemSoundID)createSystemSoundID:(NSString *)resourceFileName fileType:(NSString *)fileType;

/**
 *  移除本地通知，在不需要此通知时记得移除
 */
+ (void)removeLocalNotification;


#pragma mark - 其他

/**
 *  一个随机整数，范围在[from,to），包括from，包括to
 *
 *  @param from 范围from
 *  @param to   范围to
 *
 *  @return 随机整数
 */
+ (int)randomNumber:(int)from to:(int)to;

/**
 生成随机的颜色
 
 @return 随机的颜色
 */
+ (UIColor *)randomColor;

/**
 设置按钮属性化标题生成随机的颜色
 
 @param button 需要设置的按钮
 @param title 设置的标题文字
 */
+ (void)randomColorWithButton:(UIButton *)button title:(NSString *)title;

/**
 生成随机字符串（随机字符串为随机的数字、字母（包括大小与小写））
 
 @param number 生成随机字符串个数
 @return 随机字符串
 */
+ (NSString *)randomString:(NSInteger)number;

/*  计算文本的大小
 @param str   需要计算的文本
 @param font  文本显示的字体
 @param maxSize 文本显示的范围，可以理解为limit
 
 @return 文本占用的真实大小
 */
+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize;

/**
 获取屏蔽*号后的身份证号
 
 @param number 身份证号
 @param begin 开始设置屏蔽*的索引
 @param length 设置的长度
 @return 屏蔽后的身份证号，如440223********2231
 */
+ (NSString *)certifyNumber:(NSString *)number begin:(NSInteger)begin length:(NSInteger)length;

/**
 显示提示消息
 
 @param title 标题
 @param delay 延时
 @param showView 显示的视图
 */
+ (void)toastMessage:(NSString *)title delay:(CGFloat)delay showView:(UIView *)showView;

/**
 添加提示
 
 @param view 显示的视图
 @param tip 提示
 @param image 图片
 */
+ (void)addTip:(UIView *)view tip:(NSString *)tip image:(UIImage *)image;

/**
 *  跳转至故事板任意ViewController
 *
 *  @param storyboardName 故事板名称
 *  @param identifier     跳转至故事板中的ViewController的标识符
 *  @param viewController 触发的ViewController
 *  @param tag 标志
 */
+ (void)gotoViewControllerWithStoryboardName:(NSString *)storyboardName
                                  identifier:(NSString *)identifier
                              viewController:(UIViewController *)viewController
                                         tag:(NSInteger)tag;

/**
 *  重新登录提示框
 *
 *  @param message        消息
 *  @param viewController 触发的ViewController
 *  @param storyboardName 故事板名称
 *  @param identifier     跳转至故事板中的ViewController的标识符
 *  @param tag 标志
 */
+ (void)showReLoginAlertView:(NSString *)message
              viewController:(UIViewController *)viewController
              storyboardName:(NSString *)storyboardName
                  identifier:(NSString *)identifier
                         tag:(NSInteger)tag;

@end
