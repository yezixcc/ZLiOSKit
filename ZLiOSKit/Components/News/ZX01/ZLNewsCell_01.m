//
//  ZLNewsCell_01.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/7.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLNewsCell_01.h"
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

@interface ZLNewsCell_01 ()

@property (nonatomic, strong) ZLTagLabel *tagLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ZLNewsCell_01

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (self) {
        /// 创建UI
        [self.contentView addSubview:self.tagLabel];
        [self.tagLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tagLabel.superview);
            make.leading.equalTo(self.tagLabel.superview).offset(kPadding_Left);
            make.bottom.equalTo(self.contentLabel.superview).inset(kPadding_Inner).priority(750);
        }];
        [self.tagLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        [self.tagLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self.contentView addSubview:self.contentLabel];
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.tagLabel.mas_trailing).offset(6);
            make.trailing.equalTo(self.contentLabel.superview).inset(kPadding_Right);
            make.centerY.equalTo(self.tagLabel);
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
    [self reloadTitle:model.title
              tagText:model.tagText
             tagStyle:model.tagStyle];
}

- (void)reloadTitle:(NSString *)title
            tagText:(NSString *)tagText
           tagStyle:(ZLTagLabelStyle)style {
    self.contentLabel.text = title;
    self.tagLabel.text = tagText;
    self.tagLabel.style = style;
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

#pragma mark - getters - 控件

- (UILabel *)contentLabel {
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.fontKey = kFont_Text_Assist;
        _contentLabel.textColorKey = kTextColor_Minor;
    }
    return _contentLabel;
}

- (ZLTagLabel *)tagLabel {
    if (!_tagLabel) {
        _tagLabel = [[ZLTagLabel alloc] init];
    }
    return _tagLabel;
}

@end
