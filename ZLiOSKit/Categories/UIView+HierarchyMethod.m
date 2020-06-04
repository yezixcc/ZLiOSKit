//
//  UIViewController+HierarchyMethod.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "UIView+HierarchyMethod.h"

@implementation UIView (HierarchyMethod)

- (UIViewController *)responseViewController {
    UIViewController *controller = nil;
    if ([self.nextResponder isKindOfClass:[UIViewController class]]) {
        controller = (UIViewController *)self.nextResponder;
    }else {
        for (UIView *next = [self superview]; next; next = next.superview) {
            UIResponder *nextResponder = [next nextResponder];
            if ([nextResponder isKindOfClass:[UIViewController class]]) {
                controller = (UIViewController *)nextResponder;
                break;
            }
        }
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        return ((UINavigationController *)controller).topViewController;
    }else {
        return controller;
    }
}


@end
