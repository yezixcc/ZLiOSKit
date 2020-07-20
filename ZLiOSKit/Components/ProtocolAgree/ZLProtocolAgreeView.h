//
//  ZLProtocolAgreeView.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/7/9.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLProtocolAgreeView;
@protocol ZLProtocolAgreeViewDelegate <NSObject>

@optional
/// 文案被点击
/// @param view 视图
/// @param text 被点击的文案
/// @param index 被点击文案在数组中的位置
- (void)zlProtocolAgreeView:(ZLProtocolAgreeView *)view
              didCickedText:(NSString *)text
                      index:(NSInteger)index;

/// 选中点击
/// @param view 视图
/// @param selected 选中
- (void)zlProtocolAgreeView:(ZLProtocolAgreeView *)view
                didSelected:(BOOL)selected;

@end

@interface ZLProtocolAgreeView : UIView

@property (nonatomic, copy) NSString *text; /// 文案
@property (nonatomic, copy) NSArray<NSString *> *linkTexts; /// 能点击的文案数组
@property (nonatomic, assign) BOOL selected;  /// 选中
@property (nonatomic, strong) UIColor *linkColor;   /// 链接文案颜色
@property (nonatomic, weak) id<ZLProtocolAgreeViewDelegate>delegate;    /// 代理

@end
