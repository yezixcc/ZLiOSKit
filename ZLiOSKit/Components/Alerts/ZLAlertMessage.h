//
//  ZLAlertMessage.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/23.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLAlertBase.h"

@interface ZLAlertMessage : ZLAlertBase

/// 标题/确定
/// @param title 标题
/// @param confirmBlock 确定回调
+ (instancetype)alertWithTitle:(NSString *)title
                  confirmBlock:(void(^)(void))confirmBlock;

/// 标题/取消/确定
/// @param title 标题
/// @param cancelBlock 取消
/// @param confirmBlock 确定
+ (instancetype)alertWithTitle:(NSString *)title
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock;

/// 标题/内容
/// @param title 标题
/// @param message 内容
/// @param confirmBlock 确定
+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message
                  confirmBlock:(void(^)(void))confirmBlock;

/// 标题/内容/取消/确定
/// @param title 标题
/// @param message 内容
/// @param cancelBlock 取消
/// @param confirmBlock 确定
+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock;

/// 标题/图片/内容/取消/确定
/// @param title 标题
/// @param image 图片
/// @param message 内容
/// @param cancelBlock 取消
/// @param confirmBlock 确定
+ (instancetype)alertWithTitle:(NSString *)title
                         image:(UIImage *)image
                       message:(NSString *)message
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock;

/// 图片/内容/取消/确定
/// @param image 图片
/// @param message 内容
/// @param cancelBlock 取消
/// @param confirmBlock 确定
+ (instancetype)alertWithImage:(UIImage *)image
                       message:(NSString *)message
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock;

/// 标题/图片/内容/左按钮文案/有按钮文案
/// @param title 标题
/// @param image 图片
/// @param message 内容
/// @param cancelTitle 取消标题(左)
/// @param confirmTitle 确认标题(右)
/// @param cancelBlock 取消回调
/// @param confirmBlock 确定回调
+ (instancetype)alertWithTitle:(NSString *)title
                         image:(UIImage *)image
                       message:(NSString *)message
                   cancelTitle:(NSString *)cancelTitle
                  confirmTitle:(NSString *)confirmTitle
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock;

/// 标题颜色
@property (nonatomic, strong) UIColor *titleColor;
/// 超链接文字颜色
@property (nonatomic, strong) UIColor *linkColor;
/// 带超链接的文案
@property (nonatomic, copy) NSArray<NSString *> *linkInfos;

/// 点击链接
@property (nonatomic, copy) void(^linkDidClicked)(NSString *string, NSInteger index);

@end

