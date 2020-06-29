//
//  ZLGroupHeaderStyleCardView.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/1.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZLCardGroupHeaderStyle) {
    ZLCardGroupHeaderStyleTitle = 1,    /// 标题
    ZLCardGroupHeaderStyleImageTitle,   /// 图标+标题
    ZLCardGroupHeaderStyleTitleMore,    /// 标题+更多
    ZLCardGroupHeaderStyleImageTitleMore,   /// 图标+标题+更多
};

@interface ZLGroupHeaderStyleCardView : UIView

/// 点击事件
@property (nonatomic, copy) void(^didClickedBlock)(ZLGroupHeaderStyleCardView *view);

/// 实例化
/// @param style 样式
- (instancetype)initWithStyle:(ZLCardGroupHeaderStyle)style;

/// 刷新标题
/// row == 0 高度返回0，该模块隐藏
/// @param title 标题
/// @param subTitle 副标题
/// @param rows 该组有多少条数据
/// @param showMore 是否显示更多
- (void)reloadTitle:(NSString *)title
           subTitle:(NSString *)subTitle
       numberOfRows:(NSInteger)rows
           showMore:(BOOL)showMore;

/// 高度
- (CGFloat)viewHeight;

/// 属性
/// 样式
@property (nonatomic, assign) ZLCardGroupHeaderStyle style;

/// 控件
/// 标题前的图标
@property (nonatomic, strong) UIImageView *imageView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 副标题
@property (nonatomic, strong) UILabel *subTitleLabel;
/// 更多
@property (nonatomic, strong) UILabel *moreLabel;
/// 箭头图标
@property (nonatomic, strong) UIImageView *arrowImageView;


@end

