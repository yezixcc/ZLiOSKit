//
//  UIViewController+HierarchyMethod.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (HierarchyMethod)

/// 获取当前控制器
- (UIViewController *)responseViewController;

@end

