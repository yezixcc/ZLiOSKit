//
//  ZLEmptyDataDefaultView.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/22.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLEmotionMapView.h"
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

@interface ZLEmotionMapView ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;

@end

@implementation ZLEmotionMapView

- (instancetype)initWithType:(ZLEmotionMapType)type {
    self = [super init];
    if (self) {
        [self comminit];
        self.type = type;
    }
    return self;
}

- (void)comminit {
    self.backgroundColorKey = kBackgroundColor;
    [self addSubview:self.contentView];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self);
        make.centerY.equalTo(self).offset(-50);
    }];
    [self.contentView addSubview:self.imageView];
    [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.centerX.equalTo(self.contentView);
    }];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.subTitleLabel];
}

- (void)updateConstraints {
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView).inset(20);
        make.top.equalTo(self.imageView.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
    }];
    [self.subTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView).inset(20);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.centerX.equalTo(self.contentView);
    }];
    if (self.subtitle.length) {
        [self.subTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
        }];
    }else {
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.contentView);
        }];
    }
    [super updateConstraints];
}

#pragma mark - set

- (void)setType:(ZLEmotionMapType)type {
    _type = type;
    if (type == ZLEmotionMapTypeEmptyDefault) {
        self.imageName = @"icon_page_empty";
        self.title = @"暂无数据";
        self.subtitle = nil;
    }else if (type == ZLEmotionMapTypeErrorDefault) {
        self.imageName = @"icon_page_fail";
        self.title = @"网络加载失败";
        self.subtitle = @"请点击空白区域重试";
    }
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)setSubtitle:(NSString *)subtitle {
    _subtitle = subtitle;
    self.subTitleLabel.text = subtitle;
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.imageView.image = [UIImage imageNamed:_imageName];
}

#pragma mark - touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    !_didClickView ? : _didClickView();
}

#pragma mark - getters - 控件

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.fontKey = kFont_Text_Nor;
        _titleLabel.textColorKey = kTextColor_Assist;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc] init];
        _subTitleLabel.fontKey = kFont_Text_Nor;
        _subTitleLabel.textColorKey = kTextColor_Assist;
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.numberOfLines = 0;
    }
    return _subTitleLabel;
}

@end
