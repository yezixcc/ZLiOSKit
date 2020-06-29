//
//  ZLTableView.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLTableModel, ZLTableView;
@protocol ZLTableViewDelegate<NSObject>

@optional
/// 返回cell
/// @param tableView tableView
/// @param indexPath indexPath
- (UITableViewCell *)zlTableView:(ZLTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

/// 点击事件
/// @param tableView 列表
/// @param indexPath 索引
- (void)zlTableView:(ZLTableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/// 刷新页面请求
/// @param tableView 列表
/// @param page 当前页码
/// @param complete 完成回调(需回传) - 错误、数据总条数、数据
- (void)zlTableView:(ZLTableView *)tableView refreshPage:(NSInteger)page complete:(void(^)(NSError *error, NSNumber *totalCount, NSArray<ZLTableModel *> *datas))complete;

/// 情感图
- (UIView *)emotionMapView;
- (NSString *)emotionMapTitle;
- (NSString *)emotionMapSubTitle;
- (NSString *)emotionMapImageName;

@end

@interface ZLTableView : UITableView

@property (nonatomic, assign) BOOL pullDownRefreshEnable;   /// 允许下拉刷新
@property (nonatomic, assign) BOOL pullUpRefreshEnable; /// 允许上拉加载更多
@property (nonatomic, assign) NSInteger pageStart;  /// 开始页码 - 默认1
@property (nonatomic, assign) NSInteger pageSize;  /// 每页数据 - 默认20
@property (nonatomic, assign, readonly) NSInteger currentPage;  /// 当前页码
@property (nonatomic, strong) NSArray<ZLTableModel*> *datas;    /// 数据源
@property (nonatomic, weak) id<ZLTableViewDelegate>zlDelegate;  /// 代理

/// 注册cell
/// @param cellClass cell类名
/// @param params 参数，比如有些cell有不同的style，就可传入@{@"style": cellStyleValue}
- (void)registerCellClass:(Class)cellClass params:(NSDictionary *)params;
- (void)beginRresh;
- (void)endRefresh;

@end

