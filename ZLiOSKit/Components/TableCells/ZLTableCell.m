//
//  ZLTableCell.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/6/15.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLTableCell.h"
#import <Masonry/Masonry.h>

@implementation ZLTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.cellContainerView];
        [self.cellContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.leading.trailing.equalTo(self.cellContainerView.superview);
            make.top.bottom.equalTo(self.cellContainerView.superview);
        }];
    }
    return self;
}

- (ZLTableCellContainer *)cellContainerView {
    if (!_cellContainerView) {
        _cellContainerView = [[ZLTableCellContainer alloc] initWithStyle:ZLTableCellStyleTitle];
    }
    return _cellContainerView;
}

@end
