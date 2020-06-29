//
//  ZLDigitTool.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/3/30.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLDigitTool.h"
#import "ZLTheme.h"

@implementation ZLDigitTool


/// 添加正负号 - 例如：+23.00
/// @param value 数值
+ (NSString *)appendSign:(double)value {
    return [self appendValue:value
                        sign:YES
                     percent:NO];
}


/// 添加百分号 - 例如：23.00%
/// @param value 数值
+ (NSString *)appendPercent:(double)value {
    return [self appendValue:value
                        sign:NO
                     percent:YES];
}


/// 添加正负号和百分号 - 例如：+23.00%
/// @param value 数值
/// @param isSign 是否添加正负号
/// @param isPercent 是否添加百分号
+ (NSString *)appendValue:(double)value
                     sign:(BOOL)isSign
                  percent:(BOOL)isPercent {
    return [self appendValue:value
                        sign:isSign
                     percent:isPercent
          formatBehavior10_4:NO
                 digitsCount:2];
}


/// 千分位分隔  - 例如：10,000.00
/// @param value 数值
+ (NSString *)formatBehavior10_4:(double)value {
    return [self formatBehavior10_4:value sign:NO];
}


/// 带正负号千分位分隔  - 例如：+10,000.00
/// @param value 数值
/// @param isSign 是否添加正负号
+ (NSString *)formatBehavior10_4:(double)value
                            sign:(BOOL)isSign {
    return [self formatBehavior10_4:value
                               sign:isSign
                              round:NO];
}


/// 带正负号千分位分隔取整  - 例如：+10,000
/// @param value 数值
/// @param isSign 是否添加正负号
/// @param isRound 是否取整
+ (NSString *)formatBehavior10_4:(double)value
                            sign:(BOOL)isSign
                           round:(BOOL)isRound {
    NSInteger digitsCount = isRound ? 0 : 2;
    return [self appendValue:value
                        sign:isSign
                     percent:NO
          formatBehavior10_4:YES
                 digitsCount:digitsCount];
}


/// 数字字体大，正负号和百分号小
/// @param string 字符串
+ (NSAttributedString *)formatSmallSign:(NSString *)string
                              orignFont:(UIFont *)font {
    if (!string.length) {
        return nil;
    }
    if (font) {
        CGFloat fontSize = font.pointSize/2+2;
        NSString *fontName = font.fontName;
        font = [UIFont fontWithName:fontName size:fontSize];
    }else {
        font = [ZLThemeManager fontForSize:14 key:kFont_DIN_Bold];
    }
    
    NSRange range1 = [string rangeOfString:@"+"];
    NSRange range2 = [string rangeOfString:@"%"];
    NSRange range3 = [string rangeOfString:@"-"];
    NSDictionary *dict = @{NSFontAttributeName: font};
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeStr addAttributes:dict range:range1];
    [attributeStr addAttributes:dict range:range2];
    [attributeStr addAttributes:dict range:range3];
    return attributeStr;
}


/// 添加正负号和百分号，设置小数位数 - 例如：+23,000.001%
/// @param value 数值
/// @param isSign 是否添加正负号
/// @param isPercent 是否添加百分号
/// @param isFormatBehavior10_4 是否千分位分隔
/// @param digitsCount 小数位数
+ (NSString *)appendValue:(double)value
                     sign:(BOOL)isSign
                  percent:(BOOL)isPercent
       formatBehavior10_4:(BOOL)isFormatBehavior10_4
              digitsCount:(NSInteger)digitsCount {
    if (isnan(value)) {
        return @"--";
    }
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.minimumFractionDigits = digitsCount;
    formatter.maximumFractionDigits = digitsCount;
    formatter.minimumIntegerDigits = 1;
    if (isFormatBehavior10_4) {
        formatter.formatterBehavior = NSNumberFormatterBehavior10_4;
        formatter.numberStyle = NSNumberFormatterDecimalStyle;
    }
    NSString *result = [formatter stringFromNumber:[NSNumber numberWithDouble:value]];
    if (isPercent) {
        result = [result stringByAppendingString:@"%"];
    }
    if (isSign && value >= 0) {
        result = [NSString stringWithFormat:@"+%@", result];
    }
    return result;
}


/// 数字字符串判读
/// @param str 字符串
+ (BOOL)deptNumInputShouldNumber:(NSString *)str {
    str = [NSString stringWithFormat:@"%@", str];
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(str && str.length > 0) {
        if ([str rangeOfString:@"."].location != NSNotFound) {
            return YES;
        }
        return NO;
    }
    return YES;
}


/// 涨跌数字的颜色key
/// @param value  数值
+ (NSString *)riseOrFallColorKeyForValue:(double)value {
    if (value == 0) {
        return kTextColor_Main;
    }
    return value > 0 ? kThemeColor : kGreenColor;
}

@end
