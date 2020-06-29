//
//  ZLEmptyDataDefaultView.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/22.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ZLEmotionMapType) {
    /// 默认空状态
    ZLEmotionMapTypeEmptyDefault,
    /// 默认错误状态
    ZLEmotionMapTypeErrorDefault,
};

@interface ZLEmotionMapView : UIView

@property (nonatomic, assign) ZLEmotionMapType type;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) void(^didClickView)(void);
- (instancetype)initWithType:(ZLEmotionMapType)type;

@end
