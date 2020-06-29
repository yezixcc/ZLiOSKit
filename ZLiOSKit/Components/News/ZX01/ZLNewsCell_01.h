//
//  ZLNewsCell_01.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/7.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLBaseTableCell.h"
#import "ZLTagLabel.h"
#import "ZLNewsModel.h"

@interface ZLNewsCell_01 : ZLBaseTableCell

@property (nonatomic, strong) ZLNewsModel *model;
- (void)reloadTitle:(NSString *)title
            tagText:(NSString *)tagText
           tagStyle:(ZLTagLabelStyle)style;

@end
