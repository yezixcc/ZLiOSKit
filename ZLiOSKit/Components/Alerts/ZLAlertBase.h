//
//  ZLAlertBase.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/19.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *CANCELTITLE;
extern NSString *CONFIRMTITLE;
extern CGFloat MARGIN;
extern CGFloat MARGINCONTENT;
@interface ZLAlertBase : UIView

/// 自定义弹框视图
/// @param view 视图
+ (instancetype)alertWithView:(UIView *)view;

/// 自定义内容视图/按钮文案默认
/// @param view 视图
/// @param cancelBlock 取消回调
/// @param confirmBlock 确定回调
+ (instancetype)alertWithView:(UIView *)view
                  cancleBlock:(void(^)(void))cancelBlock
                 confirmBlock:(void(^)(void))confirmBlock;

/// 自定义内容视图
/// @param view 视图
/// @param cancelTitle 取消标题(左)
/// @param confirmTitle 确定标题(右)
/// @param cancelBlock 取消回调
/// @param confirmBlock 确定回调
+ (instancetype)alertWithView:(UIView *)view
                  cancelTitle:(NSString *)cancelTitle
                 confirmTitle:(NSString *)confirmTitle
                  cancleBlock:(void(^)(void))cancelBlock
                 confirmBlock:(void(^)(void))confirmBlock;

/// 自定义内容视图
/// @param view 视图 - (可传nil，实现setupContentView)
/// @param cancelTitle 取消标题(左)
/// @param confirmTitle 确定标题(右)
/// @param cancelBlock 取消回调
/// @param confirmBlock 确定回调
- (instancetype)initWithView:(UIView *)view
                 cancelTitle:(NSString *)cancelTitle
                confirmTitle:(NSString *)confirmTitle
                 cancleBlock:(void(^)(void))cancelBlock
                confirmBlock:(void(^)(void))confirmBlock;

/// 点击按钮自动关闭弹框
@property (nonatomic, assign) BOOL autoHidden;

/// 确定按钮文字颜色
@property (nonatomic, strong) UIColor *confirmTitleColor;

/// 取消按钮文字颜色
@property (nonatomic, strong) UIColor *cancelTitleColor;

/// 自定义视图
- (UIView *)setupHeader;
- (UIView *)setupContentView;
- (UIView *)setupFooter;

/// 更新数据
- (void)updateContents;

/// 显示
- (void)show;

/// 隐藏
- (void)hidden;

@end

