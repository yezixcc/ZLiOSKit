//
//  ZLTimeTool.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/15.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLTimeTool.h"

@implementation ZLTimeTool

/// 时间差转距离现在多久
/// @param sourceTime 原始时间
+ (NSString *)formatAgoForTime:(long long)sourceTime {
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:sourceTime];
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    float temp = 0;
    NSString *result;
    if (timeInterval < 60) {
        result = [NSString stringWithFormat:@"刚刚"];
    }else if((temp = timeInterval/60) < 60){
        result = [NSString stringWithFormat:@"%ld分钟前",(long)temp];
    }else if((temp = timeInterval/3600) > 1 && (temp = timeInterval/3600) <24){
        result = [NSString stringWithFormat:@"%ld小时前",(long)temp];
    }else{
        result = [self formatTime:sourceTime toFormat:ZLTimeFormatYearMonthDayHourMin];
    }
    return result;
}

/// 时间戳转日期 -- @"2020-12-20 23:00:00"
/// @param sourceTime 时间数字
/// @param format 转换格式
+ (NSString *)formatTime:(long long)sourceTime toFormat:(ZLTimeFormat)format {
    long long time = sourceTime;
    NSDate *date = [[NSDate alloc]initWithTimeIntervalSince1970:time];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSString *formatString = [self formatStringWithFormat:format separator:@"-"];
    [formatter setDateFormat:formatString];
    NSString*timeString=[formatter stringFromDate:date];
    return timeString;
}

/// 日期格式
/// @param format 格式
/// @param separator 分隔样式 默认@"-"
+ (NSString *)formatStringWithFormat:(ZLTimeFormat)format
                           separator:(NSString *)separator {
    separator = separator ? : @"-";
    switch (format) {
        case ZLTimeFormatYear:
            return @"yyyy";
            break;
        case ZLTimeFormatYearMonth:
            return [NSString stringWithFormat:@"yyyy%@MM", separator];
            break;
        case ZLTimeFormatYearMonthDay:
            return [NSString stringWithFormat:@"yyyy%@MM%@dd", separator, separator];
            break;
        case ZLTimeFormatYearMonthDayHour:
            return [NSString stringWithFormat:@"yyyy%@MM%@dd HH", separator, separator];
            break;
        case ZLTimeFormatYearMonthDayHourMin:
            return [NSString stringWithFormat:@"yyyy%@MM%@dd HH:mm", separator, separator];
        case ZLTimeFormatYearMonthDayHourMinSecond:
            return [NSString stringWithFormat:@"yyyy%@MM%@dd HH:mm:ss", separator, separator];
            break;
        default:
            break;
    }
    return @"yyyy-MM-dd HH:mm:ss";
}

/// 格式化日期 -- @"20200202" -> @"2020.02.02"
/// @param dateString 目标日期
/// @param separator 分隔符（上面例子为@"."）
+ (NSString *)formatDateString:(NSString *)dateString
                     separator:(NSString *)separator {
    NSString *fromFormat = [self formatStringWithFormat:ZLTimeFormatYearMonthDay separator:@""];
    NSString *toFormat = [self formatStringWithFormat:ZLTimeFormatYearMonthDay separator:separator];
    return [self formatDateString:dateString fromFormat:fromFormat toFormat:toFormat];
}

/// 格式化日期 -- @"20200202" -> @"2020.02.02"
/// @param dateString 目标日期（@"20200202"）
/// @param fromFormat 原始日期格式（@"yyyyMMdd"）
/// @param toFormat 目标日期格式（@"yyyy.MM.dd"）
+ (NSString *)formatDateString:(NSString *)dateString
                    fromFormat:(NSString *)fromFormat
                      toFormat:(NSString *)toFormat {
    if (dateString.length <= 0 ||
        fromFormat.length <= 0 ||
        toFormat.length <= 0) {
        return nil;
    }
    NSDateFormatter *fromDateFormatter = [[NSDateFormatter alloc] init];
    fromDateFormatter.dateFormat = fromFormat;
    NSDate *date = [fromDateFormatter dateFromString:dateString];
    
    NSDateFormatter *toDateFormatter = [[NSDateFormatter alloc] init];
    toDateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    toDateFormatter.dateFormat = toFormat;
    
    return [toDateFormatter stringFromDate:date];
}

+ (NSDate *)formatDate:(NSString *)date format:(NSString *)format {
    if (date.length <= 0) {
        return nil;
    }
    if (format.length <= 0) {
        format = nil;
    }
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString:date];
}

@end
