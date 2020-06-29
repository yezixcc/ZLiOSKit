//
//  ZLMenuItemModel.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/18.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZLMenuItemCellModel : NSObject

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon;
@property (nonatomic, copy) NSString *title;    /// 标题
@property (nonatomic, copy) NSString *icon; /// 图标
@property (nonatomic, copy) NSString *titleColorKey;    /// 标题颜色
@property (nonatomic, strong) UIColor *titleColor;  /// 标题颜色
@property (nonatomic, assign) NSInteger _id;    /// 标识

@end

