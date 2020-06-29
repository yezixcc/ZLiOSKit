//
//  ZLNewsCell_02.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/14.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLBaseTableCell.h"

@class ZLNewsModel;
@interface ZLNewsCell_02 : ZLBaseTableCell

@property (nonatomic, strong) ZLNewsModel *model;
- (void)reloadInfoTitle:(NSString *)title
                 source:(NSString *)source
                   time:(NSString *)time;

@end

