//
//  ZLTimeTool.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/15.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZLTimeFormat) {
    ZLTimeFormatYear,
    ZLTimeFormatYearMonth,
    ZLTimeFormatYearMonthDay,
    ZLTimeFormatYearMonthDayHour,
    ZLTimeFormatYearMonthDayHourMin,
    ZLTimeFormatYearMonthDayHourMinSecond,
};

@interface ZLTimeTool : NSObject

/// 时间差转距离现在多久
/// @param sourceTime 原始时间(10位数字)
+ (NSString *)formatAgoForTime:(long long)sourceTime;

/// 时间戳转日期 -- @"2020-12-20 23:00:00"
/// @param sourceTime 原始时间(10位数字)
/// @param format 转换格式
+ (NSString *)formatTime:(long long)sourceTime
                toFormat:(ZLTimeFormat)format;

/// 日期格式
/// @param format 格式
/// @param separator 分隔样式 默认@"-"
+ (NSString *)formatStringWithFormat:(ZLTimeFormat)format
                           separator:(NSString *)separator;

/// 格式化日期 -- @"20200202" -> @"2020.02.02"
/// @param dateString 目标日期
/// @param separator 分隔符（上面例子为@"."）
+ (NSString *)formatDateString:(NSString *)dateString
                     separator:(NSString *)separator;

/// 格式化日期 -- @"20200202" -> @"2020.02.02"
/// @param dateString 目标日期（@"20200202"）
/// @param fromFormat 原始日期格式（@"yyyyMMdd"）
/// @param toFormat 目标日期格式（@"yyyy.MM.dd"）
+ (NSString *)formatDateString:(NSString *)dateString
                    fromFormat:(NSString *)fromFormat
                      toFormat:(NSString *)toFormat;

/// String转Date
/// @param date 日期字符串
/// @param format 格式
+ (NSDate *)formatDate:(NSString *)date
                format:(NSString *)format;
@end

