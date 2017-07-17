//
//  GZPublicConst.h
//  GZMoFramework
//
//  Created by mojx on 16/9/1.
//  Copyright © 2016年 mojiaxun. All rights reserved.
//

#ifndef GZPublicConst_h
#define GZPublicConst_h

//iphone4s_3.5inch:640x960; iphone5/5s_4inch:640x1136; iphone6_4.7inch:750x1334; iphone6 plus_5.5inch:1242x2208
#define iPhone2g_3g_3gs ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5_5s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6_Plus2 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1920, 1080), [[UIScreen mainScreen] currentMode].size) : NO)

//iPhone6：4.7英寸(1334×750)
//iPhone6 Plus：5.5英寸(1920×1080)


/** rgb颜色转换（16进制->10进制），如UIColorFromRGB(0x17BDDF)*/
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define kTableViewBackgroundColor 0xe8e8e8   //浅灰色

/** 屏幕宽度*/
#define kScreenWidth  [[UIScreen mainScreen] bounds].size.width
/** 屏幕高度*/
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

//扫一扫
#define SCANVIEW_EdgeTop 30.0
#define SCANVIEW_EdgeLeft 40.0
#define TINTCOLOR_ALPHA 0.2 //浅色透明度
#define DARKCOLOR_ALPHA 0.5 //深色透明度

#endif /* GZPublicConst_h */
