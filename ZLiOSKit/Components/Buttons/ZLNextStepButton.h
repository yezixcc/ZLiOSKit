//
//  ZLNextStepButton.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/5/11.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLNextStepButtonStateSource <NSObject>

@optional
/**
 按钮使能
 可以在此返回按钮使能条件
 */
- (BOOL)zlNextStepButtonEnabale;

@end


typedef NS_ENUM(NSInteger, ZLNextStepButtonStyle) {
    /// 方形，左右间距父视图为0
    ZLNextStepButtonStyleSquare,
    /// 圆角形，左右间距父视图16
    ZLNextStepButtonStyleCircle,
    /// 半圆角形，左右间距父视图16
    ZLNextStepButtonStyleHalfCircle,
};


@interface ZLNextStepButton : UIButton

/**
 当按钮使能需要和输入框的内容是否为空绑定时，可以传入关联的UITextField
 无需再实现代理方法zlNextStepButtonEnabale进行控制
 */
@property (nonatomic, copy) NSArray<UITextField *> *textFields;

/// 初始化
/// @param style 样式
/// @param staSource 代理
- (instancetype)initWithStyle:(ZLNextStepButtonStyle)style
                  stateSource:(id<ZLNextStepButtonStateSource>)staSource;

/// 添加到父视图
/// 使用这个添加到父视图无需再设置左右间距
/// @param superView 父视图
- (void)addToSuperView:(UIView *)superView;

/// 主动刷新按钮状态
- (void)updateState;

@end
