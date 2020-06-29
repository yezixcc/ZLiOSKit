//
//  ZLNewsModel.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/7.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZLNewsModel : NSObject

@property (nonatomic, copy) NSString *title;    /// 标题/内容
@property (nonatomic, copy) NSString *desc;    /// 描述
@property (nonatomic, copy) NSString *imageUrl; /// 图片地址
@property (nonatomic, copy) NSString *linkUrl;  /// 跳转链接
@property (nonatomic, copy) NSString *tagText;  /// 标签文案
@property (nonatomic, copy) NSString *pubTime;  /// 发布时间
@property (nonatomic, copy) NSString *source;  /// 消息来源
@property (nonatomic, assign) NSInteger tagStyle;   /// 标签风格
@property (nonatomic, assign) NSInteger location;   /// 使用位置
 
@end
