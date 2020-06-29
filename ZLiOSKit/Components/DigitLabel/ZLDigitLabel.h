//
//  ZLDigitLabel.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/3/30.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZLDigitLabelStyle) {
    ZLDigitLabelStyleDefault,   /// 纯数字
    ZLDigitLabelStyleSign,      /// 数字带正负号
    ZLDigitLabelStylePercent,   /// 数字带百分号
    ZLDigitLabelStyleSignAndPercent,    /// 数字带正负号和百分号
};


/**
 此类用于处理数字 - 例： +20.00%
 1、带正负号
 2、带百分号
 3、红涨绿跌
 4、数字字体大,符号字体小
 
 注：属性设置需在设置text之前方可有效
 */
@interface ZLDigitLabel : UILabel

/// 文字颜色正红负绿 - 默认YES
@property (nonatomic, assign) BOOL textColorNeedAuto;

/// 千分位分隔 - 默认YES
@property (nonatomic, assign) BOOL textBehavior10_4;

/// 符号字体大小小于数字字体大小 - 默认NO
@property (nonatomic, assign) BOOL signSmall;

/// 小数位数 - 默认2位
@property (nonatomic, assign) NSInteger digitsCount;

/// 正负号显示(默认显示)
@property (nonatomic, assign) BOOL isSign;

/// 样式
@property (nonatomic, assign) ZLDigitLabelStyle style;

/// 实例化
/// @param style 风格
- (instancetype)initWithStyle:(ZLDigitLabelStyle)style;


@end

