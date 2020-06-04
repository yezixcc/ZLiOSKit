//
//  ZLNextStepButton.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/5/11.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLNextStepButton.h"
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

#define ZLNextStepButtonHeight 46.f
#define ZLNextStepButtonCircle 4.f
@interface ZLNextStepButton ()
@property (nonatomic, assign) ZLNextStepButtonStyle style;
@property (nonatomic, weak) id<ZLNextStepButtonStateSource>stateSource;
@end

@implementation ZLNextStepButton

- (instancetype)initWithStyle:(ZLNextStepButtonStyle)style
                  stateSource:(id<ZLNextStepButtonStateSource>)staSource {
    self = [super init];
    if (self) {
        self.style = style;
        self.stateSource = staSource;
        [self commInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commInit];
    }
    return self;
}

- (void)commInit {
    self.normalColorKey = kButtonColor_Normal;
    self.unableColorKey = kButtonColor_Unable;
    self.titleLabel.fontKey = kFont_Title_Nor;
    UIColor *titleColor = [UIColor whiteColor];
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    [self updateState];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateState];
}

- (void)setStyle:(ZLNextStepButtonStyle)style {
    _style = style;
    if (_style == ZLNextStepButtonStyleCircle) {
        self.layer.cornerRadius = ZLNextStepButtonCircle;
    }else if (_style == ZLNextStepButtonStyleHalfCircle) {
        self.layer.cornerRadius = ZLNextStepButtonHeight/2.f;
    }
}

- (void)addToSuperView:(UIView *)superView {
    if (!self.superview && !superView) {
        return;
    }
    if (superView) {
        [superView addSubview:self];
    }
    [self mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.style == ZLNextStepButtonStyleSquare) {
            make.leading.trailing.equalTo(superView);
            make.height.mas_equalTo(ZLNextStepButtonHeight);
        }else {
            make.leading.trailing.equalTo(superView).inset(20);
            make.height.mas_equalTo(ZLNextStepButtonHeight);
        }
    }];
}

- (void)updateState {
    SEL function = @selector(zlNextStepButtonEnabale);
    BOOL response = [_stateSource respondsToSelector:function];
    BOOL enable = self.enabled;
    if (response) {
        enable = [_stateSource zlNextStepButtonEnabale];
    }
    NSString *colorKey = enable? self.normalColorKey:self.unableColorKey;
    self.backgroundColorKey = colorKey;
    self.userInteractionEnabled = enable;
}

@end
