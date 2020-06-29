//
//  ZLMenuItemCell.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLMenuItemCell.h"
/// models
#import "ZLMenuItemCellModel.h"
/// Kits
#import <Masonry/Masonry.h>
#import "ZLTheme.h"

@implementation ZLMenuItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.iconImageView];
    [self zl_updateConstraints];
}

- (void)zl_updateConstraints {
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self.contentView);
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.contentView);
    }];
    [super updateConstraints];
}

- (void)setModel:(ZLMenuItemCellModel *)model {
    _model = model;
    self.iconImageView.imageKey = model.icon;
    self.titleLabel.text = model.title;
    if (model.titleColorKey) {
        self.titleLabel.textColorKey = model.titleColorKey;
    }else if (model.titleColor) {
        self.titleLabel.textColor = model.titleColor;
    }else {
        self.titleLabel.textColorKey = kTextColor_Main;
    }
    [self zl_updateConstraints];
}

#pragma mark - getters 控件

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.numberOfLines = 0;
        _titleLabel.fontKey = kFont_Text_Assist;
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}

@end
