//
//  ZLThemeManager.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/3/24.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLThemeManager.h"
#import <CoreText/CoreText.h>
#import "UIColor+HexMethod.h"

/// color.plist
#define ColorPlist @"color"
/// font.plist
#define FontPlist @"font"
/// images document
#define ImagesDocument @"images"
/// default size
#define FontSize 14

@interface ZLThemeManager ()

@property (nonatomic, copy, readwrite) NSString *currentThemeName;
@property (nonatomic, copy) NSDictionary *colorStyles;
@property (nonatomic, copy) NSDictionary *fontStyles;
@property (nonatomic, copy) NSString *imagePath;
@property (nonatomic, copy) NSString *bundlePath;

@end

static NSString *kCurrentTheme = @"CurrentTheme";
static NSString *kDefaultTheme = @"NormalTheme";
@implementation ZLThemeManager

- (instancetype)init {
    self = [super init];
    if (self) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *themeName = [defaults objectForKey:kCurrentTheme];
        if (!themeName) {
            themeName = kDefaultTheme;
        }
        [self changeTheme:themeName shouldNotify:NO];
    }
    return self;
}

- (void)setCurrentThemeName:(NSString *)currentThemeName {
    _currentThemeName = currentThemeName;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_currentThemeName forKey:kCurrentTheme];
    [defaults synchronize];
}

/// 单例对象
+ (ZLThemeManager *)shared {
    static ZLThemeManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZLThemeManager alloc] init];
    });
    return manager;
}

/// 默认主题
+ (BOOL)isDefaultTheme {
    NSString *currentTheme = [ZLThemeManager shared].currentThemeName;
    return [currentTheme isEqualToString:kDefaultTheme];
}

/// 主题变换
/// @param themeName 即将变换的主题
/// @param isNotify 发送通知
- (void)changeTheme:(NSString *)themeName shouldNotify:(BOOL)isNotify {
    if (![themeName isEqualToString:self.currentThemeName]) {
        self.currentThemeName = themeName;
        NSLog(@"current theme is %@",themeName);
        NSString *bundlePath = [[NSBundle mainBundle] pathForResource:themeName ofType:@"bundle"];
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        
        NSString *colorPath = [bundle pathForResource:ColorPlist ofType:@"plist"];
        self.colorStyles = [NSDictionary dictionaryWithContentsOfFile:colorPath];
        
        NSString *fontPath = [bundle pathForResource:FontPlist ofType:@"plist"];
        self.fontStyles = [NSDictionary dictionaryWithContentsOfFile:fontPath];
        
        self.imagePath = [bundle pathForResource:ImagesDocument ofType:nil];
        
        if (isNotify) {
            [[NSNotificationCenter defaultCenter] postNotificationName:ThemeDidChangeNotification object:nil];
        }
    }
}


/// 获取主题中的图片
/// @param nameOfImage 图片名称
+ (UIImage *)imageForImageName:(NSString *)nameOfImage {
    ZLThemeManager *manager = [ZLThemeManager shared];
    if(nameOfImage.length) {
        NSString *namePathOfImage = [NSString stringWithFormat:@"%@.bundle/%@/%@",manager.currentThemeName,ImagesDocument,nameOfImage];
        UIImage *image = [UIImage imageNamed:namePathOfImage];
        if (image) {
            return image;
        }
        return [UIImage imageNamed:nameOfImage];
    }
    return nil;
}


/// 获取主题中的颜色
/// @param keyOfColor 颜色
+ (UIColor *)colorForKey:(NSString *)keyOfColor {
    ZLThemeManager *manager = [ZLThemeManager shared];
    NSString *hexString = manager.colorStyles[keyOfColor];
    if (hexString) {
        return [UIColor colorWithHexString:hexString];
    }
    return [UIColor whiteColor];
}


/// 获取主题中的字体
/// @param keyOfFont 字体
+ (UIFont *)fontForKey:(NSString *)keyOfFont {
    return [self fontForSize:FontSize key:keyOfFont];
}


/// 获取主题中的字体
/// @param size 字体大小
/// @param keyOfFont 字体
+ (UIFont *)fontForSize:(CGFloat)size key:(NSString *)keyOfFont {
    ZLThemeManager *manager = [ZLThemeManager shared];
    NSDictionary *fontProperties = manager.fontStyles[keyOfFont];
    if (fontProperties) {
        NSString *fontPath = fontProperties[@"fontPath"];
        NSString *fontName = fontProperties[@"fontName"];
        float fontSize = [fontProperties[@"fontSize"] floatValue] ?:size;
        if(fontPath.length) {
            return [self registFontFromBundle:fontPath fontName:fontName fontSize:fontSize];
        } else if(!fontName.length) {
            return [UIFont systemFontOfSize:fontSize];
        } else {
            return [UIFont fontWithName:fontName size:fontSize];
        }
    }
    return [UIFont systemFontOfSize:size];
}


/// 第三方字体
/// @param fontPath 字体路径
/// @param aFontName 字体名称
/// @param size 大小
+ (UIFont *)registFontFromBundle:(NSString *)fontPath fontName:(NSString *)aFontName fontSize:(float)size {
    ZLThemeManager *manager = [ZLThemeManager shared];
    NSString *fontFullPath = [manager.bundlePath stringByAppendingString:fontPath];
    UIFont *font;
    NSData *dataOfFont = [NSData dataWithContentsOfFile:fontFullPath];
    if (dataOfFont) {
        CFErrorRef error;
        CGDataProviderRef providerRef = CGDataProviderCreateWithCFData((CFDataRef)dataOfFont);
        CGFontRef fontRef = CGFontCreateWithDataProvider(providerRef);
        if (! CTFontManagerRegisterGraphicsFont(fontRef, &error)) {
            //if failed ,use default font.
            CFStringRef errorDescription = CFErrorCopyDescription(error);
            NSLog(@"Failed to load font: %@", errorDescription);
            CFRelease(errorDescription);
            font = [UIFont systemFontOfSize:size];
        } else {
            font = [UIFont fontWithName:aFontName size:size];
        }
        CFRelease(fontRef);
        CFRelease(providerRef);
        return font;
    } else {
        return [UIFont systemFontOfSize:size];
    }
}

/// 打印系统字体
+ (void)printAllFonts {
    NSArray *fontFamilies = [UIFont familyNames];
    
    for (NSString *fontFamily in fontFamilies) {
        NSArray *fontNames = [UIFont fontNamesForFamilyName:fontFamily];
        NSLog (@"%@: %@", fontFamily, fontNames);
    }
}

@end
