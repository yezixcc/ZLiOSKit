//
//  ZLTableView.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLTableView.h"
/// views
#import "ZLBaseTableCell.h"
#import "ZLEmotionMapView.h"
/// models
#import "ZLTableModel.h"
/// kits
#import "ZLTheme.h"
#import <MJRefresh/MJRefresh.h>

NSInteger const kTablePageStart = 1;  /// 开始页码
NSInteger const kTablePageSize = 20;  /// 每页数据
@interface ZLTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSDictionary *params; /// cell注册参数
@property (nonatomic, assign) NSInteger currentPage;  /// 当前页码
@property (nonatomic, strong) UIView *emotionMap;   /// 情感图

@end

@implementation ZLTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.estimatedRowHeight = 44.f;
        self.rowHeight = UITableViewAutomaticDimension;
        self.backgroundColorKey = kBackgroundColor;
        self.pageStart = kTablePageStart;
        self.pageSize = kTablePageSize;
    }
    return self;
}

- (void)registerCellClass:(Class)cellClass
                   params:(NSDictionary *)params {
    if (params) { // 在返回cell中创建，不用regist
        _params = params;
    }else {
        [self registerClass:cellClass
     forCellReuseIdentifier:NSStringFromClass(cellClass)];
    }
}

#pragma mark - mjRefresh

- (void)setPullDownRefreshEnable:(BOOL)pullDownRefreshEnable {  /// 下拉刷新
    if (_pullDownRefreshEnable != pullDownRefreshEnable) {
        _pullDownRefreshEnable = pullDownRefreshEnable;
        if (pullDownRefreshEnable) {
            self.mj_header = self.mj_header ? : [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefreshData)];
        }else {
            self.mj_header = nil;
        }
    }
}

- (void)setPullUpRefresh:(BOOL)pullUpRefresh {
    if (pullUpRefresh) {
        self.mj_footer = self.mj_footer ? : [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUpRefreshData)];
    }else {
        self.mj_footer = nil;
    }
}

- (void)pullDownRefreshData { /// 下拉刷新
    if (_zlDelegate && [_zlDelegate respondsToSelector:@selector(zlTableView:refreshPage:complete:)]) {
        self.currentPage = kTablePageStart;
        [self refreshPage];
    }
}

- (void)pullUpRefreshData { /// 上拉刷新
    if (_zlDelegate && [_zlDelegate respondsToSelector:@selector(zlTableView:refreshPage:complete:)]) {
        self.currentPage++;
        [self refreshPage];
    }
}

- (void)refreshPage {
    __weak typeof(self) weakSelf = self;
    [_zlDelegate zlTableView:self refreshPage:self.currentPage complete:^(NSError *error, NSNumber *totalCount, NSArray<ZLTableModel *> *datas) {
        /// 停止动画
        [weakSelf endRefresh];
        /// 数据请求失败
        if (error) {
            if (weakSelf.currentPage != kTablePageStart) {
                weakSelf.currentPage--;
            }else {
                [weakSelf showErrorDataMap];
            }
            return;
        }
        /// 空数据
        if (datas == nil) {
            if (weakSelf.currentPage != kTablePageStart) {
                weakSelf.currentPage--;
            }else {
                [weakSelf showEmptyDataMap];
            }
            return;
        }
        
        if ([datas isKindOfClass:[NSArray<ZLTableModel *> class]]) {
            /// 属于下拉刷新
            if (weakSelf.currentPage == kTablePageStart) {
                weakSelf.datas = nil;
                /// 没有数据
                if (datas.count == 0) {
                    [weakSelf showEmptyDataMap];
                    return;
                }
            }
            
            /// 先移除情感图
            [weakSelf clearEmotionMap];
            /// 数据装载
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:weakSelf.datas];
            [tempArray addObjectsFromArray:datas];
            weakSelf.datas = tempArray;
            /// 刷新数据
            [weakSelf reloadData];
            
            /// 上拉判断
            if (weakSelf.pullUpRefreshEnable == NO) {
                return;
            }
            NSInteger count = 0;
            if (totalCount) { /// 总数存在用总数判断有无下页
                for (ZLTableModel *tableModel in weakSelf.datas) {
                    count += tableModel.rowModels.count;
                }
                if (count < totalCount.integerValue) {
                    [weakSelf setPullUpRefresh:YES];
                }else {
                    [weakSelf setPullUpRefresh:NO];
                }
            }else { /// 总数不存在用单页判断有无下页
                for (ZLTableModel *tableModel in datas) {
                    count += tableModel.rowModels.count;
                }
                if (count < kTablePageSize) {
                    [weakSelf setPullUpRefresh:NO];
                }else {
                    [weakSelf setPullUpRefresh:YES];
                }
            }
        }else { /// 请求失败
            if (weakSelf.currentPage == kTablePageStart) {
                [weakSelf showEmptyDataMap];
                [weakSelf setPullUpRefresh:NO];
            }
        }
    }];
}

- (void)beginRresh {
    if (self.mj_header) {
        [self.mj_header beginRefreshing];
    }else {
        [self pullDownRefreshData];
    }
}

- (void)endRefresh {
    if (self.currentPage == kTablePageStart) {
        [self.mj_header endRefreshing];
    }else {
        [self.mj_footer endRefreshing];
    }
}

- (NSArray<ZLTableModel *> *)datas {
    if (!_datas) {
        NSArray *datas = [[NSArray alloc] init];
        _datas = datas;
    }
    return _datas;
}

#pragma mark - emptyData or errorData status

- (void)showEmptyDataMap {
    [self showEmotionMapWithType:ZLEmotionMapTypeEmptyDefault];
}

- (void)showErrorDataMap {
    [self showEmotionMapWithType:ZLEmotionMapTypeErrorDefault];
}

- (void)showEmotionMapWithType:(ZLEmotionMapType)type {
    [self clearEmotionMap];
    ZLEmotionMapView *emotionMap = [[ZLEmotionMapView alloc] initWithType:type];
    __weak typeof(self) weakSelf = self;
    emotionMap.didClickView = ^{
        [weakSelf clearEmotionMap];
        [weakSelf beginRresh];
    };
    
    if (type != ZLEmotionMapTypeErrorDefault) {
        if ([_zlDelegate respondsToSelector:@selector(emotionMapView)]) {
            _emotionMap = [_zlDelegate emotionMapView];
        }else {
            if ([_zlDelegate respondsToSelector:@selector(emotionMapTitle)]) {
                emotionMap.title = [_zlDelegate emotionMapTitle];
            }
            if ([_zlDelegate respondsToSelector:@selector(emotionMapSubTitle)]) {
                emotionMap.subtitle = [_zlDelegate emotionMapSubTitle];
            }
            if ([_zlDelegate respondsToSelector:@selector(emotionMapImageName)]) {
                emotionMap.imageName = [_zlDelegate emotionMapImageName];
            }
            _emotionMap = emotionMap;
        }
    }else {
        _emotionMap = emotionMap;
    }
    _emotionMap.frame = self.superview.bounds;
    _emotionMap.alpha = 0.f;
    [self.superview addSubview:_emotionMap];
    [UIView animateWithDuration:0.25f animations:^{
        self.emotionMap.alpha = 1.f;
    }];
}

- (void)clearEmotionMap {
    [_emotionMap removeFromSuperview];
    _emotionMap = nil;
}

#pragma mark - dataSource & delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSArray *sections = self.datas;
    return sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = self.datas;
    ZLTableModel *model = [sections objectAtIndex:section];
    return model.rowModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sections = self.datas;
    ZLTableModel *tabModel = [sections objectAtIndex:indexPath.section];
    ZLTableRowModel *model = [tabModel.rowModels objectAtIndex:indexPath.row];
    NSString *reuseIdentifier = model.className ? : @"cell";
    ZLBaseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        Class CellClass = NSClassFromString(reuseIdentifier);
        if (CellClass && [CellClass conformsToProtocol:@protocol(ZLBaseTableProtocol)]) {
            cell = [[CellClass alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier params:_params];
        }else {
            cell = [[ZLBaseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier params:_params];
        }
    }
    if (cell.rowModel !=  model) {
        [cell setRowModel:model];
        [cell reloadData:model];
    }
    if ([_zlDelegate respondsToSelector:@selector(zlTableView:cell:indexPath:)]) {
        [_zlDelegate zlTableView:self cell:cell indexPath:indexPath];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *sections = self.datas;
    ZLTableModel *tabModel = [sections objectAtIndex:section];
    return tabModel.header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    NSArray *sections = self.datas;
    ZLTableModel *tabModel = [sections objectAtIndex:section];
    return tabModel.footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray *sections = self.datas;
    ZLTableModel *tabModel = [sections objectAtIndex:section];
    UIView *header = tabModel.header;
    if (header) {
        [header layoutIfNeeded];
        return header.frame.size.height;
    }
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    NSArray *sections = self.datas;
    ZLTableModel *tabModel = [sections objectAtIndex:section];
    UIView *footer = tabModel.footer;
    if (footer) {
        [footer layoutIfNeeded];
        return footer.frame.size.height;
    }
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *sections = self.datas;
    ZLTableModel *tabModel = [sections objectAtIndex:indexPath.section];
    ZLTableRowModel *model = [tabModel.rowModels objectAtIndex:indexPath.row];
    if (model.target && model.action) {
        if ([model.target respondsToSelector:model.action]) {
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [model.target performSelector:model.action withObject:model];
            #pragma clang diagnostic pop
        }
    }
    if (_zlDelegate && [_zlDelegate respondsToSelector:@selector(zlTableView:didSelectRowAtIndexPath:)]) {
        [_zlDelegate zlTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

@end
