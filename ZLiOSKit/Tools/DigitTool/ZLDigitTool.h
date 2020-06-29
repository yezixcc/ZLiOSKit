//
//  ZLDigitTool.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/3/30.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZLDigitTool : NSObject


/// 添加正负号 - 例如：+23.00
/// @param value 数值
+ (NSString *)appendSign:(double)value;


/// 添加百分号 - 例如：23.00%
/// @param value 数值
+ (NSString *)appendPercent:(double)value;


/// 添加正负号和百分号 - 例如：+23.00%
/// @param value 数值
/// @param isSign 是否添加正负号
/// @param isPercent 是否添加百分号
+ (NSString *)appendValue:(double)value
                     sign:(BOOL)isSign
                  percent:(BOOL)isPercent;


/// 千分位分隔  - 例如：10,000.00
/// @param value 数值
+ (NSString *)formatBehavior10_4:(double)value;


/// 带正负号千分位分隔  - 例如：+10,000.00
/// @param value 数值
/// @param isSign 是否添加正负号
+ (NSString *)formatBehavior10_4:(double)value
                            sign:(BOOL)isSign;


/// 带正负号千分位分隔取整  - 例如：+10,000
/// @param value 数值
/// @param isSign 是否添加正负号
/// @param isRound 是否取整
+ (NSString *)formatBehavior10_4:(double)value
                            sign:(BOOL)isSign
                           round:(BOOL)isRound;


/// 数字字体大，正负号和百分号小
/// @param string 字符串
/// @param font 原始字体
+ (NSAttributedString *)formatSmallSign:(NSString *)string
                              orignFont:(UIFont *)font;

 
/// 添加正负号和百分号,设置小数位数, - 例如：+23,000.001%
/// @param value 数值
/// @param isSign 是否添加正负号
/// @param isPercent 是否添加百分号
/// @param isFormatBehavior10_4 是否千分位分隔
/// @param digitsCount 小数位数
+ (NSString *)appendValue:(double)value
                     sign:(BOOL)isSign
                  percent:(BOOL)isPercent
       formatBehavior10_4:(BOOL)isFormatBehavior10_4
              digitsCount:(NSInteger)digitsCount;


/// 数字字符串判读
/// @param str 字符串
+ (BOOL)deptNumInputShouldNumber:(NSString *)str;


/// 涨跌数字的颜色key
/// @param value  数值
+ (NSString *)riseOrFallColorKeyForValue:(double)value;


@end

