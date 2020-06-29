//
//  ZLGroupHeaderStyleCardView.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/1.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLGroupHeaderStyleCardView.h"
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

@interface ZLGroupHeaderStyleCardView ()

@property (nonatomic, assign) NSInteger rowCount;

@end

@implementation ZLGroupHeaderStyleCardView

- (instancetype)initWithStyle:(ZLCardGroupHeaderStyle)style {
    self = [super init];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setStyle:style];
        /// 点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSelf)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)setStyle:(ZLCardGroupHeaderStyle)style {
    if (_style != style) {
        _style = style;
        [self addSubview:self.titleLabel];
        [self addSubview:self.subTitleLabel];
        switch (style) {
            case ZLCardGroupHeaderStyleTitle: {
                [_imageView removeFromSuperview];
                [_arrowImageView removeFromSuperview];
                [_moreLabel removeFromSuperview];
                _imageView = nil;
                _arrowImageView = nil;
                _moreLabel = nil;
            }
                break;
            case ZLCardGroupHeaderStyleImageTitle: {
                [self addSubview:self.imageView];
                [_arrowImageView removeFromSuperview];
                [_moreLabel removeFromSuperview];
                _arrowImageView = nil;
                _moreLabel = nil;
            }
                break;
            case ZLCardGroupHeaderStyleTitleMore: {
                [self addSubview:self.moreLabel];
                [self addSubview:self.arrowImageView];
                [_imageView removeFromSuperview];
                _imageView = nil;
            }
                break;
            case ZLCardGroupHeaderStyleImageTitleMore: {
                [self addSubview:self.imageView];
                [self addSubview:self.moreLabel];
                [self addSubview:self.arrowImageView];
            }
                break;
            default:
                break;
        }
    }
}

- (void)updateConstraints {
    UIView *view = self;
    [_imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(view).inset(kPadding_Left);
        make.centerY.equalTo(self).offset(4);
    }];
    /// 水平不被拉伸
    [_imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    /// 水平不被压缩
    [_imageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    view = _imageView ? : self;
    CGFloat leftPadding = _imageView ? 8 : 0;
    [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(view.mas_trailing).offset(leftPadding);
        make.centerY.equalTo(self).offset(4);
    }];
    [_titleLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    
    [_subTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(_titleLabel.mas_trailing).offset(kPadding_Left);
        make.bottom.equalTo(_titleLabel).offset(-2);
        if (_moreLabel) {
            make.trailing.equalTo(_moreLabel.mas_leading).offset(-5).priority(750);
        }else {
            make.trailing.equalTo(self).inset(kPadding_Right).priority(750);
        }
    }];

    [_arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(self).inset(6);
        make.centerY.equalTo(self).offset(4);
    }];
    /// 水平不被拉伸
    [_arrowImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    /// 水平不被压缩
    [_arrowImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    [_moreLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.trailing.equalTo(_arrowImageView.mas_leading).priority(750);
        make.centerY.equalTo(self).offset(4);
    }];
    /// 水平不被拉伸
    [_moreLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    /// 水平不被压缩
    [_moreLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    [super updateConstraints];
}

- (void)reloadTitle:(NSString *)title
           subTitle:(NSString *)subTitle
       numberOfRows:(NSInteger)rows
           showMore:(BOOL)showMore {
    _titleLabel.text = title;
    _subTitleLabel.text = subTitle;
    _rowCount = rows;
    self.hidden = rows == 0; // 不存在该模块
    switch (self.style) { // 是否显示更多
        case ZLCardGroupHeaderStyleTitle:
            self.style = showMore ? ZLCardGroupHeaderStyleTitleMore : self.style;
            break;
        case ZLCardGroupHeaderStyleImageTitle:
            self.style = showMore ? ZLCardGroupHeaderStyleImageTitleMore : self.style;
            break;
        case ZLCardGroupHeaderStyleTitleMore:
            self.style = showMore ? self.style : ZLCardGroupHeaderStyleTitle;
            break;
        case ZLCardGroupHeaderStyleImageTitleMore:
            self.style = showMore ? self.style : ZLCardGroupHeaderStyleImageTitle;
            break;
        default:
            break;
    }
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)didClickSelf {
    if (self.didClickedBlock) {
        self.didClickedBlock(self);
    }
}

- (CGFloat)viewHeight {
    return _rowCount ? 58.0 : 0.0;
}

#pragma mark - getters - 控件

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.imageKey = @"组头图标";
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.fontKey = kFont_Title_Bold;
        _titleLabel.textColorKey = kTextColor_Main;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.fontKey = kFont_Text_Assist;
        _subTitleLabel.textColorKey = kTextColor_Tips;
    }
    return _subTitleLabel;
}

- (UILabel *)moreLabel {
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.text = @"更多";
        _moreLabel.fontKey = kFont_Text_Assist;
        _moreLabel.textColorKey = kTextColor_Assist;
        _moreLabel.textAlignment = NSTextAlignmentRight;
    }
    return _moreLabel;
}

- (UIImageView *)arrowImageView {
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.imageKey = @"指示器";
    }
    return _arrowImageView;
}

@end
