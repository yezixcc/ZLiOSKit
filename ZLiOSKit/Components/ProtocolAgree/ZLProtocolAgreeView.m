//
//  ZLProtocolAgreeView.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/7/9.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLProtocolAgreeView.h"
#import <TTTAttributedLabel/TTTAttributedLabel.h>
#import <ZLTheme.h>
#import <Masonry/Masonry.h>
#import <ZLAlertMessage.h>

static NSString *INFO_CLICK_KEY = @"INFO_CLICK_KEY";
@interface ZLProtocolAgreeView ()<TTTAttributedLabelDelegate>

@property (nonatomic, strong) UIButton *selectButton;
@property (nonatomic, strong) TTTAttributedLabel *textLabel;

@end

@implementation ZLProtocolAgreeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.selectButton];
        [self.selectButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self);
            make.top.equalTo(self);
        }];
        [self.selectButton setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        
        [self addSubview:self.textLabel];
        [self.textLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(self.selectButton.mas_trailing).offset(6);
            make.top.bottom.equalTo(self).offset(3);
            make.trailing.equalTo(self);
        }];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    self.selectButton.selected = _selected;
}

- (void)setLinkTexts:(NSArray<NSString *> *)linkTexts {
    _linkTexts = linkTexts;
    [self setUpLink];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.textLabel.text = text;
    [self setUpLink];
}

- (void)setUpLink {
    if (_text.length == 0) {
        return;
    }
    if (_linkTexts.count == 0) {
        return;
    }
    
    for (NSString *linkInfo in self.linkTexts) {
        NSRange range = [_text rangeOfString:linkInfo];
        if (range.location != NSNotFound) {
            if (_linkColor) {
                self.textLabel.linkAttributes = @{(NSString *)kCTForegroundColorAttributeName: _linkColor};
                self.textLabel.activeLinkAttributes = @{(NSString *)kCTForegroundColorAttributeName: _linkColor};
            }
            [self.textLabel addLinkToTransitInformation:@{INFO_CLICK_KEY: linkInfo} withRange:range];
        }
    }
}

- (void)selectButtonAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.selected = sender.selected;
    if ([_delegate respondsToSelector:@selector(zlProtocolAgreeView:didSelected:)]) {
        [_delegate zlProtocolAgreeView:self didSelected:sender.selected];
    }
}

#pragma mark - <TTTAttributedLabelDelegate>
- (void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithTransitInformation:(NSDictionary *)components {
    NSString *text = components[INFO_CLICK_KEY];
    NSInteger index = [self.linkTexts indexOfObject:text];
    if ([_delegate respondsToSelector:@selector(zlProtocolAgreeView:didCickedText:index:)]) {
        [_delegate zlProtocolAgreeView:self didCickedText:text index:index];
    }
}


#pragma mark - 控件
- (UIButton *)selectButton {
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [_selectButton setImage:[UIImage imageNamed:@"queren"] forState:UIControlStateSelected];
        [_selectButton addTarget:self action:@selector(selectButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

- (TTTAttributedLabel *)textLabel {
    if (!_textLabel) {
        _textLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectZero];
        _textLabel.fontKey = kFont_Text_Assist;
        _textLabel.textColorKey = kTextColor_Assist;
        _textLabel.numberOfLines = 0;
        _textLabel.delegate = self;
        UIColor *clickColor = [ZLThemeManager colorForKey:kYellowColor];
        _textLabel.activeLinkAttributes = @{(NSString *)kCTForegroundColorAttributeName : clickColor};
        _textLabel.linkAttributes = @{(NSString *)kCTForegroundColorAttributeName : clickColor};
    }
    return _textLabel;
}

@end
