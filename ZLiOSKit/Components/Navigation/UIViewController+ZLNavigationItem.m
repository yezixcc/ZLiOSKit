//
//  UIViewController+ZLNavigationItem.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/5/15.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "UIViewController+ZLNavigationItem.h"
#import "ZLTheme.h"
#import "ZLAlertMessage.h"
#import <objc/runtime.h>

static void *KAlertMessage = &KAlertMessage;
static void *KBackAction = &KBackAction;
@implementation UIViewController (ZLNavigationItem)

/// 禁止返回
/// 返回按钮隐藏，滑动返回手势失效
- (void)setupBackUnable {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];
    [self setupBackGestureUnabel];
}

/// 滑动返回手势失效
- (void)setupBackGestureUnabel {
    id traget = self.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:traget action:nil];
    [self.view addGestureRecognizer:pan];
}

/// 重置返回
/// @param aSelector 传nil默认执行pop
- (void)setupBackItemAction:(SEL)aSelector {
    [self setupBackItemAction:aSelector popAlertMessage:nil];
}
- (void)setupBackItemAction:(SEL)aSelector
            popAlertMessage:(NSString *)message {
    [self setASelectorString:NSStringFromSelector(aSelector)];
    [self setPopAlertMessage:message];
    UIImage *image = [[ZLThemeManager imageForImageName:@"返回"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(backgroundColor)];
    self.navigationController.navigationItem.leftBarButtonItem = backItem;
}

#pragma mark - functions
- (void)backAction {
    [self.view endEditing:YES];
    NSString *message = [self popAlertMessage];
    NSString *aSelector = [self aSelectorString];
    if (message.length) {   /// 有返回弹框
        __weak typeof(self) weakeSelf = self;
        ZLAlertMessage *alert = [ZLAlertMessage alertWithTitle:message confirmBlock:^{
            if (aSelector && [weakeSelf respondsToSelector:NSSelectorFromString(aSelector)]) {
                SEL selector = NSSelectorFromString(aSelector);
                #pragma clang diagnostic push
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [weakeSelf performSelector:selector];
                #pragma clang diagnostic pop
            }else {
                [weakeSelf.navigationController popViewControllerAnimated:YES];
            }
        }];
        [alert show];
    }else if (aSelector && [self respondsToSelector:NSSelectorFromString(aSelector)]) {
        SEL selector = NSSelectorFromString(aSelector);
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:selector];
        #pragma clang diagnostic pop
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - setter & getter
- (NSString *)aSelectorString {
    return objc_getAssociatedObject(self, &KBackAction);
}
- (void)setASelectorString:(NSString *)aSelectorString {
    objc_setAssociatedObject(self, &KBackAction, aSelectorString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)popAlertMessage {
    return objc_getAssociatedObject(self, &KAlertMessage);
}
- (void)setPopAlertMessage:(NSString *)popAlertMessage {
    objc_setAssociatedObject(self, &KAlertMessage, popAlertMessage, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
