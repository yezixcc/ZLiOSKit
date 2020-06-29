//
//  ZLBannerCell.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/5.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLBannerCell.h"
/// views
#import "ZLBannerItemCell_01.h"
/// models
#import "ZLNewsModel.h"
/// kits
#import <AFNetworking/UIImage+AFNetworking.h>
#import <Masonry/Masonry.h>
#import "ZLTheme.h"

static CGFloat kImageViewWidth = 342.f;
static CGFloat kImageViewHeight = 143.f;
static CGFloat kImageViewCornerRadius = 6.f;
@interface ZLBannerCell ()<ZKCycleScrollViewDelegate, ZKCycleScrollViewDataSource>
@property (nonatomic, copy) NSString *cellIdentifier;
@end

@implementation ZLBannerCell

/// 获取Cell
/// @param style 样式
+ (Class)cellClassForStyle:(ZLBannerStyle)style {
    switch (style) {
        case ZLBannerStyleImage:
            return [ZLBannerItemCell_01 class];
            break;
        default:
            break;
    }
    return [ZLBannerItemCell_01 class];
}

#pragma mark - 实例化

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier params:(NSDictionary *)params {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        ZLBannerStyle style = [params[@"style"] integerValue];
        [self setupViews];
        [self registCellForStyle:style];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
        [self registCellForStyle:ZLBannerStyleImage];
    }
    return self;
}

- (instancetype)initWithStyle:(ZLBannerStyle)style {
    self = [super init];
    if (self) {
        [self setupViews];
        [self registCellForStyle:style];
    }
    return self;
}

- (void)registCellForStyle:(ZLBannerStyle)style {
    Class cellClass = [ZLBannerCell cellClassForStyle:style];
    _cellIdentifier = NSStringFromClass(cellClass);
    [self.cycleScrollView registerCellClass:cellClass forCellWithReuseIdentifier:_cellIdentifier];
}

#pragma mark - 布局

- (void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.cycleScrollView.superview).inset(kPadding_Left);
        make.top.equalTo(self.cycleScrollView.superview).offset(kPadding_Left);
        make.bottom.equalTo(self.cycleScrollView.superview);
        make.height.mas_equalTo([ZLBannerCell viewHeight]-kPadding_Left).priority(750);
    }];

    [self.contentView addSubview:self.defaultImageView];
    [self.defaultImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.cycleScrollView).insets(UIEdgeInsetsZero);
    }];
}

- (void)setDatas:(NSArray<ZLNewsModel *> *)datas {
    _datas = datas;
    _defaultImageView.hidden = datas.count != 0;
    [self.cycleScrollView reloadData];
}

- (void)reloadData:(ZLTableRowModel *)rowModel {
    [super reloadData:rowModel];
    NSDictionary *dict = rowModel.data;
    NSArray<ZLNewsModel *> *datas = dict[@"models"];
    self.datas = datas;
}

#pragma mark - ZKCycleScrollView DataSource

- (NSInteger)numberOfItemsInCycleScrollView:(ZKCycleScrollView *)cycleScrollView {
    return self.datas.count;
}

- (__kindof ZKCycleScrollViewCell *)cycleScrollView:(ZKCycleScrollView *)cycleScrollView cellForItemAtIndex:(NSInteger)index {
    ZLNewsModel *model = [self.datas objectAtIndex:index];
    UICollectionViewCell *cell = [cycleScrollView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndex:index];
    if ([cell conformsToProtocol:@protocol(ZLViewProtocol)]) {
        id<ZLViewProtocol>view = (id<ZLViewProtocol>)cell;
        [view reloadData:model];
    }
    return cell;
}

#pragma mark - ZKCycleScrollView Delegate

- (void)cycleScrollView:(ZKCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    ZLNewsModel *model = [self.datas objectAtIndex:index];
    if ([_delegate respondsToSelector:@selector(zlBannerCell:didSelectItemAtIndex:model:)]) {
        [_delegate zlBannerCell:self didSelectItemAtIndex:index model:model];
    }
    if (self.rowModel.target && self.rowModel.action) {
        if ([self.rowModel.target respondsToSelector:self.rowModel.action]) {
            NSMutableDictionary *obj = [[NSMutableDictionary alloc] init];
            [obj setValue:model forKey:@"data"];
            [obj setValue:@(index) forKey:@"index"];
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [self.rowModel.target performSelector:self.rowModel.action withObject:obj];
            #pragma clang diagnostic pop
        }
    }
}

#pragma mark - getters - 控件

- (ZKCycleScrollView *)cycleScrollView {
    if (!_cycleScrollView) {
        _cycleScrollView = [[ZKCycleScrollView alloc] init];
        _cycleScrollView.autoScrollInterval = 5;
        _cycleScrollView.delegate = self;
        _cycleScrollView.dataSource = self;
        _cycleScrollView.layer.cornerRadius = kImageViewCornerRadius;
        _cycleScrollView.layer.masksToBounds = YES;
    }
    return _cycleScrollView;
}

- (UIImageView *)defaultImageView {
    if (!_defaultImageView) {
        _defaultImageView = [[UIImageView alloc] init];
        _defaultImageView.imageKey = @"滚动默认图";
        _defaultImageView.layer.cornerRadius = kImageViewCornerRadius;
        _defaultImageView.layer.masksToBounds = YES;
    }
    return _defaultImageView;
}

+ (CGFloat)viewHeight {
    CGFloat selfWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = (selfWidth-kPadding_Left*2)*kImageViewHeight/kImageViewWidth;
    return h + kPadding_Left;
}

@end
