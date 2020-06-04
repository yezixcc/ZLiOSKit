//
//  ZLNextStepButton.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/5/11.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLNextStepButtonStateSource <NSObject>
@optional
/// 按钮使能条件
- (BOOL)zlNextStepButtonEnabale;
@end


typedef NS_ENUM(NSInteger, ZLNextStepButtonStyle) {
    ZLNextStepButtonStyleSquare,
    ZLNextStepButtonStyleCircle,
    ZLNextStepButtonStyleHalfCircle,
};

@interface ZLNextStepButton : UIButton

@property (nonatomic, copy) NSString *normalColorKey;
@property (nonatomic, copy) NSString *unableColorKey;
- (instancetype)initWithStyle:(ZLNextStepButtonStyle)style
                  stateSource:(id<ZLNextStepButtonStateSource>)staSource;
- (void)addToSuperView:(UIView *)superView;
- (void)updateState;

@end
