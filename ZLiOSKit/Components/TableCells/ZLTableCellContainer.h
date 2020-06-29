//
//  ZLTableCellContainer.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/8.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTableCellModel.h"

@class ZLTableCellContainer;
@protocol ZLTableCellContainerDelegate <NSObject>
@optional
/// 点击cell
/// @param cell cell
- (void)zlTableCellContainerDidClicked:(ZLTableCellContainer *)cell;

/// 点击副标题
/// @param cell cell
/// @param subTitleLabel 副标题
- (void)zlTableCellContainer:(ZLTableCellContainer *)cell
          subTitleDidClicked:(UILabel *)subTitleLabel;

/// 点击指示器
/// @param cell cell
/// @param indicator 指示器
- (void)zlTableCellContainer:(ZLTableCellContainer *)cell
         indicatorDidClicked:(UIButton *)indicator;

/// 输入框允许编辑
/// @param cell cell
/// @param textField 输入框
- (BOOL)zlTableCellContainer:(ZLTableCellContainer *)cell
 textFieldShouldBeginEditing:(UITextField *)textField;

/// 输入框开始编辑
/// @param cell cell
/// @param textField 输入框
- (void)zlTableCellContainer:(ZLTableCellContainer *)cell
    textFieldDidBeginEditing:(UITextField *)textField;

/// 输入框正在编辑
/// @param cell cell
/// @param textField 输入框
- (void)zlTableCellContainer:(ZLTableCellContainer *)cell
     textFieldTextDidChanged:(UITextField *)textField;

/// 输入框结束编辑
/// @param cell cell
/// @param textField 输入框
- (void)zlTableCellContainer:(ZLTableCellContainer *)cell
      textFieldDidEndEditing:(UITextField *)textField;

@end


@interface ZLTableCellContainer : UIView
/// 初始化
/// @param style 样式
- (instancetype)initWithStyle:(ZLTableCellStyle)style;
@property (nonatomic, strong) ZLTableCellModel *model;  /// 数据源
@property (nonatomic, weak) id<ZLTableCellContainerDelegate>delegate;   /// 代理
@property (nonatomic, strong) UILabel *titleLabel;  /// 标题(左)
@property (nonatomic, strong) UILabel *subTitleLabel;   /// 副标题(右)
@property (nonatomic, strong) UILabel *centerTitleLabel;    /// 中间标题
@property (nonatomic, strong) UILabel *centerTextLabel; /// 中间内容
@property (nonatomic, strong) UITextField *textField;   /// 输入框
@property (nonatomic, strong) UIImageView *indicatorImageView;  /// 指示器
@property (nonatomic, strong) UIButton *indicatorButton;    /// 指示器
@property (nonatomic, strong) UISwitch *switchControl;  /// 开关
@property (nonatomic, strong) UIView *separateLine; /// 分割线

@end
