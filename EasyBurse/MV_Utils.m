//
//  MV_Utils.m
//  MyTreasure
//
//  Created by Bryan on 15/11/19.
//  Copyright © 2015年 makervt. All rights reserved.
//

#import "MV_Utils.h"

@implementation MV_Utils

+ (NSString *)dateWithSting:(NSString *)timer withFormat:(NSString *)format
{
    if (timer == nil || timer.integerValue == 0) {
        return @"";
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timer.longLongValue/1000];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setLocale:usLocale];
    NSString *result = [dateFormatter stringFromDate:date];
    return result;
}
+ (NSString *)dateWithDate:(NSDate *)timer withFormat:(NSString *)format
{
    if (timer == nil) {
        return @"";
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [dateFormatter setLocale:usLocale];
    NSString *result = [dateFormatter stringFromDate:timer];
    return result;
}

+ (NSString *) styleDateFrom:(NSString *)timeStr
{
    NSDateFormatter *_dateFormate = [[NSDateFormatter alloc] init];
    [_dateFormate setDateFormat:@"yyyy-MM-dd"];
    NSString *_dateStr = [_dateFormate stringFromDate:[self dencodeTime:timeStr]];
    return _dateStr;
}

+ (NSDate *) dencodeTime:(NSString *)dateString
{
    @try {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [formatter dateFromString:dateString];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
    
}

+ (NSString *) currentDateStr:(NSString *)time
{
    NSDateFormatter *_dateFormate = [[NSDateFormatter alloc] init];
    [_dateFormate setDateFormat:@"yyyy年MM月dd日"];
    NSString *_dateStr = [_dateFormate stringFromDate:[self dencodeTime:time]];
    return _dateStr;
}

+ (NSString *)getPassWord;
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"gesturePassword"];
}

+ (void)setPassWord:(NSString *)password;
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:password forKey:@"gesturePassword"];
}

+ (BOOL)isHavePass
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:@"havePass"];
}

+ (void)setHavePass:(BOOL)havePass
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:havePass forKey:@"havePass"];
}

+ (NSInteger)getYear;
{
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday fromDate:[NSDate date]];
    
    return [dateComponents year];
}
@end