//
//  ZLTableViewModel.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 每行数据模型
 */
@interface ZLTableRowModel : NSObject
 
/// 如一个cell放了一个collection，数据格式 self.data = @{@"models": datas};
/// 如一个cell个非collection，数据格式 self.data = cellViewModel;
@property (nonatomic, strong) id data; ///
@property (nonatomic, weak) id target; /// 点击事件执行对象
@property (nonatomic, assign) SEL action; /// 点击事件
@property (nonatomic, copy) NSString *className; /// 注册的cell类

@end


/**
 每组数据模型
 */
@interface ZLTableModel : NSObject

@property (nonatomic, strong) UIView *header;
@property (nonatomic, strong) UIView *footer;
@property (nonatomic, strong) NSArray<ZLTableRowModel*> *rowModels;

@end
