//
//  ZLMenuCell.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLMenuCell.h"
#import "ZLMenuItemCell.h"
/// kits
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

static CGFloat kMenuItemHeight = 55.f;
static CGFloat kMenuItemInsert = 20.f;
@interface ZLMenuCell ()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation ZLMenuCell

#pragma mark - 实例化
- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.itemsOnline = 4;
        self.collectionView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.collectionView];
    }
    return self;
}

#pragma mark - 更新数据
- (void)zl_updateConstraints {
    NSInteger lines = ceil(self.datas.count / self.itemsOnline);
    CGFloat height = kMenuItemInsert*(lines+1)+kMenuItemHeight*lines;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self);
        make.height.mas_equalTo(height).priority(750);
    }];
    self.frame = CGRectMake(0, 0, self.frame.size.width, height);
}

- (void)reloadData:(ZLTableRowModel *)rowModel {
    [super reloadData:rowModel];
    NSDictionary *dict = rowModel.data;
    NSArray<ZLMenuItemCellModel *> *datas = dict[@"models"];
    self.datas = datas;
}

- (void)setDatas:(NSArray<ZLMenuItemCellModel *> *)datas {
    if (datas.count != 0 && datas.count != _datas.count) {
        CGFloat w = [UIScreen mainScreen].bounds.size.width;
        _flowLayout.itemSize = CGSizeMake(w/datas.count-1, kMenuItemHeight);
    }
    _datas = datas;
    [self.collectionView reloadData];
    [self zl_updateConstraints];
}

#pragma mark - collectionView Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZLMenuItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZLMenuItemCell class]) forIndexPath:indexPath];
    cell.model = self.datas[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([_delegate respondsToSelector:@selector(zlMenuCell:didSelectItemAtIndexPath: model:)]) {
        ZLMenuItemCellModel *model = self.datas[indexPath.item];
        [_delegate zlMenuCell:self didSelectItemAtIndexPath:indexPath model:model];
    }
}

#pragma mark - getters 控件
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[ZLMenuItemCell class] forCellWithReuseIdentifier:NSStringFromClass([ZLMenuItemCell class])];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.minimumLineSpacing = kMenuItemInsert;
        _flowLayout.minimumInteritemSpacing = 0.f;
        _flowLayout.sectionInset = UIEdgeInsetsMake(kMenuItemInsert, 0, kMenuItemInsert, 0);
    }
    return _flowLayout;
}

@end
