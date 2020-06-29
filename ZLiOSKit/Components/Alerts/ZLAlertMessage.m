//
//  ZLAlertMessage.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/23.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLAlertMessage.h"
#import "ZLTheme.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import <Masonry/Masonry.h>

@interface ZLAlertMessage ()<TTTAttributedLabelDelegate>

@property (nonatomic, copy) NSString *title;    /// 标题
@property (nonatomic, copy) NSString *message;  /// 内容
@property (nonatomic, strong) UIImage *image;   /// 图标

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TTTAttributedLabel *messageLabel;
@property (nonatomic, strong) UIImageView *imageView;

@end

static NSString *INFO_CLICK_KEY = @"INFO_CLICK_KEY";
@implementation ZLAlertMessage

/// 标题/确定
+ (instancetype)alertWithTitle:(NSString *)title
                  confirmBlock:(void(^)(void))confirmBlock {
    return [self alertWithTitle:title image:nil message:nil cancelTitle:nil confirmTitle:CONFIRMTITLE cancleBlock:nil confirmBlock:confirmBlock];
}

/// 标题/取消/确定
+ (instancetype)alertWithTitle:(NSString *)title
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock {
    return [self alertWithTitle:title image:nil message:nil cancelTitle:CANCELTITLE confirmTitle:CONFIRMTITLE cancleBlock:cancelBlock confirmBlock:confirmBlock];
}

/// 标题/内容
+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message
                  confirmBlock:(void(^)(void))confirmBlock {
    return [self alertWithTitle:title image:nil message:message cancelTitle:nil confirmTitle:CONFIRMTITLE cancleBlock:nil confirmBlock:confirmBlock];
}

/// 标题/内容/取消/确定
+ (instancetype)alertWithTitle:(NSString *)title
                       message:(NSString *)message
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock {
    return [self alertWithTitle:title image:nil message:message cancelTitle:CANCELTITLE confirmTitle:CONFIRMTITLE cancleBlock:cancelBlock confirmBlock:confirmBlock];
}

/// 标题/图片/内容/取消/确定
+ (instancetype)alertWithTitle:(NSString *)title
                         image:(UIImage *)image
                       message:(NSString *)message
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock {
    return [self alertWithTitle:title image:image message:message cancelTitle:CANCELTITLE confirmTitle:CONFIRMTITLE cancleBlock:cancelBlock confirmBlock:confirmBlock];
}

/// 图片/内容/取消/确定
+ (instancetype)alertWithImage:(UIImage *)image
                       message:(NSString *)message
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock {
    return [self alertWithTitle:nil image:image message:message cancelTitle:CANCELTITLE confirmTitle:CONFIRMTITLE cancleBlock:cancelBlock confirmBlock:confirmBlock];
}

/// 标题/图片/内容/左按钮文案/有按钮文案
/// @param title 标题
/// @param message 内容
/// @param cancelTitle 取消标题(左)
/// @param confirmTitle 确认标题(右)
/// @param cancelBlock 取消回调
/// @param confirmBlock 确认回调
+ (instancetype)alertWithTitle:(NSString *)title
                         image:(UIImage *)image
                       message:(NSString *)message
                   cancelTitle:(NSString *)cancelTitle
                  confirmTitle:(NSString *)confirmTitle
                   cancleBlock:(void(^)(void))cancelBlock
                  confirmBlock:(void(^)(void))confirmBlock {
    ZLAlertMessage *alert = [[ZLAlertMessage alloc] initWithTitle:title message:message image:image cancelTitle:cancelTitle confirmTitle:confirmTitle cancleBlock:cancelBlock confirmBlock:confirmBlock];
    return alert;
}

- (instancetype)initWithTitle:(NSString *)title
                      message:(NSString *)message
                        image:(UIImage *)image
                  cancelTitle:(NSString *)cancelTitle
                 confirmTitle:(NSString *)confirmTitle
                  cancleBlock:(void(^)(void))cancelBlock
                 confirmBlock:(void(^)(void))confirmBlock {
    self = [super initWithView:nil cancelTitle:cancelTitle confirmTitle:confirmTitle cancleBlock:cancelBlock confirmBlock:confirmBlock];
    if (self) {
        _title = title;
        _message = message;
        _image = image;
    }
    return self;
}

#pragma mark - 自定义视图
- (void)updateContents {
    [super updateContents];
    _titleLabel.text = _title;
    _messageLabel.text = _message;
    _imageView.image = _image;
    _titleLabel.textColor = _titleColor ? : _titleLabel.textColor;
    // 超链接
    for (NSString *linkInfo in self.linkInfos) {
        NSRange range = [_message rangeOfString:linkInfo];
        if (range.location != NSNotFound) {
            if (_linkColor) {
                _messageLabel.linkAttributes = @{(NSString *)kCTForegroundColorAttributeName: _linkColor};
                _messageLabel.activeLinkAttributes = @{(NSString *)kCTForegroundColorAttributeName: _linkColor};
            }
            [_messageLabel addLinkToTransitInformation:@{INFO_CLICK_KEY: linkInfo} withRange:range];
        }
    }
}

/// 标题
- (UIView *)setupHeader {
    UIView *header = [UIView new];
    // 没有标题
    if (!_title) {
        return header;
    }
    // 标题/内容、标题/图片
    if (_message || _image) {
        UILabel *titleLabel = [self tempTitleLabel];
        [header addSubview:titleLabel];
        [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(header).inset(14);
            make.leading.trailing.equalTo(header).inset(MARGINCONTENT);
        }];
        
        UIView *line = [[UIView alloc] init];
        line.backgroundColorKey = kSeparateLineColor;
        [header addSubview:line];
        [line mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(header);
            make.height.mas_equalTo(0.5);
        }];
        return header;
    }
    return header;
}

/// 内容
- (UIView *)setupContentView {
    UIView *view = [[UIView alloc] init];
    /// 只有标题
    if (_title && !_image && !_message) {
        UILabel *titleLabel = [self tempTitleLabel];
        [view addSubview:titleLabel];
        [titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.leading.trailing.equalTo(view);
        }];
    }
    /// 只有内容
    else if (_message && !_image) {
        UILabel *messageLabel = [self tempMessageLabel];
        [view addSubview:messageLabel];
        [messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.leading.trailing.equalTo(view);
        }];
    }
    /// 图片/内容
    else {
        UIImageView *imageView = [self tempImageView];
        [view addSubview:imageView];
        [imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(imageView.superview).offset(MARGINCONTENT);
            make.centerX.equalTo(imageView.superview);
        }];
        
        UILabel *messageLabel = [self tempMessageLabel];
        [view addSubview:messageLabel];
        [messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(messageLabel.superview);
            make.top.equalTo(imageView.mas_bottom).offset(MARGINCONTENT);
            make.bottom.equalTo(messageLabel.superview);
        }];
    }
    return view;
}

#pragma mark - <TTTAttributedLabelDelegate>
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    NSString *text = components[INFO_CLICK_KEY];
    NSInteger index = [self.linkInfos indexOfObject:text];
    if (self.linkDidClicked) {
        self.linkDidClicked(text, index);
    }
}

#pragma mark - 控件
- (UILabel *)tempTitleLabel {
    UILabel *label = [[UILabel alloc] init];
    label.fontKey = kFont_Title_Nor;
    label.textColorKey = kTextColor_Main;
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    _titleLabel = label;
    return label;
}

- (TTTAttributedLabel *)tempMessageLabel {
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
    label.fontKey = kFont_Text_Nor;
    label.textColorKey = kTextColor_Main;
    label.numberOfLines = 0;
    label.delegate = self;
    label.numberOfLines = 0;
    //设置下划线
    label.linkAttributes = @{(NSString *)kCTUnderlineStyleAttributeName : @(NO)};
    //点击的颜色
    UIColor *clickColor = [ZLThemeManager colorForKey:kTextColor_Link];
    label.activeLinkAttributes = @{(NSString *)kCTForegroundColorAttributeName : clickColor};
    label.linkAttributes = @{(NSString *)kCTForegroundColorAttributeName : clickColor};
    _messageLabel = label;
    return label;
}

- (UIImageView *)tempImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    _imageView = imageView;
    return imageView;
}
@end
