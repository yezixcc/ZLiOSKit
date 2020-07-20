//
//  NSDate+ZLExtension.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/7/6.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "NSDate+ZLExtension.h"

@implementation NSDate (ZLExtension)

- (NSString *)week {
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"星期天", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [calendar setTimeZone: timeZone];
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:self];
    return [weekdays objectAtIndex:theComponents.weekday];
}

@end
