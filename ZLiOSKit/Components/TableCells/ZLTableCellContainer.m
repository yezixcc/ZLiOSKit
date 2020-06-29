//
//  ZLTableCellContainer.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/8.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLTableCellContainer.h"
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

@interface ZLTableCellContainer () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *titleContainer;   /// 标题(居左)
@property (nonatomic, strong) UIView *centerTitleContainer; ///标题(居中)
@property (nonatomic, strong) UIView *subtitleContainer;    ///标题+子标题
@property (nonatomic, strong) UIView *indicateContainer;    ///标题+指示器
@property (nonatomic, strong) UIView *subtitleAndIndicateContainer; ///标题+子标题+指示器
@property (nonatomic, strong) UIView *centerTextContainer; ///标题+内容
@property (nonatomic, strong) UIView *centerTextAndIndicateContainer; ///标题+内容+指示器
@property (nonatomic, strong) UIView *textFieldContainer;   ///标题+输入框
@property (nonatomic, strong) UIView *textFieldAndIndicateContainer; /// 标题+输入框+指示器
@property (nonatomic, strong) UIView *textFieldAndIndicateButtonContainer; /// 标题+输入框+指示器(按钮)
@property (nonatomic, strong) UIView *textFieldAndIndicateEditButtonContainer; /// 标题+输入框+指示器(编辑)
@property (nonatomic, strong) UIView *switchContainer;  ///标题+开关
@property (nonatomic, assign) ZLTableCellStyle style;  /// 当前样式
@property (nonatomic, copy) NSString *tempPlacehold;   /// 输入提示

@end

@implementation ZLTableCellContainer

#pragma mark - inits
- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInitWithStyle:ZLTableCellStyleTitle];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInitWithStyle:ZLTableCellStyleTitle];
    }
    return self;
}
- (instancetype)initWithStyle:(ZLTableCellStyle)style {
    self = [super init];
    if (self) {
        [self commonInitWithStyle:style];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInitWithStyle:ZLTableCellStyleTitle];
    }
    return self;
}
- (void)commonInitWithStyle:(ZLTableCellStyle)style {
    self.backgroundColor = [UIColor whiteColor];
    ZLTableCellModel *model = [[ZLTableCellModel alloc] initWithStyle:style];
    self.model = model;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickCell)];
    [self addGestureRecognizer:tap];
}

#pragma mark - datas
- (void)setModel:(ZLTableCellModel *)model {
    if (_model != model) {
        _model = model;
        /// 创建UI
        [self updateStyle:model.style];
        /// 更新数据
        self.titleLabel.text = model.title;
        self.subTitleLabel.text = model.subTitle;
        self.centerTitleLabel.text = model.centerTitle;
        self.centerTextLabel.text = model.centerText;
        self.textField.placeholder = model.textFieldPlacehold;
        self.separateLine.hidden = model.hiddenLine;
        self.switchControl.on = model.switchOn;
        self.indicatorButton.userInteractionEnabled = !model.indicatorUnable;
        self.textField.userInteractionEnabled = !model.textFieldUnable;
        self.indicatorButton.imageKey = model.indicatorImageName;
        self.indicatorImageView.imageKey = model.indicatorImageName;
        [self.indicatorButton setTitle:model.indicatorTitle forState:UIControlStateNormal];
        /// 更新样式
        [self updateStyle:model.style];
    }
}

- (void)updateStyle:(ZLTableCellStyle)style {
    _style = style;
    for (UIView *containerView in [self allContainerViews]) {
        containerView.hidden = YES;
    }
    switch (style) {
        case ZLTableCellStyleTitle: /// 标题(居左)
            self.titleContainer.hidden = NO;
            break;
        case ZLTableCellStyleSubtitle: /// 标题+子标题
            self.subtitleContainer.hidden = NO;
            break;
        case ZLTableCellStyleIndicator: /// 标题+指示器
            self.indicateContainer.hidden = NO;
            break;
        case ZLTableCellStyleCenterTitle: /// 标题(居中)
            self.centerTitleContainer.hidden = NO;
            break;
        case ZLTableCellStyleSubtitleAndIndicator: /// 标题+子标题+指示器
            self.subtitleAndIndicateContainer.hidden = NO;
            break;
        case ZLTableCellStyleCenterText: /// 标题+内容+指示器
            self.centerTextContainer.hidden = NO;
            break;
        case ZLTableCellStyleCenterTextAndIndicator: /// 标题+内容+指示器
            self.centerTextAndIndicateContainer.hidden = NO;
            break;
        case ZLTableCellStyleTextField: /// 标题+输入框
            self.textFieldContainer.hidden = NO;
            break;
        case ZLTableCellStyleTextFieldAndIndicator: /// 标题+输入框+指示器
            self.textFieldAndIndicateContainer.hidden = NO;
            break;
        case ZLTableCellStyleTextFieldAndIndicatorButton: /// 标题+输入框+指示器(按钮)
            self.textFieldAndIndicateButtonContainer.hidden = NO;
            break;
        case ZLTableCellStyleTextFieldAndIndicatorEditButton: /// 标题+输入框+指示器(编辑)
            self.textFieldAndIndicateEditButtonContainer.hidden = NO;
            break;
        case ZLTableCellStyleSwitch: /// 标题+开关
            self.switchContainer.hidden = NO;
            break;
        default:
            break;
    }
}

- (void)setTempPlacehold:(NSString *)tempPlacehold {
    if (!tempPlacehold) {
        return;
    }
    _tempPlacehold = tempPlacehold;
}

#pragma mark - actions
/// 点击cell
- (void)didClickCell {
    if ([_delegate respondsToSelector:@selector(zlTableCellContainerDidClicked:)]) {
        [_delegate zlTableCellContainerDidClicked:self];
    }
}
/// 点击副标题
- (void)didClickSubTitle {
    if ([_delegate respondsToSelector:@selector(zlTableCellContainer:subTitleDidClicked:)]) {
        [_delegate zlTableCellContainer:self subTitleDidClicked:self.subTitleLabel];
    }
}
/// 点击指示器
- (void)didClickIndicator {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zlTableCellContainer:indicatorDidClicked:)]) {
        [self.delegate zlTableCellContainer:self indicatorDidClicked:self.indicatorButton];
    }
}
/// 输入框允许编辑
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(zlTableCellContainer:textFieldShouldBeginEditing:)]) {
        return [self.delegate zlTableCellContainer:self textFieldShouldBeginEditing:self.textField];
    }
    return YES;
}
/// 输入框正在编辑
- (void)textFieldTextDidChanged:(UITextField *)textField {
    NSString *text = textField.text;
    UITextRange *textRange = textField.selectedTextRange;
    if (self.model.needCaptialText) {
        text = [text uppercaseString];
    }
    if (textField.textAlignment == NSTextAlignmentRight) {
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@"\u00a0"];
        
    }
    textField.text = text;
    [textField setSelectedTextRange:textRange];
    self.model.centerText = text;
    if (self.delegate && [self.delegate respondsToSelector:@selector(zlTableCellContainer:textFieldTextDidChanged:)]) {
        [self.delegate zlTableCellContainer:self textFieldTextDidChanged:self.textField];
    }
}
/// 输入框开始编辑
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (_style == ZLTableCellStyleTextFieldAndIndicatorEditButton) {
        textField.text = self.centerTextLabel.text;
        self.model.centerText = nil;
        self.centerTextLabel.text = nil;
        self.tempPlacehold = textField.placeholder;
    }
    if ([_delegate respondsToSelector:@selector(zlTableCellContainer:textFieldDidBeginEditing:)]) {
        [_delegate zlTableCellContainer:self textFieldDidBeginEditing:textField];
    }
}
/// 输入框结束编辑
- (void)textFieldDidEndEditing:(UITextField *)textField {
    if (_style == ZLTableCellStyleTextFieldAndIndicatorEditButton) {
        self.model.centerText = textField.text;
        self.model.textFieldPlacehold = textField.placeholder;
        self.centerTextLabel.text = textField.text;
        textField.placeholder = textField.text.length ? nil : self.tempPlacehold;
        textField.text = nil;
    }
    if ([_delegate respondsToSelector:@selector(zlTableCellContainer:textFieldDidEndEditing:)]) {
        [_delegate zlTableCellContainer:self textFieldDidEndEditing:textField];
    }
}
/// 设置第一响应者
- (void)setTextFieldFirstResponder {
    [self.textField becomeFirstResponder];
}

#pragma mark - create UI
- (NSArray *)allContainerViews {
    NSMutableArray *all = [[NSMutableArray alloc] init];
    [all addObject:_titleContainer];
    [all addObject:_centerTitleContainer];
    [all addObject:_subtitleContainer];
    [all addObject:_indicateContainer];
    [all addObject:_subtitleAndIndicateContainer];
    [all addObject:_centerTextContainer];
    [all addObject:_centerTextAndIndicateContainer];
    [all addObject:_textFieldContainer];
    [all addObject:_textFieldAndIndicateContainer];
    [all addObject:_textFieldAndIndicateButtonContainer];
    [all addObject:_textFieldAndIndicateEditButtonContainer];
    [all addObject:_switchContainer];
    return all;
}

#pragma mark - 标题（居左）
- (UIView *)titleContainer {
    if (!_titleContainer) {
        _titleContainer = [[UIView alloc] init];
        [self addSubview:_titleContainer];
        [_titleContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_titleContainer.superview);
        }];
        
        UILabel *titLabel = [self titleTempLabel];
        [_titleContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.bottom.equalTo(titLabel.superview).inset(15);
        }];
        
        [_titleContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _titleContainer;
}

#pragma mark - 标题（居中）
- (UIView *)centerTitleContainer {
    if (!_centerTitleContainer) {
        _centerTitleContainer = [[UIView alloc] init];
        [self addSubview:_centerTitleContainer];
        [_centerTitleContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_centerTitleContainer.superview);
        }];
        
        UILabel *titLabel = [self centerTitleTempLabel];
        [_centerTitleContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.bottom.equalTo(titLabel.superview).inset(15);
        }];
        
        [_centerTitleContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _centerTitleContainer;
}


#pragma mark - 标题+子标题
- (UIView *)subtitleContainer {
    if (!_subtitleContainer) {
        _subtitleContainer = [[UIView alloc] init];
        [self addSubview:_subtitleContainer];
        [_subtitleContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_subtitleContainer.superview);
        }];
        
        UILabel *titLabel = [self titleTempLabel];
        [_subtitleContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.bottom.equalTo(titLabel.superview).inset(15);
        }];
        
        UILabel *subTitLabel = [self subTitleTempLabel];
        [_subtitleContainer addSubview:subTitLabel];
        [subTitLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(subTitLabel.superview).inset(kPadding_Left);
            make.centerY.equalTo(subTitLabel.superview);
        }];
        
        [_subtitleContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _subtitleContainer;
}

#pragma mark - 标题+指示器
- (UIView *)indicateContainer {
    if (!_indicateContainer) {
        _indicateContainer = [[UIView alloc] init];
        [self addSubview:_indicateContainer];
        [_indicateContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_indicateContainer.superview);
        }];
        
        UILabel *titLabel = [self titleTempLabel];
        [_indicateContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.bottom.equalTo(titLabel.superview).inset(15);
        }];
        
        UIImageView *indicate = [self indicatorTempImageView];
        [_indicateContainer addSubview:indicate];
        [indicate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(indicate.superview).inset(kPadding_Left);
            make.centerY.equalTo(indicate.superview);
        }];
        
        [_indicateContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _indicateContainer;
}

#pragma mark - 标题+子标题+指示器
- (UIView *)subtitleAndIndicateContainer {
    if (!_subtitleAndIndicateContainer) {
        _subtitleAndIndicateContainer = [[UIView alloc] init];
        [self addSubview:_subtitleAndIndicateContainer];
        [_subtitleAndIndicateContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_subtitleAndIndicateContainer.superview);
        }];
        
        UILabel *titLabel = [self titleTempLabel];
        [_subtitleAndIndicateContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.bottom.equalTo(titLabel.superview).inset(15);
        }];
        
        UIImageView *indicate = [self indicatorTempImageView];
        [_subtitleAndIndicateContainer addSubview:indicate];
        [indicate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(indicate.superview).inset(kPadding_Left);
            make.centerY.equalTo(indicate.superview);
        }];
        
        UILabel *subTitLabel = [self subTitleTempLabel];
        [_subtitleAndIndicateContainer addSubview:subTitLabel];
        [subTitLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(indicate.mas_leading).inset(kPadding_Left);
            make.centerY.equalTo(subTitLabel.superview);
        }];
        
        [_subtitleAndIndicateContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _subtitleAndIndicateContainer;
}

#pragma mark - 标题+输入框
- (UIView *)textFieldContainer {
    if (!_textFieldContainer) {
        _textFieldContainer = [[UIView alloc] init];
        [self addSubview:_textFieldContainer];
        [_textFieldContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_textFieldContainer.superview);
        }];
        
        CGFloat titleLabelWidth = 64.f;
        UILabel *titLabel = [self titleTempLabel];
        [_textFieldContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.bottom.equalTo(titLabel.superview).inset(15);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        
        UITextField *textField = [self centerTextTempTextField];
        [_textFieldContainer addSubview:textField];
        [textField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(textField.superview).offset(titleLabelWidth+10+kPadding_Left);
            make.centerY.equalTo(textField.superview);
            make.trailing.equalTo(textField.superview).inset(kPadding_Right);
        }];
        
        [_textFieldContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _textFieldContainer;
}

#pragma mark - 标题+内容
- (UIView *)centerTextContainer {
    if (!_centerTextContainer) {
        _centerTextContainer = [[UIView alloc] init];
        [self addSubview:_centerTextContainer];
        [_centerTextContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_centerTextContainer.superview);
        }];
        
        CGFloat titleLabelWidth = 64.f;
        UILabel *titLabel = [self titleTempLabel];
        [_centerTextContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.equalTo(titLabel.superview).inset(15);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        
        UILabel *centerTextLabel = [self centerTextTempLabel];
        [_centerTextContainer addSubview:centerTextLabel];
        [centerTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(centerTextLabel.superview).offset(titleLabelWidth+10+kPadding_Left);
            make.top.equalTo(titLabel);
            make.bottom.equalTo(centerTextLabel.superview).inset(15);
            make.height.mas_greaterThanOrEqualTo(22.f);
            make.trailing.equalTo(centerTextLabel.superview).inset(kPadding_Right);
        }];
        
        [_centerTextContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _centerTextContainer;
}

#pragma mark - 标题+内容+指示器
- (UIView *)centerTextAndIndicateContainer {
    if (!_centerTextAndIndicateContainer) {
        _centerTextAndIndicateContainer = [[UIView alloc] init];
        [self addSubview:_centerTextAndIndicateContainer];
        [_centerTextAndIndicateContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_centerTextAndIndicateContainer.superview);
        }];
        
        CGFloat titleLabelWidth = 64.f;
        UILabel *titLabel = [self titleTempLabel];
        [_centerTextAndIndicateContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.equalTo(titLabel.superview).inset(15);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        
        UIImageView *indicate = [self indicatorTempImageView];
        [_centerTextAndIndicateContainer addSubview:indicate];
        [indicate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(indicate.superview).inset(kPadding_Left);
            make.centerY.equalTo(indicate.superview);
        }];
        
        UILabel *centerTextLabel = [self centerTextTempLabel];
        [_centerTextAndIndicateContainer addSubview:centerTextLabel];
        [centerTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(centerTextLabel.superview).offset(titleLabelWidth+10+kPadding_Left);
            make.top.equalTo(titLabel);
            make.bottom.equalTo(centerTextLabel.superview).inset(15);
            make.height.mas_greaterThanOrEqualTo(22.f);
            make.trailing.equalTo(indicate.mas_leading).inset(kPadding_Right);
        }];
        
        [_centerTextAndIndicateContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _centerTextAndIndicateContainer;
}

#pragma mark - 标题+输入框+指示器
- (UIView *)textFieldAndIndicateContainer {
    if (!_textFieldAndIndicateContainer) {
        _textFieldAndIndicateContainer = [[UIView alloc] init];
        [self addSubview:_textFieldAndIndicateContainer];
        [_textFieldAndIndicateContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_textFieldAndIndicateContainer.superview);
        }];
        
        CGFloat titleLabelWidth = 64.f;
        UILabel *titLabel = [self titleTempLabel];
        [_textFieldAndIndicateContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.bottom.equalTo(titLabel.superview).inset(15);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        
        UIImageView *indicate = [self indicatorTempImageView];
        [_textFieldAndIndicateContainer addSubview:indicate];
        [indicate mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(indicate.superview).inset(kPadding_Left);
            make.centerY.equalTo(indicate.superview);
        }];
        
        UITextField *centerTextField = [self centerTextTempTextField];
        [_textFieldAndIndicateContainer addSubview:centerTextField];
        [centerTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(centerTextField.superview).offset(titleLabelWidth+10+kPadding_Left);
            make.centerY.equalTo(centerTextField.superview);
            make.trailing.equalTo(indicate.mas_leading).inset(kPadding_Right);
        }];
        
        [_textFieldAndIndicateContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _textFieldAndIndicateContainer;
}

#pragma mark - 标题+输入框+指示器(按钮)
- (UIView *)textFieldAndIndicateButtonContainer {
    if (!_textFieldAndIndicateButtonContainer) {
        _textFieldAndIndicateButtonContainer = [[UIView alloc] init];
        [self addSubview:_textFieldAndIndicateButtonContainer];
        [_textFieldAndIndicateButtonContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_textFieldAndIndicateButtonContainer.superview);
        }];
        
        CGFloat titleLabelWidth = 64.f;
        UILabel *titLabel = [self titleTempLabel];
        [_textFieldAndIndicateButtonContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.bottom.equalTo(titLabel.superview).inset(15);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        
        UIButton *indicator = [self indicatorTempButton];
        [_textFieldAndIndicateButtonContainer addSubview:indicator];
        [indicator mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(indicator.superview).inset(kPadding_Left);
            make.centerY.equalTo(indicator.superview);
        }];
        
        UITextField *centerTextField = [self centerTextTempTextField];
        [_textFieldAndIndicateButtonContainer addSubview:centerTextField];
        [centerTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(centerTextField.superview).offset(titleLabelWidth+10+kPadding_Left);
            make.centerY.equalTo(centerTextField.superview);
            make.trailing.equalTo(indicator.mas_leading).inset(kPadding_Right);
        }];
        
        [_textFieldAndIndicateButtonContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _textFieldAndIndicateButtonContainer;
}

#pragma mark - 标题+输入框+指示器(编辑)
- (UIView *)textFieldAndIndicateEditButtonContainer {
    if (!_textFieldAndIndicateEditButtonContainer) {
        _textFieldAndIndicateEditButtonContainer = [[UIView alloc] init];
        [self addSubview:_textFieldAndIndicateEditButtonContainer];
        [_textFieldAndIndicateEditButtonContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_textFieldAndIndicateEditButtonContainer.superview);
        }];
        
        CGFloat titleLabelWidth = 64.f;
        UILabel *titLabel = [self titleTempLabel];
        [_textFieldAndIndicateEditButtonContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.equalTo(titLabel.superview).inset(15);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        
        UILabel *centerTextLabel = [self centerTextTempLabel];
        [_textFieldAndIndicateEditButtonContainer addSubview:centerTextLabel];
        [centerTextLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(centerTextLabel.superview).offset(titleLabelWidth+10+kPadding_Left);
            make.top.equalTo(titLabel);
            make.bottom.equalTo(centerTextLabel.superview).inset(15);
            make.height.mas_greaterThanOrEqualTo(22.f);
            make.trailing.equalTo(centerTextLabel.superview).inset(kPadding_Right*3);
        }];
        
        UITextField *centerTextField = [self centerTextTempTextField];
        UIButton *editButton = [self indicatorTempButton];
        editButton.frame = CGRectMake(0, 0, 16, 20);
        editButton.imageKey = @"编辑";
        centerTextField.rightView  = editButton;
        centerTextField.rightViewMode = UITextFieldViewModeUnlessEditing;
        [editButton addTarget:self action:@selector(setTextFieldFirstResponder) forControlEvents:UIControlEventTouchUpInside];
        [_textFieldAndIndicateEditButtonContainer addSubview:centerTextField];
        [centerTextField mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.leading.equalTo(centerTextLabel);
            make.trailing.equalTo(centerTextField.superview).inset(kPadding_Right);
        }];
        
        [_textFieldAndIndicateEditButtonContainer addSubview:self.separateLine];
        [self.separateLine mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.bottom.equalTo(self.separateLine.superview);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _textFieldAndIndicateEditButtonContainer;
}

#pragma mark - 标题+开关
- (UIView *)switchContainer {
    if (!_switchContainer) {
        _switchContainer = [[UIView alloc] init];
        [self addSubview:_switchContainer];
        [_switchContainer mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.top.bottom.equalTo(_switchContainer.superview);
        }];
        
        CGFloat titleLabelWidth = 64.f;
        UILabel *titLabel = [self titleTempLabel];
        [_switchContainer addSubview:titLabel];
        [titLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.equalTo(titLabel.superview).inset(kPadding_Left);
            make.top.bottom.equalTo(titLabel.superview).inset(15);
            make.width.mas_equalTo(titleLabelWidth);
        }];
        
        UISwitch *switchControl = [self switchTempControl];
        [_switchContainer addSubview:switchControl];
        [switchControl mas_updateConstraints:^(MASConstraintMaker *make) {
            make.trailing.equalTo(switchControl.superview).inset(kPadding_Left);
            make.centerY.equalTo(switchControl.superview);
        }];
    }
    return _switchContainer;
}

#pragma mark - 控件
- (UILabel *)titleTempLabel {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.fontKey = kFont_Text_Nor;
    titleLabel.textColorKey = kTextColor_Main;
    _titleLabel = titleLabel;
    return titleLabel;
}

- (UILabel *)subTitleTempLabel {
    UILabel *subTitleLabel = [[UILabel alloc] init];
    subTitleLabel.fontKey = kFont_Text_Nor;
    subTitleLabel.textColorKey = kTextColor_Assist;
    subTitleLabel.userInteractionEnabled = YES;
    _subTitleLabel = subTitleLabel;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didClickSubTitle)];
    [subTitleLabel addGestureRecognizer:tap];
    return subTitleLabel;
}

- (UILabel *)centerTitleTempLabel {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.fontKey = kFont_Text_Nor;
    titleLabel.textColorKey = kTextColor_Main;
    _centerTitleLabel = titleLabel;
    return titleLabel;
}

- (UILabel *)centerTextTempLabel {
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.fontKey = kFont_Text_Nor;
    titleLabel.textColorKey = kTextColor_Assist;
    titleLabel.numberOfLines = 0;
    _centerTextLabel = titleLabel;
    return titleLabel;
}

- (UITextField *)centerTextTempTextField {
    UITextField *textField = [[UITextField alloc] init];
    textField.fontKey = kFont_Text_Nor;
    textField.textColorKey = kTextColor_Main;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.delegate = self;
    _textField = textField;
    
    [textField addTarget:self action:@selector(textFieldTextDidChanged:) forControlEvents:UIControlEventEditingChanged];
    return textField;
}

- (UIImageView *)indicatorTempImageView {
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.imageKey = @"指示器";
    [imageView setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [imageView setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    _indicatorImageView = imageView;
    return imageView;
}

- (UIButton *)indicatorTempButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.fontKey = kFont_Text_Nor;
    button.textColorKey = kTextColor_Assist;
    [button addTarget:self action:@selector(didClickIndicator) forControlEvents:UIControlEventTouchUpInside];
    [button setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [button setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    _indicatorButton = button;
    return button;
}

- (UISwitch *)switchTempControl {
    UISwitch *control = [[UISwitch alloc] init];
    _switchControl = control;
    return control;
}

- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc] init];
        _separateLine.backgroundColorKey = kSeparateLineColor;
    }
    return _separateLine;
}

@end
