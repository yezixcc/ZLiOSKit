//
//  ZLLinkLabel.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/8.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLLinkLabel.h"
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

@interface ZLLinkLabel ()
@property (nonatomic, strong) UIView *separate;
@end

@implementation ZLLinkLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.leftLabel];
        [self.leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.top.bottom.equalTo(self);
        }];
        
        [self addSubview:self.rightLabel];
        [self.rightLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.top.bottom.equalTo(self);
        }];
        
        [self addSubview:self.separate];
        [self.separate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.top.bottom.equalTo(self).inset(3);
            make.leading.equalTo(self.leftLabel.mas_trailing).inset(8);
            make.trailing.equalTo(self.rightLabel.mas_leading).inset(8);
            make.width.mas_equalTo(1);
        }];
    }
    return self;
}

- (void)setTextColorKey:(NSString *)textColorKey {
    _textColorKey = textColorKey;
    self.leftLabel.textColorKey = textColorKey;
    self.rightLabel.textColorKey = textColorKey;
    self.separate.backgroundColorKey = textColorKey;
}

- (void)leftLabelAction {
    if (self.leftLabelDidClicked) {
        self.leftLabelDidClicked();
    }
}

- (void)rightLabelAction {
    if (self.rightLabelDidClicked) {
        self.rightLabelDidClicked();
    }
}

- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.fontKey = kFont_Text_Minor;
        _leftLabel.textColorKey = kThemeColor;
        _leftLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(leftLabelAction)];
        [_leftLabel addGestureRecognizer:tap];
    }
    return _leftLabel;
}

- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.fontKey = kFont_Text_Minor;
        _rightLabel.textColorKey = kThemeColor;
        _rightLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(rightLabelAction)];
        [_rightLabel addGestureRecognizer:tap];
    }
    return _rightLabel;
}

- (UIView *)separate {
    if (!_separate) {
        _separate = [[UIView alloc] init];
        _separate.backgroundColorKey = kThemeColor;
    }
    return _separate;
}

@end
