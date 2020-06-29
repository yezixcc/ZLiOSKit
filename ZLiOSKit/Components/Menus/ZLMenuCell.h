//
//  ZLMenuCell.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLBaseTableCell.h"

@class ZLMenuCell, ZLMenuItemCellModel;
@protocol ZLMenuCellDelegate <NSObject>

@optional
/// 点击cell
/// @param cell cell
/// @param indexPath indexPath
/// @param model model
- (void)zlMenuCell:(ZLMenuCell *)cell didSelectItemAtIndexPath:(NSIndexPath *)indexPath model:(ZLMenuItemCellModel *)model;

@end

@interface ZLMenuCell : ZLBaseTableCell

@property (nonatomic, strong) UICollectionView *collectionView; /// 列表
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;   /// 布局
@property (nonatomic, strong) NSArray<ZLMenuItemCellModel *> *datas;    /// 数据
@property (nonatomic, assign) NSInteger itemsOnline;    /// 一行多少个item
@property (nonatomic, weak) id<ZLMenuCellDelegate>delegate; /// 代理

@end

