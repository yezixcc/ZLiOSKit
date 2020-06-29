//
//  ZLTableCellModel.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/5/25.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZLTableCellContainer;
typedef NS_ENUM(NSInteger, ZLTableCellStyle) {
    /// 标题(居左)
    ZLTableCellStyleTitle,
    /// 标题+子标题
    ZLTableCellStyleSubtitle,
    /// 标题+指示器
    ZLTableCellStyleIndicator,
    /// 标题(居中)
    ZLTableCellStyleCenterTitle,
    /// 标题+子标题+指示器(图片)
    ZLTableCellStyleSubtitleAndIndicator,
    /// 标题+内容
    ZLTableCellStyleCenterText,
    /// 标题+内容+指示器(图片)
    ZLTableCellStyleCenterTextAndIndicator,
    /// 标题+输入框
    ZLTableCellStyleTextField,
    /// 标题+输入框+指示器(图片)
    ZLTableCellStyleTextFieldAndIndicator,
    /// 标题+输入框+指示器(按钮)
    ZLTableCellStyleTextFieldAndIndicatorButton,
    /// 标题+输入框+指示器(编辑)
    ZLTableCellStyleTextFieldAndIndicatorEditButton,
    /// 标题+开关
    ZLTableCellStyleSwitch,
};

@interface ZLTableCellModel : NSObject

- (instancetype)initWithStyle:(ZLTableCellStyle)style;  /// 初始化
- (instancetype)initWithTitle:(NSString *)title
                        style:(ZLTableCellStyle)style;
- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        style:(ZLTableCellStyle)style;
- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                   centerText:(NSString *)centerText
                        style:(ZLTableCellStyle)style;
- (instancetype)initWithCenterTitle:(NSString *)centerTitle
                              style:(ZLTableCellStyle)style;

@property (nonatomic, copy) NSString *title;    /// 标题(左)
@property (nonatomic, copy) NSString *subTitle; /// 副标题(右)
@property (nonatomic, copy) NSString *centerTitle;  /// 中间标题
@property (nonatomic, copy) NSString *centerText;   /// 中间内容
@property (nonatomic, copy) NSString *textFieldPlacehold;   /// 输入提示
@property (nonatomic, copy) NSString *indicatorImageName;   /// 指示器图片名称
@property (nonatomic, copy) NSString *indicatorTitle;   /// 指示器文案
@property (nonatomic, assign) BOOL textFieldUnable;   /// 禁止输入
@property (nonatomic, assign) BOOL indicatorUnable;   /// 禁止点击
@property (nonatomic, assign) BOOL switchOn;   /// 是否打开
@property (nonatomic, assign) BOOL needCaptialText; /// 是否大写
@property (nonatomic, assign) BOOL hiddenLine;  /// 隐藏分隔线
@property (nonatomic, assign) ZLTableCellStyle style;   /// 样式
@property (nonatomic, weak) ZLTableCellContainer *cell; /// 视图

@end

