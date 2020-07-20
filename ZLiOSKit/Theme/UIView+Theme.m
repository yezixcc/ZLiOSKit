//
//  UIView+Theme.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/3/26.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "UIView+Theme.h"
#import <objc/runtime.h>
#import "ZLThemeManager.h"

static void *KBackgroundColor = &KBackgroundColor;
static void *KTextColor = &KTextColor;
static void *KFont = &KFont;
static void *KImage = &KImage;

@implementation UIView (Theme)

+ (void)load {
    Method oriMethod = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method repMethod = class_getInstanceMethod([self class], @selector(replaceDelloc));
    method_exchangeImplementations(oriMethod, repMethod);
}

- (void)replaceDelloc{
    [self unregisterAsObserver];
    [self replaceDelloc];
}

- (void)configureViews {
    if (self.backgroundColorKey) {
        self.backgroundColor = [ZLThemeManager colorForKey:self.backgroundColorKey];
    }
    
    if ([self isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)self;
        if (self.textColorKey) {
            label.textColor = [ZLThemeManager colorForKey:self.textColorKey];
        }
        if (self.fontKey) {
            label.font = [ZLThemeManager fontForKey:self.fontKey];
        }
    }else if ([self isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = (UIImageView *)self;
        if (self.imageKey) {
            imageView.image = [ZLThemeManager imageForImageName:self.imageKey];
        }
    }else if ([self isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)self;
        if (self.imageKey) {
            [button setImage:[ZLThemeManager imageForImageName:self.imageKey] forState:UIControlStateNormal];
        }
        if (self.textColorKey) {
            [button setTitleColor:[ZLThemeManager colorForKey:self.textColorKey] forState:UIControlStateNormal];
        }
        if (self.fontKey) {
            button.titleLabel.font = [ZLThemeManager fontForKey:self.fontKey];
        }
    }else if ([self isKindOfClass:[UITextField class]]) {
        UITextField *label = (UITextField *)self;
        if (self.textColorKey) {
            label.textColor = [ZLThemeManager colorForKey:self.textColorKey];
        }
        if (self.fontKey) {
            label.font = [ZLThemeManager fontForKey:self.fontKey];
        }
    }else if ([self isKindOfClass:[UITextView class]]) {
        UITextView *label = (UITextView *)self;
        if (self.textColorKey) {
            label.textColor = [ZLThemeManager colorForKey:self.textColorKey];
        }
        if (self.fontKey) {
            label.font = [ZLThemeManager fontForKey:self.fontKey];
        }
    }
}

- (void)regitserAsObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self
               selector:@selector(configureViews)
                   name:ThemeDidChangeNotification
                 object:nil];
}

- (void)unregisterAsObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self];
}

#pragma mark - setter & getter

/// backgroundColorKey

- (NSString *)backgroundColorKey {
    return objc_getAssociatedObject(self, &KBackgroundColor);
}

- (void)setBackgroundColorKey:(NSString *)backgroundColorKey {
    objc_setAssociatedObject(self, &KBackgroundColor, backgroundColorKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self regitserAsObserver];
    [self configureViews];
}


/// textColorKey

- (NSString *)textColorKey {
    return objc_getAssociatedObject(self, &KTextColor);
}

- (void)setTextColorKey:(NSString *)textColorKey {
    objc_setAssociatedObject(self, &KTextColor, textColorKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self regitserAsObserver];
    [self configureViews];
}


/// fontKey

- (NSString *)fontKey {
    return objc_getAssociatedObject(self, &KFont);
}

- (void)setFontKey:(NSString *)fontKey {
    objc_setAssociatedObject(self, &KFont, fontKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self regitserAsObserver];
    [self configureViews];
}


/// imageKey

- (NSString *)imageKey {
    return objc_getAssociatedObject(self, &KImage);
}

- (void)setImageKey:(NSString *)imageKey {
    objc_setAssociatedObject(self, &KImage, imageKey, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self regitserAsObserver];
    [self configureViews];
}


@end
