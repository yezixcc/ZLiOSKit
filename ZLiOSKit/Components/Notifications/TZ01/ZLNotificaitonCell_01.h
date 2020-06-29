//
//  ZLNotificaitonCell_01.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/8.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLBaseTableCell.h"
#import "ZLNewsModel.h"

@interface ZLNotificaitonCell_01 : ZLBaseTableCell

@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) ZLNewsModel *model;

@end

