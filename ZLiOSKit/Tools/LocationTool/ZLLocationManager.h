//
//  ZLLocationManager.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/9.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LocationInfoBlock)(NSString *location, NSDictionary *locationDict);

@interface ZLLocationManager : NSObject

+ (instancetype)shareManager;
///注册定位服务
- (void)registerLocationService;
///结束定位
- (void)stopLocation;
///获取当前地理位置
- (void)getCurrentLocationInfo:(LocationInfoBlock)complete;

@end

