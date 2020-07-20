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

/// 金额小写转大写
+ (NSString *)formatTotalUppercase:(NSString *)total {
    if ([total hasPrefix:@"-"]) {
        return nil;
    }
    if (total.length <= 0) {
        return nil;
    }
    //转换中文大写数字
    NSString *rel = nil;
    NSString *intStr = nil;
    NSString *floatStr1 = nil;
    NSString *floatStr2 = nil;
    NSRange range = [total rangeOfString:@"."];
    if (range.location != NSNotFound && range.location == 0) {
        total = [NSString stringWithFormat:@"0%@", total];
        range = [total rangeOfString:@"."];
    }
    if (range.location != NSNotFound) {
        NSString *dStr = [total substringFromIndex:range.location+1];
        if (dStr.length > 0) floatStr1 = [dStr substringToIndex:1];
        if (dStr.length >= 2) {
            floatStr2 = [dStr substringFromIndex:1];
            floatStr2 = [floatStr2 substringToIndex:1];
        }
        intStr = [total substringToIndex:range.location];
    }else{
        intStr = total;
    }
    
    NSString *topstr=[intStr stringByReplacingOccurrencesOfString:@"," withString:@""];//过滤逗号
    NSInteger numl=[topstr length];//确定长度
    NSString *cache;//缓存
    if ((numl==2||numl==6)&&[topstr hasPrefix:@"1"] ){//十位或者万位为一时候
        cache=@"拾";
        for (int i=1; i<numl; i++) {
            cache=[NSString stringWithFormat:@"%@%@",cache,[self bit:topstr thenum:i]];
        }
    }else{//其他
        cache=@"";
        for (int i=0; i<numl; i++) {
            cache=[NSString stringWithFormat:@"%@%@",cache,[self bit:topstr thenum:i]];
        }
    }//转换完大写
    rel = @"";
    cache=[cache substringWithRange:NSMakeRange(0, [cache length]-1)];
    for (NSInteger i=[cache length]; i>0; i--) {//擦屁股，如果尾部为0就擦除
        if ([cache hasSuffix:@"零"]) {
            cache=[cache substringWithRange:NSMakeRange(0, i-1)];
        }else{
            continue;
        }
    }
    for (NSInteger i=[cache length]; i>0; i--) {//重复零，删零
        NSString *a=[cache substringWithRange:NSMakeRange(i-1, 1)];
        NSString *b=[cache substringWithRange:NSMakeRange(i-2, 1)];
        if (!([a isEqualToString:b]&&[a isEqualToString:@"零"])) {
            rel = [NSString stringWithFormat:@"%@%@",a,rel];
        }
        cache=[cache substringWithRange:NSMakeRange(0, i-1)];
    }
    cache = rel;
    rel = @"元";
    for (NSInteger i=[cache length]; i>0; i--) {//去掉 “零万” 和 “亿万”
        NSString *a=[cache substringWithRange:NSMakeRange(i-1, 1)];
        NSString *b=[cache substringWithRange:NSMakeRange(i-2, 1)];
        if ([a isEqualToString:@"万"]&&[b isEqualToString:@"零"]) {
            NSString *c=[cache substringWithRange:NSMakeRange(i-3, 1)];
            if ([c isEqualToString:@"亿"]){
                rel = [NSString stringWithFormat:@"%@%@",c,rel];
                cache=[cache substringWithRange:NSMakeRange(0, i-3)];
                i=i-2;
            }else{
                rel = [NSString stringWithFormat:@"%@%@",a,rel];
                cache=[cache substringWithRange:NSMakeRange(0, i-2)];
                i--;
            }
        }else{
            rel = [NSString stringWithFormat:@"%@%@",a,rel];
        }
        cache=[cache substringWithRange:NSMakeRange(0, i-1)];
    }
    
    if ([rel isEqualToString:@"元"]) {
        rel=@"零元";
    }
    
    
    if (floatStr1!=nil ) {
        if (floatStr2!=nil && ![floatStr2 isEqualToString:@"0"]) {
            rel = [NSString stringWithFormat:@"%@%@角%@分",rel,[self NumtoCN:floatStr1 site:0],[self NumtoCN:floatStr2 site:0]];
        }else{
            if (![floatStr1 isEqualToString:@"0"]) {
                rel = [NSString stringWithFormat:@"%@%@角",rel,[self NumtoCN:floatStr1 site:0]];
            }
        }
    }
    if (floatStr1 == nil) rel = [rel stringByAppendingString:@"整"];
    
    return rel;
}

// 阿拉伯数字转中文大写
+ (NSString*)NumtoCN:(NSString*)string site:(int)site {
    if ([string isEqualToString:@"0"]) {
        if (site==5) {
            return @"万零";
        }else{
            return @"零";
        }
    }else if ([string isEqualToString:@"1"]) {
        string=@"壹";
    }else if ([string isEqualToString:@"2"]) {
        string=@"贰";
    }else if ([string isEqualToString:@"3"]) {
        string=@"叁";
    }else if ([string isEqualToString:@"4"]) {
        string=@"肆";
    }else if ([string isEqualToString:@"5"]) {
        string=@"伍";
    }else if ([string isEqualToString:@"6"]) {
        string=@"陆";
    }else if ([string isEqualToString:@"7"]) {
        string=@"柒";
    }else if ([string isEqualToString:@"8"]) {
        string=@"捌";
    }else if ([string isEqualToString:@"9"]) {
        string=@"玖";
    }
    
    
    switch (site) {
        case 1:
            return [NSString stringWithFormat:@"%@元",string];
            break;
        case 2:
            return [NSString stringWithFormat:@"%@拾",string];
            break;
        case 3:
            return [NSString stringWithFormat:@"%@佰",string];
            break;
        case 4:
            return [NSString stringWithFormat:@"%@仟",string];
            break;
        case 5:
            return [NSString stringWithFormat:@"%@万",string];
            break;
        case 6:
            return [NSString stringWithFormat:@"%@拾",string];
            break;
        case 7:
            return [NSString stringWithFormat:@"%@佰",string];
            break;
        case 8:
            return [NSString stringWithFormat:@"%@仟",string];
            break;
        case 9:
            return [NSString stringWithFormat:@"%@亿",string];
            break;
        default:
            return string;
            break;
    }
}

// 取位转大写
+ (NSString*)bit:(NSString*)string thenum:(int)num {
    NSInteger site=[string length]-num;
    string=[string stringByReplacingOccurrencesOfString:@"," withString:@""];
    string=[string substringWithRange:NSMakeRange(num,1)];
    string=[self NumtoCN:string site:(int)site];
    return string;
}

@end
