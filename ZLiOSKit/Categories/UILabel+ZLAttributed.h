//
//  UILabel+ZLAttributed.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/7/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (ZLAttributed)

/// 设置行间距
/// @param space 间距
-(void)setLineSpace:(CGFloat)space;
-(void)setLineSpace:(CGFloat)space text:(NSString *)text;

@end

