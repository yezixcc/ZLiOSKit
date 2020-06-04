//
//  UIColor+HexMethod.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/3/26.
//  Copyright © 2020 zlfund. All rights reserved.
//
#import <UIKit/UIKit.h>

@interface UIColor (HexMethod)

+ (UIColor *)color255WithRed:(int)red green:(int)green blue:(int)blue alpha:(int)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(int)alpha;

+ (UIColor *)colorWithHexString:(NSString *)hexString;

@end

