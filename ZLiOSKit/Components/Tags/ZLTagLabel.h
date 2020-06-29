//
//  ZLTagLabel.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 标签风格
typedef NS_ENUM(NSInteger, ZLTagLabelStyle) {
    ZLTagLabelStyleRed,
    ZLTagLabelStyleBlue,
    ZLTagLabelStyleYellow,
};

/**
 标签Label
 */
@interface ZLTagLabel : UILabel

- (instancetype)initWithStyle:(ZLTagLabelStyle)style;

@property (nonatomic, assign) ZLTagLabelStyle style;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

@end
