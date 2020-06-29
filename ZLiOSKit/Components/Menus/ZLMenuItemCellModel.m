//
//  ZLMenuItemModel.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/18.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLMenuItemCellModel.h"

@implementation ZLMenuItemCellModel

- (instancetype)initWithTitle:(NSString *)title icon:(NSString *)icon {
    self = [super init];
    if (self) {
        self.title = title;
        self.icon = icon;
    }
    return self;
}

@end
