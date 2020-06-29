//
//  ZLBaseTableProtocol.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/6.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZLTableRowModel;
@protocol ZLBaseTableProtocol <NSObject>

@optional
@property (nonatomic, strong) ZLTableRowModel *rowModel;

/// 实例化TableViewCell
/// @param style 样式
/// @param reuseIdentifier 复用id
/// @param params 参数 - 有些需要传入参数，例如样式style等
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                       params:(NSDictionary *)params;

/// 刷新数据
/// @param rowModel 每行数据模型
- (void)reloadData:(ZLTableRowModel *)rowModel;

@end
