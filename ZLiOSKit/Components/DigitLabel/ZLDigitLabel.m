//
//  ZLDigitLabel.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/3/30.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLDigitLabel.h"
#import "ZLTheme.h"
#import "ZLDigitTool.h"

@implementation ZLDigitLabel

- (instancetype)initWithStyle:(ZLDigitLabelStyle)style {
    self = [super init];
    if (self) {
        self.style = style;
        self.fontKey = kFont_Digit_Bold;
        self.textColorKey = kThemeColor;
        self.textColorNeedAuto = YES;
        self.textBehavior10_4 = YES;
        self.signSmall = NO;
        self.isSign = NO;
        self.digitsCount = 2;
    }
    return self;
}

- (void)setIsSign:(BOOL)isSign {
    _isSign = isSign;
    if (isSign) {
        return;
    }
    switch (self.style) {
        case ZLDigitLabelStyleSign:
            _style = ZLDigitLabelStyleDefault;
            break;
        case ZLDigitLabelStyleSignAndPercent:
            _style = ZLDigitLabelStylePercent;
            break;
        default:
            break;
    }
}

- (void)setText:(NSString *)text {
    if (![ZLDigitTool deptNumInputShouldNumber:text]) {
        [super setText:text];
        self.font = [ZLThemeManager fontForSize:20 key:kFont_PingFangSC_Bold];
        return;
    }
    self.fontKey = kFont_Digit_Bold;
    /// 红涨绿跌
    if (self.textColorNeedAuto) {
        self.textColorKey = [ZLDigitTool riseOrFallColorKeyForValue:text.doubleValue];
    }
    BOOL isSign = NO;
    BOOL isPercent = NO;
    switch (self.style) {
        case ZLDigitLabelStyleSign:
            isSign = YES;
            break;
        case ZLDigitLabelStylePercent:
            isPercent = YES;
            break;
        case ZLDigitLabelStyleSignAndPercent: {
            isSign = YES;
            isPercent = YES;
        }
            break;
        default:
            break;
    }
    text = [ZLDigitTool appendValue:text.doubleValue
                               sign:isSign
                            percent:isPercent
                 formatBehavior10_4:_textBehavior10_4
                        digitsCount:_digitsCount];
    
    /// 正负号和百分号 字体小点
    if (_signSmall) {
        self.attributedText = [ZLDigitTool formatSmallSign:text orignFont:self.font];
    }else {
        self.attributedText = [[NSAttributedString alloc] initWithString:text];
    }
}

@end
