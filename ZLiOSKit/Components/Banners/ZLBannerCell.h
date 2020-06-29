//
//  ZLBannerCell.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/5.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLBaseTableCell.h"
#import "ZKCycleScrollView.h"

typedef NS_ENUM(NSInteger, ZLBannerStyle) {
    /// 单张图
    ZLBannerStyleImage,
};

@class ZLBannerCell, ZLNewsModel;
@protocol ZLBannerCellDelegate <NSObject>

@optional
- (void)zlBannerCell:(ZLBannerCell *)cell
didSelectItemAtIndex:(NSInteger)index
               model:(ZLNewsModel *)model;

@end

/** 滚动图 */
@interface ZLBannerCell : ZLBaseTableCell

- (instancetype)initWithStyle:(ZLBannerStyle)style; /// 实例化
@property (nonatomic, strong) ZKCycleScrollView *cycleScrollView; /// 滚动界面
@property (nonatomic, strong) UIImageView *defaultImageView; /// 默认图
@property (nonatomic, strong) NSArray<ZLNewsModel*> *datas; /// 数据源
@property (nonatomic, weak) id<ZLBannerCellDelegate>delegate;   /// 代理

@end

