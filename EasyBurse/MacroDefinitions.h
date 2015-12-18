//
//  MacroDefinitions.h
//  MyTreasure
//
//  Created by Bryan on 15/11/11.
//  Copyright © 2015年 makervt. All rights reserved.
//

#ifndef MacroDefinitions_h
#define MacroDefinitions_h

//-------------------获取设备大小-------------------------
/*
 *状态条高度
 */
#define STATUSBAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
/**
 * 状态栏
 */
#define NAVIGATION_BAR_HEIGHT (IOS_7_OR_LATER ? 65 : 45)
/**
 * 导航条
 */
#define MENUS_HEIGHT (44)
/**
 *  tabbar 高度
 */
#define TABBAR_HEIGHT (49)


#define BASE_RATE (SCREEN_WIDTH/320)


#define APP_SCREEN_HEIGHT_NO_TABBAR (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT)
#define APP_SCREEN_HEIGHT_WITH_TABBAR (SCREEN_HEIGHT - NAVIGATION_BAR_HEIGHT - TABBAR_HEIGHT)


//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

//-------------------获取设备大小-------------------------


//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif

//---------------------打印日志--------------------------

// 数据库当前版本
#define DB_VERSION_NOW 1

//----------------------系统----------------------------

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define isLANDSCAPE         ([UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft || [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeRight)
//是否ipad
#define isIPAD              ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)
//是否iPhone
#define isIPHONE            ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone)

//是否iphone4
#define isIPHONE4           (isIPHONE && [[UIScreen mainScreen] bounds].size.height < 568.0)

//是否iphone5
#define isIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
//是否iphone6
#define isIPHONE6           (isIPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0)
//是否iphone6+
#define isIPHONE6PLUS       (isIPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0 || [[UIScreen mainScreen] bounds].size.width == 736.0) // Both orientations

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

#define IOS_7_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? (YES):(NO))
#define IOS_8_OR_LATER   ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0)


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//----------------------系统----------------------------


//----------------------内存----------------------------

//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x) [x release];x=nil



//----------------------内存----------------------------


//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:_pointer]

//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------



//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

//带有RGBA的颜色设置
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define RGBZ(r) RGBA(r,r,r,1.0f)

#define RGBAZ(r,a) RGBA(r,r,r,a)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:240.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

/**
 * 红色
 */
#define RedColor [UIColor colorWithRed:220.0/255.0 green:63.0/255.0 blue:68.0/255.0 alpha:1.0]
/**
 * 绿色
 */
#define GreenColor [UIColor colorWithRed:116.0/255.0 green:207.0/255.0 blue:148.0/255.0 alpha:1.0]

/**
 * 白色
 */
#define WhiteColor [UIColor whiteColor]
/**
 * 黑色
 */
#define BlackColor [UIColor blackColor]

/**
 * 分割线颜色
 */
#define SEPARATOR_LINE_COLOR RGB(0xdf, 0xdf, 0xdf)

/**
 * 浅黑色
 */
#define FONT_COLOR_33   RGB(0x33,0x33,0x33)

#define FONT_COLOR_33_A   RGBA(0x33,0x33,0x33,0.8)

/**
 * 深灰色
 */
#define FONT_COLOR_66   RGB(0x66,0x66,0x66)
#define FONT_COLOR_66_A   RGBA(0x66,0x66,0x66,0.8)

/**
 * 中灰色
 */
#define FONT_COLOR_99   RGB(0x99,0x99,0x99)
#define FONT_COLOR_99_A   RGBA(0x99,0x99,0x99,0.8)


//----------------------颜色类--------------------------



//----------------------其他----------------------------

//weakSelf
#define WeaklySelf(weakSelf)  __weak __typeof(&*self)weakSelf = self

//默认cacahe时间为一天
#define DEFAULT_CACHE_INTERVAL (86400)

//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

/**
 * 定义Rect
 */
#define rect(x,y,w,h) CGRectMake(x,y,w,h)
/**
 * 定义point
 */
#define point(x,y) CGPointMake(x,y)
/**
 * 定义size
 */
#define size(w,h) CGSizeMake(w,h)
/**
 *  获取最大X,Y
 */
#define maxX(rect) CGRectGetMaxX(rect)
#define maxY(rect) CGRectGetMaxY(rect)
/**
 *  获取最小X,Y
 */
#define minX(rect) CGRectGetMinX(rect)
#define minY(rect) CGRectGetMinY(rect)
/**
 *  获取矩形宽,高
 */
#define rectW(rect) CGRectGetWidth(rect)
#define rectH(rect) CGRectGetHeight(rect)
//定义字体大小
#define font(s) [UIFont systemFontOfSize:s]

#endif /* MacroDefinitions_h */
