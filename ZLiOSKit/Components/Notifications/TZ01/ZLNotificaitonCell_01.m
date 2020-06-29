//
//  ZLNotificaitonCell_01.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/8.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLNotificaitonCell_01.h"
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

@interface ZLNotificaitonCell_01 ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation ZLNotificaitonCell_01

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.bgView];
        [self.bgView addSubview:self.titleLabel];
        [self.bgView addSubview:self.iconImageView];
        [self.iconImageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.iconImageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    }
    return self;
}

- (void)updateConstraints {
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.bgView.superview).inset(kPadding_Left);
        make.top.equalTo(self.bgView.superview).offset(kPadding_Top);
        make.bottom.equalTo(self.bgView.superview);
    }];
    [self.iconImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImageView.superview).offset(kPadding_Left);
        make.centerY.equalTo(self.titleLabel);
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.iconImageView.mas_trailing).offset(4);
        make.trailing.equalTo(self.titleLabel.superview).inset(kPadding_Right);
        make.top.bottom.equalTo(self.titleLabel.superview).inset(6);
    }];
    
    if (!self.model.title.length) {
        [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.bgView.superview);
        }];
        [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.titleLabel.superview);
        }];
    }
    [super updateConstraints];
}

- (void)reloadData:(ZLTableRowModel *)rowModel {
    if (![rowModel.data isKindOfClass:[ZLNewsModel class]]) {
        return;
    }
    self.rowModel = rowModel;
    self.model = (ZLNewsModel *)rowModel.data;
}

- (void)setModel:(ZLNewsModel *)model {
    _model = model;
    self.titleLabel.text = model.title;
    self.iconImageView.hidden = model.title.length == 0;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    id target = self.rowModel.target;
    SEL action = self.rowModel.action;
    BOOL isOk = target && action;
    isOk = isOk ? isOk && [target respondsToSelector:action] : isOk;
    if (isOk) {
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [target performSelector:action withObject:self.model];
    }
}

#pragma mark - getters - 控件

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColorKey = kNotColor_Main;
        _bgView.layer.cornerRadius = 15.f;
    }
    return _bgView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.fontKey = kFont_Text_Assist;
        _titleLabel.textColorKey = kTextColor_Minor;
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.imageKey = @"消息铃铛";
    }
    return _iconImageView;
}

@end
