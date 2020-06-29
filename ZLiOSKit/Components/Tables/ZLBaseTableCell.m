//
//  ZLBaseTableViewCell.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/3.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLBaseTableCell.h"
#import "ZLTheme.h"

@implementation ZLBaseTableCell
@synthesize rowModel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                       params:(NSDictionary *)params {
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)reloadData:(ZLTableRowModel *)rowModel {}

/// 分割线
- (UIView *)separateLine {
    if (!_separateLine) {
        _separateLine = [[UIView alloc] init];
        _separateLine.backgroundColorKey = kSeparateLineColor;
    }
    return _separateLine;
}


@end
