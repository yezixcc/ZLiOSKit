//
//  ZLNewsModel.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/7.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLNewsModel.h"
#import "ZLTimeTool.h"

@implementation ZLNewsModel

- (void)setPubTime:(NSString *)pubTime {
    long long time = [pubTime longLongValue];
    pubTime = [ZLTimeTool formatAgoForTime:time];
    _pubTime = pubTime;
}

@end
