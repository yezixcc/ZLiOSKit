//
//  ZLMenuItemCell.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLMenuItemCellModel;
@interface ZLMenuItemCell : UICollectionViewCell

@property (nonatomic, strong) ZLMenuItemCellModel *model;   /// 数据源
@property (nonatomic, strong) UILabel *titleLabel;  /// 标题
@property (nonatomic, strong) UIImageView *iconImageView;   /// 图标

@end

