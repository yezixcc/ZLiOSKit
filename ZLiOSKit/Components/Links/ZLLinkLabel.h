//
//  ZLLinkLabel.h
//  iOSZlfund
//
//  Created by yezixcc on 2020/4/8.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZLLinkLabel : UIView

@property (nonatomic, strong) NSString *textColorKey;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@property (nonatomic, copy) void(^leftLabelDidClicked)(void);
@property (nonatomic, copy) void(^rightLabelDidClicked)(void);

@end
