//
//  ZLTheme.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/3/24.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 主题变换通知名称
static NSString *ThemeDidChangeNotification = @"ThemeDidChangeNotification";
@interface ZLThemeManager : NSObject

/// 当前主题名称
@property (nonatomic, copy, readonly) NSString *currentThemeName;

/// 单例对象
+ (ZLThemeManager *)shared;

/// 默认主题
+ (BOOL)isDefaultTheme;

/// 主题变换
/// @param themeName 即将变换的主题(bundle文件名)
/// @param isNotify 发送通知
- (void)changeTheme:(NSString *)themeName shouldNotify:(BOOL)isNotify;

/// 获取主题中的图片
/// @param nameOfImage 图片名称
+ (UIImage *)imageForImageName:(NSString *)nameOfImage;

/// 获取主题中的颜色
/// @param keyOfColor 颜色
+ (UIColor *)colorForKey:(NSString *)keyOfColor;

/// 获取主题中的字体
/// @param keyOfFont 字体
+ (UIFont *)fontForKey:(NSString *)keyOfFont;

/// 获取主题中的字体
/// @param size 字体大小
/// @param keyOfFont 字体
+ (UIFont *)fontForSize:(CGFloat)size key:(NSString *)keyOfFont;

@end
