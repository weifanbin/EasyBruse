//
//  MV_Utils.h
//  MyTreasure
//
//  Created by Bryan on 15/11/19.
//  Copyright © 2015年 makervt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MV_Utils : NSObject

+ (NSString *)dateWithSting:(NSString *)timer withFormat:(NSString *)format;

+ (NSString *)dateWithDate:(NSDate *)timer withFormat:(NSString *)format;

//转换字符串为"yyyy-MM-dd HH:mm:ss"格式到NSDate
+ (NSDate *) dencodeTime:(NSString *) dateString;

+ (NSString *) currentDateStr:(NSString *)time;//yyyy年MM月dd日

+ (NSString *) styleDateFrom:(NSString *)timeStr;//将 yyyy-MM-dd hh:mm:ss 转换为yyyy-MM-dd各式

+ (NSString *)getPassWord;
+ (void)setPassWord:(NSString *)password;

+ (BOOL)isHavePass;
+ (void)setHavePass:(BOOL)havePass;

+ (NSInteger)getYear;
@end