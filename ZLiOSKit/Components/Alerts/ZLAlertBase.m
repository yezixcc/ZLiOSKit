//
//  ZLAlertBase.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/19.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLAlertBase.h"
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

@interface ZLAlertBase ()

@property (nonatomic, copy) NSString *confirmTitle; /// 确定按钮标题
@property (nonatomic, copy) NSString *cancelTitle;  /// 取消按钮标题
@property (nonatomic, strong) UIView *contentView;  /// 自定义内容视图
@property (nonatomic, copy) void(^cancelBlock)(void);   /// 取消回调
@property (nonatomic, copy) void(^confirmBlock)(void);  /// 确定回调

@property (nonatomic, strong) UIView *containerView;    /// 父视图
@property (nonatomic, strong) UIScrollView *containerScrollView;    /// 内容视图父视图
@property (nonatomic, strong) UIButton *cancelButton;   /// 取消按钮
@property (nonatomic, strong) UIButton *confirmButton;  /// 确定按钮

@end

NSString *CANCELTITLE = @"取消";
NSString *CONFIRMTITLE = @"确定";
CGFloat MARGIN = 30.f;
CGFloat MARGINCONTENT = 20.f;
@implementation ZLAlertBase

/// 自定义弹框视图
/// @param view 视图
+ (instancetype)alertWithView:(UIView *)view {
    return [self alertWithView:view cancelTitle:nil confirmTitle:nil cancleBlock:nil confirmBlock:nil];;
}

/// 自定义内容视图/按钮文案默认
/// @param view 视图
/// @param cancelBlock 取消回调
/// @param confirmBlock 确定回调
+ (instancetype)alertWithView:(UIView *)view
                  cancleBlock:(void(^)(void))cancelBlock
                 confirmBlock:(void(^)(void))confirmBlock {
    return [self alertWithView:view cancelTitle:CANCELTITLE confirmTitle:CONFIRMTITLE cancleBlock:cancelBlock confirmBlock:confirmBlock];
}

/// 自定义内容视图
/// @param view 视图
/// @param cancelTitle 取消标题(左)
/// @param confirmTitle 确认标题(右)
/// @param cancelBlock 取消回调
/// @param confirmBlock 确认回调
+ (instancetype)alertWithView:(UIView *)view
                   cancelTitle:(NSString *)cancelTitle
                 confirmTitle:(NSString *)confirmTitle
                  cancleBlock:(void(^)(void))cancelBlock
                 confirmBlock:(void(^)(void))confirmBlock {
    ZLAlertBase *alert = [[ZLAlertBase alloc] initWithView:view cancelTitle:cancelTitle confirmTitle:confirmTitle cancleBlock:cancelBlock confirmBlock:confirmBlock];
    return alert;
}

- (instancetype)initWithView:(UIView *)view
                 cancelTitle:(NSString *)cancelTitle
                confirmTitle:(NSString *)confirmTitle
                 cancleBlock:(void(^)(void))cancelBlock
                confirmBlock:(void(^)(void))confirmBlock {
    self = [super init];
    if (self) {
        _autoHidden = YES;
        _cancelTitle = cancelTitle;
        _confirmTitle = confirmTitle;
        _confirmBlock = confirmBlock;
        _cancelBlock = cancelBlock;
        _contentView = view;
    }
    return self;
}

/// 显示
- (void)show {
    if (!self.superview) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        self.frame = window.bounds;
        [window addSubview:self];
        [self setupViews];
        [self updateContents];
        [self updateContainerConstraints];
    }
    [self animationBegin];
    [UIView animateWithDuration:0.25f animations:^{
        [self animationEnd];
    }];
}

/// 隐藏
- (void)hidden {
    [self hideWithCompeltion:nil];
}

#pragma mark - 私有方法
- (void)hideWithCompeltion:(void(^)(void))completion {
    [UIView animateWithDuration:0.25f animations:^{
        [self animationBegin];
    } completion:^(BOOL finished) {
        if (completion) {
            completion();
        }
        [self removeFromSuperview];
    }];
}

- (void)animationBegin {
    self.alpha = 0.f;
    self.containerView.transform = CGAffineTransformMakeScale(0.01, 0.01);
}
- (void)animationEnd {
    self.alpha = 1.f;
    self.containerView.transform = CGAffineTransformIdentity;
}

- (void)setCancelTitleColor:(UIColor *)cancelTitleColor {
    _cancelTitleColor = cancelTitleColor;
    [_cancelButton setTitleColor:cancelTitleColor forState:UIControlStateNormal];
}

- (void)setConfirmTitleColor:(UIColor *)confirmTitleColor {
    _confirmTitleColor = confirmTitleColor;
    [_confirmButton setTitleColor:confirmTitleColor forState:UIControlStateNormal];
}

#pragma mark - 创建视图
- (void)setupViews {
    UIControl *cover = [[UIControl alloc] initWithFrame:self.bounds];
    cover.backgroundColor = [UIColor blackColor];
    cover.alpha = 0.6;
    [cover addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cover];
    
    /// 上
    UIView *header = [self setupHeader] ? : [UIView new];
    [self.containerView addSubview:header];
    [header mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.leading.trailing.equalTo(header.superview);
    }];
    
    /// 中 -- 有传view就用view
    [self.containerView addSubview:self.containerScrollView];
    [self.containerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.containerScrollView.superview).inset(MARGINCONTENT);
        make.top.equalTo(header.mas_bottom).offset(MARGINCONTENT);
    }];
    UIView *contentView = self.contentView ? : ([self setupContentView] ? : [UIView new]);
    [self.containerScrollView addSubview:contentView];
    [contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(contentView.superview);
        make.leading.trailing.equalTo(self.containerView).inset(MARGINCONTENT);
    }];
    self.contentView = contentView;

    /// 下
    UIView *footer = [self setupFooter] ? : [UIView new];
    [self.containerView addSubview:footer];
    [footer mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(footer.superview);
        make.top.equalTo(self.containerScrollView.mas_bottom).offset(MARGINCONTENT);
    }];
}

- (UIView *)setupContentView {
    return nil;
}

- (UIView *)setupHeader {
    return nil;
}

- (UIView *)setupFooter {
    UIView *footer = [[UIView alloc] init];
    // 两个按钮
    if (_cancelTitle && _confirmTitle) {
        UIView *horLine = [self line];
        [footer addSubview:horLine];
        [horLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(horLine.superview);
            make.height.mas_equalTo(0.5);
        }];

        UIButton *cancelButton = [self tempCancelButton];
        [footer addSubview:cancelButton];
        [cancelButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(horLine.mas_bottom);
            make.leading.bottom.equalTo(cancelButton.superview);
            make.trailing.equalTo(cancelButton.superview.mas_centerX);
            make.height.mas_equalTo(44);
        }];

        UIButton *confirmButton = [self tempConfirmButton];
        [footer addSubview:confirmButton];
        [confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.height.equalTo(confirmButton);
            make.trailing.bottom.equalTo(confirmButton.superview);
            make.leading.equalTo(confirmButton.superview.mas_centerX);
            make.height.equalTo(cancelButton);
        }];

        UIView *verLine = [self line];
        [footer addSubview:verLine];
        [verLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(confirmButton);
            make.centerX.equalTo(verLine.superview);
            make.width.mas_equalTo(0.5);
        }];

    }
    // 一个按钮
    else if (_confirmTitle) {
        UIView *horLine = [self line];
        [footer addSubview:horLine];
        [horLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.leading.trailing.equalTo(horLine.superview);
            make.height.mas_equalTo(0.5);
        }];

        UIButton *confirmButton = [self tempConfirmButton];
        [footer addSubview:confirmButton];
        [confirmButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(horLine.mas_bottom);
            make.leading.trailing.bottom.equalTo(confirmButton.superview);
            make.height.mas_equalTo(44);
        }];
    }
    return footer;
}

- (void)updateContents {
    [_confirmButton setTitle:_confirmTitle forState:UIControlStateNormal];
    [_cancelButton setTitle:_cancelTitle forState:UIControlStateNormal];
}

- (void)updateContainerConstraints {
    [self layoutIfNeeded];
    CGFloat height = self.contentView.frame.size.height;
    height = MIN(300, height);
    [self.containerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
}


#pragma mark - actions
- (void)cancelAction {
    if (_autoHidden) {
        [self hideWithCompeltion:_cancelBlock];
    }else {
        !_cancelBlock ? : _cancelBlock();
    }
}

- (void)confirmAction {
    if (_autoHidden) {
        [self hideWithCompeltion:_confirmBlock];
    }else {
        !_confirmBlock ? : _confirmBlock();
    }
}

#pragma mark - getters

- (UIButton *)tempCancelButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.fontKey = kFont_Title_Nor;
    [button setTitleColor:[ZLThemeManager colorForKey:kTextColor_Assist] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    _cancelButton = button;
    return button;
}

- (UIButton *)tempConfirmButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.fontKey = kFont_Title_Nor;
    [button setTitleColor:[ZLThemeManager colorForKey:kThemeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    _confirmButton = button;
    return button;
}

- (UIView *)line {
    UIView *line = [[UIView alloc] init];
    line.backgroundColorKey = kSeparateLineColor;
    return line;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 8;
        _containerView.clipsToBounds = YES;
        [self addSubview:_containerView];
        [_containerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self).inset(MARGIN);
            make.centerY.equalTo(self);
        }];
    }
    return _containerView;
}

- (UIScrollView *)containerScrollView {
    if (!_containerScrollView) {
        _containerScrollView = [[UIScrollView alloc] init];
    }
    return _containerScrollView;
}

@end
