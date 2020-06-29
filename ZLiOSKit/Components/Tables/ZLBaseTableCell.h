//
//  ZLBaseTableViewCell.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/3.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZLTableModel.h"
#import "ZLBaseTableProtocol.h"

@interface ZLBaseTableCell : UITableViewCell <ZLBaseTableProtocol>

@property (nonatomic, strong) UIView *separateLine; /// 分隔线

@end
