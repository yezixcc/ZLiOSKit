//
//  ZLNewsCell_02.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/14.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLNewsCell_02.h"
#import "ZLTheme.h"
#import "ZLTableModel.h"
#import "ZLNewsModel.h"
#import <Masonry/Masonry.h>

@interface ZLNewsCell_02 ()
@property (nonatomic, strong) UILabel *infoTitleLabel;
@property (nonatomic, strong) UILabel *infoSourceLabe;
@property (nonatomic, strong) UILabel *infoTimeLabel;
@end

@implementation ZLNewsCell_02

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        /// 创建UI
        [self.contentView addSubview:self.infoTitleLabel];
        [self.infoTitleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.infoTitleLabel.superview).offset(kPadding_Top);
            make.leading.equalTo(self.infoTitleLabel.superview).inset(kPadding_Left);
            make.trailing.equalTo(self.infoTimeLabel.superview).inset(kPadding_Right);
        }];
        
        [self.contentView addSubview:self.infoSourceLabe];
        [self.infoSourceLabe mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.infoTitleLabel);
            make.top.equalTo(self.infoTitleLabel.mas_bottom).offset(4);
            make.bottom.equalTo(self.infoSourceLabe.superview).inset(kPadding_Top);
        }];
        
        [self.contentView addSubview:self.infoTimeLabel];
        [self.infoTimeLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.infoSourceLabe.mas_trailing).offset(12);
            make.centerY.equalTo(self.infoSourceLabe);
        }];
        
        [self.contentView addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.separateLine.superview).offset(kPadding_Left);
            make.trailing.equalTo(self.separateLine.superview).inset(kPadding_Right);
            make.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
        /// 点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSelf)];
        [self.contentView addGestureRecognizer:tap];
    }
    return self;
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
    [self reloadInfoTitle:model.title source:model.source time:model.pubTime];
}

- (void)reloadInfoTitle:(NSString *)title
                 source:(NSString *)source
                   time:(NSString *)time {
    self.infoTitleLabel.text = title;
    self.infoSourceLabe.text = source;
    self.infoTimeLabel.text = time;
}

- (void)didClickSelf {
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

#pragma mark - getters

- (UILabel *)infoTitleLabel {
    if (!_infoTitleLabel) {
        _infoTitleLabel = [[UILabel alloc] init];
        _infoTitleLabel.fontKey = kFont_Text_Nor;
        _infoTitleLabel.textColorKey = kTextColor_Main;
        _infoTitleLabel.numberOfLines = 2;
    }
    return _infoTitleLabel;
}

- (UILabel *)infoSourceLabe {
    if (!_infoSourceLabe) {
        _infoSourceLabe = [[UILabel alloc] init];
        _infoSourceLabe.fontKey = kFont_Text_Assist;
        _infoSourceLabe.textColorKey = kTextColor_Assist;
    }
    return _infoSourceLabe;
}

- (UILabel *)infoTimeLabel {
    if (!_infoTimeLabel) {
        _infoTimeLabel = [[UILabel alloc] init];
        _infoTimeLabel.fontKey = kFont_Text_Assist;
        _infoTimeLabel.textColorKey = kTextColor_Assist;
    }
    return _infoTimeLabel;
}

@end
