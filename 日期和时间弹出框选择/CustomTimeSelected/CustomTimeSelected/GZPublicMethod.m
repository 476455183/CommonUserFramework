//
//  GZPublicMethod.m
//  GZMoFramework
//
//  Created by mojx on 16/7/6.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#import "GZPublicMethod.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "GZPublicConst.h"
#import "MBProgressHUD.h"

@implementation GZPublicMethod


#pragma mark - APP相关

/**
 *  获取APP软件版本
 *
 *  @return 软件版本
 */
+ (NSString *)appVersion
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // app名称
    //NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    // app版本
    NSString *app_version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    // app build版本
    //NSString *app_build = [infoDictionary objectForKey:@"CFBundleVersion"];
    //_versionLabel.text = [NSString stringWithFormat:@"软件版本：v%@(build: %@)",app_Version,app_build];
    //_versionLabel.text = [NSString stringWithFormat:@"软件版本：v%@",app_version];
    return app_version;
}

/**
 检查手机设备类型
 
 @return 手机设备类型
 */
+ (CurrentDeviceType)checkDeviceType
{
    CurrentDeviceType deviceType = Device_iPhone6;
    
    CGRect rect_screen = [[UIScreen mainScreen]bounds];
    CGFloat scale_screen = [UIScreen mainScreen].scale;
    CGSize size_screen = rect_screen.size;
    NSLog(@"width: %f, height: %f. screen resolution: %f x %f",size_screen.width, size_screen.height, scale_screen * size_screen.width, scale_screen * size_screen.height);
    //[UIScreen mainScreen]: <UIScreen: 0x1d582a60; bounds = {{0, 0}, {320, 480}}; mode = <UIScreenMode: 0x1d582b30; size = 640.000000 x 960.000000>>
    NSLog(@"mainScreen: %@",[UIScreen mainScreen]);
    //系统版本号
    NSLog(@"systemVersion: %f",[[[UIDevice currentDevice] systemVersion] floatValue]);
    
    //NSString * deviceModel = [Publicmethods getCurrentDeviceModel];
    //NSLog(@"deviceModel: %@",deviceModel);
    if([ [ UIDevice currentDevice ] userInterfaceIdiom ] == UIUserInterfaceIdiomPhone)
    {
        //IPhone设备
        if((iPhone2g_3g_3gs && (size_screen.width == 320 && size_screen.height == 480)) ||
           (iPhone4s && (size_screen.width == 320 && size_screen.height == 480) && [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0) )
        {
            NSLog(@"iPhone2g_3g_3gs or iPhone4");
            deviceType = Device_iPhone2g3g3gs;
        }
        else if(iPhone4s && (size_screen.width == 320 && size_screen.height == 480))
        {
            NSLog(@"iPhone4s");
            deviceType = Device_iPhone4s;
        }
        else if(iPhone5_5s || (size_screen.width == 320 && size_screen.height == 568))
        {
            NSLog(@"iPhone5_5s");
            deviceType = Device_iPhone5_5s;
        }
        else if(iPhone6 || (size_screen.width == 375 && size_screen.height == 667))
        {
            NSLog(@"iPhone6");
            deviceType = Device_iPhone6;
        }
        else if(iPhone6_Plus || iPhone6_Plus2)
        {
            NSLog(@"iPhone6_Plus");
            deviceType = Device_iPhone6_Plus;
        }
        else
        {
            NSLog(@"iPhone other");
            deviceType = Device_other;
        }
    }
    else
    {
        //ipad设备
    }
    return deviceType;
}

/**
 *  设置导航条背景图片和标题颜色
 *
 *  @param backgroundImage 背景图片
 *  @param titleColor      标题颜色
 */
+ (void)navigationBarInit:(UIImage *)backgroundImage titleColor:(UIColor *)titleColor
{
    //设置所有NavigationBar背景
    [[UINavigationBar appearance]setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    //设置所有NavigationBar颜色
    [[UINavigationBar appearance]setTintColor:titleColor];
    //设置所有NavigationBar标题颜色
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
    
    //设置NavigationBar标题字体大小和颜色
    //[[UINavigationBar appearance]setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:titleColor}];
}

/**
 设置导航条颜色
 
 @param backgroundColor 导航条背景颜色
 @param backColor 导航条返回按钮颜色
 @param titleColor 导航条标题颜色
 */
+ (void)navigationBarInitWithColor:(UIColor *)backgroundColor backColor:(UIColor *)backColor titleColor:(UIColor *)titleColor
{
    //设置所有NavigationBar背景颜色
    [[UINavigationBar appearance]setBarTintColor:backgroundColor];
    //设置所有NavigationBar返回颜色
    [[UINavigationBar appearance]setTintColor:backColor];
    //设置所有NavigationBar标题颜色
    [[UINavigationBar appearance]setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor}];
}

/**
 *  提示对话框
 *
 *  @param message 提示的消息
 *  @param control 弹出对话框的控制器
 */
+ (void)showAlertOK:(NSString *)message control:(UIViewController *)control
{
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){}]];
    //弹出提示框
    [control presentViewController:alert animated:true completion:nil];
}

/**
 提示对话框
 
 @param message 提示的消息
 @param control 弹出对话框的控制器
 @param isPopView 是否返回上一级视图
 @param isPopToRootView 是否返回根视图，最优先级
 */
+ (void)showAlertOK:(NSString *)message
            control:(UIViewController *)control isPopView:(BOOL)isPopView
    isPopToRootView:(BOOL)isPopToRootView
{
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                      {
                          if (isPopView && !isPopToRootView)
                              [control.navigationController popViewControllerAnimated:YES];
                          if (isPopToRootView)
                              [control.navigationController popToRootViewControllerAnimated:YES];
                      }]];
    //弹出提示框
    [control presentViewController:alert animated:true completion:nil];
}


#pragma mark - 日期相关

/**
 *  获取年龄
 *
 *  @param birthday 用户生日日期, 如1990-08-04 16:01:03
 *
 *  @return 用户年龄
 */
+ (NSString *)userAge:(NSString *)birthday
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
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
 *  传入 秒 得到 xx:xx:xx
 *
 *  @param seconds 传入的时间（秒）
 *
 *  @return xx:xx:xx
 */
+ (NSString *)timeHHMMSSFromSS:(long)seconds
{
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld", seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld", (seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld", seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@", str_hour, str_minute, str_second];
    
    return format_time;
}

/**
 *  传入 秒 得到  xx:xx(xx分钟xx秒)
 *
 *  @param seconds 传入的时间（秒）
 *
 *  @return xx:xx:xx
 */
+ (NSString *)timeMMSSFromSS:(long)seconds
{
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    return format_time;
}


#pragma mark - 网络处理

/**
 *  检查网络是否可用
 *
 *  @return YES：网络可用；NO：网络不可用
 */
+ (BOOL)connectedToNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    return (isReachable && !needsConnection) ? YES : NO;
}

/**
 *  从网络上异步下载一张图片
 *
 *  @param url url地址
 *
 *  @return 下载后的图片
 */
+ (UIImage *)netWorkPhoto_asynchronous:(NSString *)url
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    UIImage *image = nil;
    if(data != nil)
    {
        image =[UIImage imageWithData:data];
        //NSLog(@"图片下载完成");
    }
    return image;
}

/**
 *  从网络上同步下载一张图片
 *
 *  @param url url地址
 *
 *  @return 下载后的图片
 */
+ (UIImage *)netWorkPhoto_synchronous:(NSString *)url
{
    NSData* imagedata = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image = [UIImage imageWithData:imagedata];
    return image;
}


#pragma mark - 图像处理

/**
 *  图片缩放
 *
 *  @param image   原图片
 *  @param newsize 新图片大小
 *
 *  @return 缩放后的照片
 */
+ (UIImage *)scaleToSize:(UIImage *)image newsize:(CGSize)newsize
{
    //    // 创建一个bitmap的context
    //    // 并把它设置成为当前正在使用的context
    //    UIGraphicsBeginImageContext(newsize);
    //    // 绘制改变大小的图片
    //    [image drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
    //    // 从当前context中创建一个改变大小后的图片
    //    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    //    // 使当前的context出堆栈
    //    UIGraphicsEndImageContext();
    //    // 返回新的改变大小后的图片
    //    return scaledImage;
    
    UIGraphicsBeginImageContextWithOptions(newsize, NO, 0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, newsize.width, newsize.height);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  图片缩放
 *
 *  @param image 原图片
 *  @param scale 缩放比例，如0.1表示缩放至原图的10%
 *
 *  @return 缩放后的照片
 */
+ (UIImage *)zoomToScale:(UIImage *)image scale:(CGFloat)scale
{
    if (scale <= 0)
        return image;
    CGSize newsize = CGSizeMake(image.size.width * scale, image.size.height * scale);
    UIGraphicsBeginImageContextWithOptions(newsize, NO, 0.0);
    CGRect imageRect = CGRectMake(0.0, 0.0, newsize.width, newsize.height);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  图片拉伸（创建一个内容可拉伸，而边角不拉伸的图片）
 *
 *  @param image        需要拉伸的图片
 *  @param leftCapWidth 左边不拉伸区域的宽度
 *  @param topCapHeight 上面不拉伸的高度
 *
 *  @return 图片拉伸后放置的UIImageView
 */
+ (UIImageView *)imageStretchable:(UIImage *)image leftCapWidth:(NSInteger)leftCapWidth topCapHeight:(NSInteger)topCapHeight
{
    /*
     (NSInteger)topCapHeight 这个函数是UIImage的一个实例函数，它的功能是创建一个内容可拉伸，而边角不拉伸的图片，需要两个参数，第一个是左边不拉伸区域的宽度，第二个参数是上面不拉伸的高度。
     根据设置的宽度和高度，将接下来的一个像素进行左右扩展和上下拉伸。
     注意：可拉伸的范围都是距离leftCapWidth后的1竖排像素，和距离topCapHeight后的1横排像素。
     参数的意义是，如果参数指定10，5。那么，图片左边10个像素，上边5个像素。不会被拉伸，x坐标为11和一个像素会被横向复制，y坐标为6的一个像素会被纵向复制。
     注意：只是对一个像素进行复制到一定宽度。而图像后面的剩余像素也不会被拉伸。
     */
    image = [image stretchableImageWithLeftCapWidth:leftCapWidth topCapHeight:topCapHeight];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    //[view setBackgroundView:imageView];
    return imageView;
}


#pragma mark - 数据验证

/**
 *  检测是否是手机号码
 *
 *  @param mobileNum 手机号码
 *
 *  @return YES/NO
 */
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

/**
 *  判断身份证号是否合法
 *
 *  @param identityCard 身份证号
 *
 *  @return 合法YES，非法NO
 */
+ (BOOL)validateIdentityCard: (NSString *)identityCard
{
    BOOL flag = NO;
    if (identityCard.length <= 0)
        return flag;
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    flag = [identityCardPredicate evaluateWithObject:identityCard];
    return flag;
}


#pragma mark - 数据转换

/**
 *  字典转json字符串
 *
 *  @param dict 字典
 *
 *  @return 转换后的结果
 */
+ (NSString *)jsonStringWithDictionary:(NSMutableDictionary *)dict
{
    if (dict && 0 != dict.count)
    {
        NSError *error = nil;
        // NSJSONWritingOptions 是"NSJSONWritingPrettyPrinted"的话有换位符\n；是"0"的话没有换位符\n。
        //NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return jsonString;
    }
    
    return nil;
}

/**
 *  json字符串转字典
 *
 *  @param jsonString json字符串
 *
 *  @return 转换后的结果
 */
+ (NSMutableDictionary *)jsonDictionaryWithString:(NSString *)jsonString
{
    if (jsonString && 0 != jsonString.length)
    {
        NSError *error;
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
        
        if (error)
        {
            NSLog(@"json解析失败：%@", error);
            return nil;
        }
        
        return jsonDict;
    }
    
    return nil;
}


#pragma mark - 文件处理

/**
 *  创建目录（文件夹）至沙盒
 *
 *  @param dirName 目录名称
 *
 *  @return 创建成功返回YES, 否则NO
 */
+ (BOOL)createDir:(NSString*)dirName
{
    NSString *dirPath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), dirName];
    //NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSString *documentDirectory = [path objectAtIndex:0];
    //NSString *dirPath = [NSString stringWithFormat:@"%@/%@", documentDirectory, dirName];
    BOOL isDir = NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL existed = [fileManager fileExistsAtPath:dirPath isDirectory:&isDir];
    //先判断这个文件夹是否存在，如果不存在则创建，否则不创建
    if ( !(isDir == YES && existed == YES) )
    {
        return [fileManager createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return NO;
}

/**
 *  获取沙盒目录下的所有文件
 *
 *  @param dirName 目录名称
 *
 *  @return 指定目录下的所有文件
 */
+ (NSArray *)dirAllFileNames:(NSString *)dirName
{
    // 获得此程序的沙盒路径
    NSArray *patchs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 获取Documents路径
    NSString *documentsDirectory = [patchs objectAtIndex:0];
    //NSString *fileDirectory = [documentsDirectory stringByAppendingString:dirName];
    NSString *fileDirectory = [documentsDirectory stringByAppendingPathComponent:dirName];
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:fileDirectory error:nil];
    return files;
}

/**
 *  删除沙盒中的目录（文件夹）及其下的所有子文件
 *
 *  @param dirName 目录名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)deleteDir:(NSString*)dirName
{
    NSString *dirPath = [NSString stringWithFormat:@"%@/Documents/%@", NSHomeDirectory(), dirName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:dirPath error:nil];
}

/**
 *  删除沙盒中的文件
 *
 *  @param filePath 文件路径
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)deleteFile:(NSString*)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager removeItemAtPath:filePath error:nil];
}

/**
 *  删除沙盒中的文件
 *
 *  @param fileName 文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)deleteFileWithFileName:(NSString *)fileName
{
    //沙盒路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    //文件路径
    NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    NSFileManager *fileManager = [[NSFileManager  alloc]init];
    
    if([fileManager fileExistsAtPath:filePath])//存在则删除
    {
        return [fileManager removeItemAtPath:filePath error:nil];
    }
    return NO;
}

/**
 *  保存照片至沙盒中指定的目录
 *
 *  @param dirName   目录名称
 *  @param saveImage 保存的Image
 *  @param fileName  保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveImageToDir:(NSString*)dirName saveImage:(UIImage *)saveImage fileName:(NSString *)fileName
{
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@/%@", NSHomeDirectory(), dirName, fileName];
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    if(![fileManager fileExistsAtPath:filePath])//不存在则创建
    {
        NSData *imageData = UIImagePNGRepresentation(saveImage);
        return [imageData writeToFile:filePath atomically:YES];
    }
    return NO;
}

/**
 *  保存网络照片至沙盒中指定的目录
 *
 *  @param dirName  目录名称
 *  @param imageUrl 保存的Image url
 *  @param fileName 保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveImageToDirWithImageUrl:(NSString*)dirName imageUrl:(NSString *)imageUrl fileName:(NSString *)fileName
{
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@/%@", NSHomeDirectory(), dirName, fileName];
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    if(![fileManager fileExistsAtPath:filePath])//不存在则创建
    {
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        return [imageData writeToFile:filePath atomically:YES];
    }
    return NO;
}

/**
 *  保存文本文件至沙盒中指定的目录
 *
 *  @param dirName        目录名称
 *  @param txtFileContent 保存的文本文件内容
 *  @param fileName       保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveTxtFileToDir:(NSString*)dirName txtFileContent:(NSString *)txtFileContent fileName:(NSString *)fileName
{
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@/%@", NSHomeDirectory(), dirName, fileName];
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    if(![fileManager fileExistsAtPath:filePath])//不存在则创建
    {
        NSData *fileData = [txtFileContent dataUsingEncoding:NSUTF8StringEncoding];
        return [fileManager createFileAtPath:filePath contents:fileData attributes:nil];
    }
    return NO;
}

/**
 *  保存任意文件至沙盒指定的目录
 *
 *  @param dirName     目录名称
 *  @param anyFileData 保存的文件内容
 *  @param fileName    保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveAnyFileToDir:(NSString*)dirName anyFileData:(NSData *)anyFileData fileName:(NSString *)fileName
{
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@/%@", NSHomeDirectory(), dirName, fileName];
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    if(![fileManager fileExistsAtPath:filePath])//不存在则创建
    {
        return [fileManager createFileAtPath:filePath contents:anyFileData attributes:nil];
    }
    return NO;
}

/**
 *  读取文件内容
 *
 *  @param filePath 文件路径
 *
 *  @return 文件内容
 */
+ (NSData *)readFileDataFromFilePath:(NSString*)filePath
{
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    if([fileManager fileExistsAtPath:filePath])//存在则读取
    {
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        return fileData;
    }
    return nil;
}

/**
 *  读取文件内容
 *
 *  @param dirName  目录名称
 *  @param fileName 文件名称
 *
 *  @return 文件内容
 */
+ (NSData *)readFileDataFromDir:(NSString*)dirName fileName:(NSString *)fileName
{
    NSString *filePath = [NSString stringWithFormat:@"%@/Documents/%@/%@", NSHomeDirectory(), dirName, fileName];
    NSFileManager *fileManager = [[NSFileManager alloc]init];
    
    if([fileManager fileExistsAtPath:filePath])//存在则读取
    {
        //iOS的四种方法读取文件内容:
        
        //第一种方法： NSData类方法读取数据
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        //NSLog(@"NSData类方法读取的内容是：%@",[[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding]);
        
        /*
         //第二种方法： NSFileManager实例方法读取数据
         NSFileManager* fm = [NSFileManager defaultManager];
         NSData *fileData = [fm contentsAtPath:filePath];
         NSLog(@"%@",[[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding]);
         
         //第三种方法： NSString类方法读取内容
         NSString* content = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
         NSLog(@"NSString类方法读取的内容是：\n%@",content);
         
         //第四种方法： NSFileHandle实例方法读取内容
         NSFileHandle* fh = [NSFileHandle fileHandleForReadingAtPath:filePath];
         NSData *fileData = [fh readDataToEndOfFile];
         NSLog(@"NSFileHandle实例读取的内容是：\n%@", [[NSString alloc] initWithData:fileData encoding:NSUTF8StringEncoding]);
         */
        
        return fileData;
    }
    return nil;
}

/**
 *  保存照片至沙盒
 *
 *  @param image    保存的照片
 *  @param fileName 保存的文件名称
 *
 *  @return 成功返回YES, 否则NO
 */
+ (BOOL)saveImage:(UIImage *)image fileName:(NSString *)fileName
{
    NSData *imageData = UIImagePNGRepresentation(image);
    
    //JEPG格式
    //imageData = UIImageJPEGRepresentation(image, 1.0);
    //png格式
    //imageData = UIImagePNGRepresentation(image);
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:fileName];
    //savedImagePath:/Users/tecsun/Library/Developer/CoreSimulator/Devices/7DD804C6-4957-4377-8297-EFAD1735CF89/data/Containers/Data/Application/1FF38424-650D-4318-AC73-CB920DF5B4B9/Documents/ContractPhoto.png
    BOOL ret = [imageData writeToFile:savedImagePath atomically:YES];
    
    return ret;
}

/**
 *  从沙盒中读取照片
 *
 *  @param fileName 文件名称
 *
 *  @return 读取到的照片
 */
+ (UIImage *)imageWithFileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@",documentsDirectory, fileName];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //    NSString *myDirectory = [documentsDirectory stringByAppendingPathComponent:@"test"];
    //    BOOL ok = [fileManager createDirectoryAtPath:myDirectory attributes:nil];
    //    //取得一个目录下得所有文件名：（如上面的myDirectory)可用
    //    NSArray *file = [fileManager subpathsOfDirectoryAtPath: myDirectory error:nil];
    //    //或
    //    NSArray *files = [fileManager subpathsAtPath: myDirectory];
    
    //读取某个文件:
    NSData *data = [fileManager contentsAtPath:filePath];//filePath是包含完整路径的文件名
    UIImage *image = [UIImage imageWithData:data];
    
    return image;
}

/**
 *  检查文件是否存在于沙盒中
 *
 *  @param fileName 文件名
 *
 *  @return 存在YES，否则NO
 */
+ (BOOL)checkFileIsExists:(NSString *)fileName
{
    //获得沙盒目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    //指定文件的路径
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:fileName];
    
    //检查文件是否存在
    return [[NSFileManager defaultManager] fileExistsAtPath:filePath];
}

/**
 *  计算单个文件大小
 *
 *  @param path 文件路径
 *
 *  @return 文件大小，字节
 */
+ (float)fileSizeAtPath:(NSString *)path
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path])
    {
//        //取得一个目录下得所有文件名
//        NSArray *files = [fileManager subpathsAtPath:path];
//        NSLog(@"files1111111%@ == %ld",files,files.count);
//
//        // 从路径中获得完整的文件名（带后缀）
//        NSString *exe = [path lastPathComponent];
//        NSLog(@"exeexe ====%@",exe);
//
//        // 获得文件名（不带后缀）
//        exe = [exe stringByDeletingPathExtension];
//
//        // 获得文件名（不带后缀）
//        NSString *exestr = [[files objectAtIndex:1] stringByDeletingPathExtension];
//        NSLog(@"files2222222%@  ==== %@",[files objectAtIndex:1],exestr);
        
        return [[fileManager attributesOfItemAtPath:path error:nil] fileSize];
    }
    return 0;
}

/**
 *  计算文件夹大小
 *
 *  @param path 文件夹路径
 *
 *  @return 文件夹大小M
 */
+ (float)folderSizeAtPath:(NSString *)path
{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[self fileSizeAtPath:absolutePath];
        }
        //NSLog(@"folderSize ==== %f",folderSize);
        return folderSize/1024.0/1024.0;
    }
    return 0;
}


#pragma mark - 缓存处理

/**
 *  获取缓存大小
 *
 *  @return 缓存大小
 */
+ (float)cachesSize
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    float cachesSize = [self folderSizeAtPath:cachesPath];
    return cachesSize;
}

/**
 *  清理缓存文件
 */
+ (void)clearCaches
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachesPath])
    {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachesPath];
        for (NSString *fileName in childerFiles)
        {
            NSString *absolutePath = [cachesPath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}


#pragma mark - 消息通知

/**
 *  推送处理[注册本地消息通知]
 *
 *  @param application 推送的应用
 */
+ (void)registerLocalNotification:(UIApplication*)application
{
    //显示本地所有消息
    //NSArray *localNotifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    //NSLog(@"%@", localNotifications);
    
    //移除本地所有消息
    [self removeLocalNotification];
    
    application.applicationIconBadgeNumber = 0;//清除应用图标上的数字
    
    NSUserDefaults * userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL isTheFirstSetup = [[userDefaults stringForKey:@"isTheFirstSetup"]boolValue];
    if (isTheFirstSetup == NO)
    {
        [userDefaults setObject:@YES forKey:@"isTheFirstSetup"];
        
        //移除本地所有消息
        //[self removeLocalNotification];
        
        //注册本地消息通知. 关键：加上版本的控制
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
        // The following line must only run under iOS 8. This runtime check prevents
        // it from running if it doesn't exist (such as running under iOS 7 or earlier).
        UIUserNotificationType types = UIUserNotificationTypeBadge| UIUserNotificationTypeSound |UIUserNotificationTypeAlert;
        UIUserNotificationSettings *mySettings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
        {
            [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
        }
#endif
    }
}

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
+ (void)addLocalNotification:(NSString *)alertBody alertAction:(NSString *)alertAction timeInterval:(NSTimeInterval)timeInterval isSound:(BOOL)isSound soundID:(SystemSoundID)soundID isVibration:(BOOL)isVibration
{
    /*
     本地通知对象的属性：
     * 触发时间（fireDate，timeZone，repeatInterval，repeatCalendar），如果你想根据时间来触发。
     * 通知行为（alertAction,hasAction），定义查看通知的操作名。
     * 触发通知时的启动画面（alertLaunchImage）
     * 通知的正文内容（alertBody），
     * 通知的背景声（soundName）
     * 通知消息数的展示（applicationIconBadgeNumber），就是强迫症们最讨厌的App图标上左上角的那个小数字
     * 其它（userInfo），可以给通知绑定一些处理通知时需要的额外信息。
     */
    
    // 初始化本地通知对象
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    if (notification)
    {
        // 设置通知的提醒时间
        //NSDate *currentDate   = [NSDate date];
        notification.timeZone = [NSTimeZone defaultTimeZone]; //使用本地时区
        //notification.fireDate = [currentDate dateByAddingTimeInterval:1.0];
        notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:timeInterval];//通知触发的时间，timeInterval秒以后
        
        // 设置重复间隔
        notification.repeatInterval = kCFCalendarUnitDay;
        
        // 设置提醒的文字内容
        notification.alertBody = alertBody;
        notification.alertAction = alertAction; //待机界面的滑动动作提示
        // 通知提示音 使用默认的
        //notification.soundName= UILocalNotificationDefaultSoundName;
        //notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
        //notification.soundName = [[NSBundle mainBundle] pathForResource:@"message" ofType:@"caf"];
        notification.alertLaunchImage = @"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
        
        // 设置应用程序图标右上角显示的消息数字
        //notification.applicationIconBadgeNumber++;
        
        // 设定通知的userInfo，用来标识该通知
        //NSMutableDictionary *aUserInfo = [[NSMutableDictionary alloc] init];
        //notification.userInfo = aUserInfo;
        //notification.userInfo=@{@"id":@1,@"user":@"me"};//绑定到通知上的其他附加信息
        
        // 将通知添加到系统中(根据触发时间的配置展示通知消息)
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
        
        if (isSound)//是否声音提醒
        {
            //播放系统声音
            AudioServicesPlaySystemSound(1007);
            //AudioServicesPlaySystemSound(soundID);
        }
        if (isVibration)//是否震动提醒
        {
            //震动提醒
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        }
        
        //设置应用程序图标右上角显示的消息数字
        [UIApplication sharedApplication].applicationIconBadgeNumber++;
    }
}

/**
 *  创建系统声音ID
 *
 *  @param resourceFileName 资源文件名称
 *  @param fileType         文件类型
 *
 *  @return 声音ID
 */
+ (SystemSoundID)createSystemSoundID:(NSString *)resourceFileName fileType:(NSString *)fileType
{
    SystemSoundID soundID;//通知声音ID
    //NSString *soundPath = [[NSBundle mainBundle]pathForResource:@"iphone" ofType:@"mp3"];
    NSString *soundPath = [[NSBundle mainBundle]pathForResource:resourceFileName ofType:fileType];
    if(soundPath)
    {
        NSURL *soundURL =[NSURL fileURLWithPath:soundPath];
        OSStatus err = AudioServicesCreateSystemSoundID((__bridge CFURLRef)soundURL, &soundID);
        if(err != kAudioServicesNoError)
        {
            NSLog(@"Could not load %@,error code: %i",soundURL, (int)err);
        }
        //播放声音
        //AudioServicesPlaySystemSound((SystemSoundID)notificationSoundID);
    }
    return soundID;
}

/**
 *  移除本地通知，在不需要此通知时记得移除
 */
+ (void)removeLocalNotification
{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}


#pragma mark - 其他

/**
 *  一个随机整数，范围在[from,to），包括from，包括to
 *
 *  @param from 范围from
 *  @param to   范围to
 *
 *  @return 随机整数
 */
+ (int)randomNumber:(int)from to:(int)to
{
    return (int)(from + (arc4random() % (to - from + 1)));
}

/**
 生成随机的颜色
 
 @return 随机的颜色
 */
+ (UIColor *)randomColor
{
    CGFloat r = arc4random_uniform(256)/255.0;
    CGFloat g = arc4random_uniform(256)/255.0;
    CGFloat b = arc4random_uniform(256)/255.0;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

/**
 设置按钮属性化标题生成随机的颜色
 
 @param button 需要设置的按钮
 @param title 设置的标题文字
 */
+ (void)randomColorWithButton:(UIButton *)button title:(NSString *)title
{
    if (!button || !title || [title isEqualToString:@""])
        return;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:title];
    //设置随机文字颜色
    for (int i = 0; i < title.length; i++)
    {
        //添加属性，用以设置生成随机颜色范围
        [attributedString addAttribute:NSForegroundColorAttributeName value:[self randomColor] range:NSMakeRange(i, 1)];
    }
    [button setAttributedTitle:attributedString forState:UIControlStateNormal];
}

/**
 生成随机字符串（随机字符串为随机的数字、字母（包括大小与小写））
 
 @param number 生成随机字符串个数
 @return 随机字符串
 */
+ (NSString *)randomString:(NSInteger)number
{
    NSMutableArray *randomArray = [NSMutableArray arrayWithArray:@[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",@"a",@"b",@"c",@"d",@"e",@"f",@"g",@"h",@"i",@"j",@"k",@"l",@"m",@"n",@"o",@"p",@"q",@"r",@"s",@"t",@"u",@"v",@"w",@"x",@"y",@"z"]];
    NSString *temp = @"";
    for (int i = 0; i < number; i++)
    {
        int randomNum = arc4random()%randomArray.count;
        temp = [temp stringByAppendingString:randomArray[randomNum]];
    }
    return temp;
}

/*  计算文本的大小
 @param str   需要计算的文本
 @param font  文本显示的字体
 @param maxSize 文本显示的范围，可以理解为limit
 
 @return 文本占用的真实大小
 */
+ (CGSize)sizeWithString:(NSString *)str font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attributesDic = @{NSFontAttributeName : font};
    // 如果将来计算的文字的范围超出了指定的范围,返回的就是指定的范围
    // 如果将来计算的文字的范围小于指定的范围, 返回的就是真实的范围
    CGSize size = [str boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDic context:nil].size;
    return size;
}

/**
 获取屏蔽*号后的身份证号
 
 @param number 身份证号
 @param begin 开始设置屏蔽*的索引
 @param length 设置的长度
 @return 屏蔽后的身份证号，如440223********2231
 */
+ (NSString *)certifyNumber:(NSString *)number begin:(NSInteger)begin length:(NSInteger)length
{
    NSString *temp = number;
    
    if (begin > 0 && length <= number.length)
    {
        temp = [NSString stringWithFormat:@"%@", [number substringWithRange:NSMakeRange(0, begin - 1)]];
        for (int i=0; i<length; i++)
        {
            temp = [temp stringByAppendingString:@"*"];
        }
        NSString *end = [NSString stringWithFormat:@"%@", [number substringWithRange:NSMakeRange(begin - 1 + length, number.length - begin - length + 1)]];
        temp = [temp stringByAppendingString:end];
    }
    
    return temp;
}

/**
 显示提示消息
 
 @param title 标题
 @param delay 延时
 @param showView 显示的视图
 */
+ (void)toastMessage:(NSString *)title delay:(CGFloat)delay showView:(UIView *)showView
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:showView animated:YES];
    
    // Set the annular determinate mode to show task progress.
    hud.mode = MBProgressHUDModeText;
    hud.label.text = title;
    hud.label.font = [UIFont systemFontOfSize:12];
    // Move to bottm center.
    hud.offset = CGPointMake(0.f, MBProgressMaxOffset);
    
    [hud hideAnimated:YES afterDelay:delay];
}

/**
 添加提示
 
 @param view 显示的视图
 @param tip 提示
 @param image 图片
 */
+ (void)addTip:(UIView *)view tip:(NSString *)tip image:(UIImage *)image
{
    if (image)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(view.center.x-103/2, (kScreenHeight-21)/2-70, 103, 70)];
        imageView.image = image;
        [view addSubview:imageView];
    }
    
    UILabel *nodataLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, (kScreenHeight-50)/2+10, kScreenWidth-40, 50)];
    nodataLabel.textColor = [UIColor grayColor];
    nodataLabel.textAlignment = NSTextAlignmentCenter;
    nodataLabel.font = [UIFont systemFontOfSize:13];
    nodataLabel.numberOfLines = 0;
    nodataLabel.text = tip;
    [view addSubview:nodataLabel];
}

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
                                         tag:(NSInteger)tag
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    UIViewController *storyboardVC = [storyboard instantiateViewControllerWithIdentifier:identifier];
    storyboardVC.view.tag = tag;
    storyboardVC.navigationItem.hidesBackButton = YES;
    //UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:storyboardVC];
    //[viewController presentViewController:nav animated:YES completion:^(void){}];
    //[viewController presentViewController:storyboardVC animated:YES completion:^(void){}];
    //[viewController.navigationController presentViewController:storyboardVC animated:YES completion:nil];
    [viewController.navigationController pushViewController:storyboardVC animated:YES];
}

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
                         tag:(NSInteger)tag
{
    //初始化提示框
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle: UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击按钮的响应事件
        //NSLog(@"ok");
        [self gotoViewControllerWithStoryboardName:storyboardName identifier:identifier viewController:viewController tag:tag];
    }]];
    //    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    //        //点击按钮的响应事件
    //        NSLog(@"cancel");
    //    }]];
    //弹出提示框；
    [viewController presentViewController:alert animated:true completion:nil];
}

@end
