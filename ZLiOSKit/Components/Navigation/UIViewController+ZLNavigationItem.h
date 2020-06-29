//
//  UIViewController+ZLNavigationItem.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/5/15.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ZLNavigationItem)

/// 禁止返回
/// 返回按钮隐藏，滑动返回手势失效
- (void)setupBackUnable;
/// 滑动返回手势失效
- (void)setupBackGestureUnabel;

/// 重置返回
/// @param aSelector 传nil默认执行pop 
- (void)setupBackItemAction:(SEL)aSelector;

/// 重置返回
/// @param aSelector 传nil默认执行pop
/// @param message 传值即弹框提示
- (void)setupBackItemAction:(SEL)aSelector
            popAlertMessage:(NSString *)message;



@end

