//
//  ZLTagLabel.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLTagLabel.h"
// Kit
#import "UIColor+HexMethod.h"
#import "ZLTheme.h"

@implementation ZLTagLabel

- (instancetype)initWithStyle:(ZLTagLabelStyle)style {
    self = [super init];
    if (self) {
        self.style = style;
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self =  [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.edgeInsets = UIEdgeInsetsMake(2, 4, 2, 4);
    self.layer.cornerRadius = 2;
    self.layer.masksToBounds = YES;
    self.fontKey = kFont_Text_Minor;
}

- (void)setStyle:(ZLTagLabelStyle)style {
    _style = style;
    switch (style) {
        case ZLTagLabelStyleRed:
            self.textColor = [UIColor colorWithHexString:@"#DF1020"];
            break;
        case ZLTagLabelStyleBlue:
            self.textColor = [UIColor colorWithHexString:@"#264BA5"];
            break;
        case ZLTagLabelStyleYellow:
            self.textColor = [UIColor colorWithHexString:@"#D1B083"];
            break;;
        default:
            break;
    }
    self.backgroundColor = [self.textColor colorWithAlphaComponent:0.1];
}

-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines {
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,self.edgeInsets) limitedToNumberOfLines:numberOfLines];
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
