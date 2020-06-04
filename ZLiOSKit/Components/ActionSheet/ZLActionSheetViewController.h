//
//  ActionSheetViewController.h
//  iOSCat
//
//  Created by yezixcc on 2019/8/26.
//  Copyright © 2019 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZLActionSheetDelegate <NSObject>

@optional
- (void)actionSheetDidClickIndex:(NSInteger)index;
- (void)actionSheetDidClickCancel;

@end

@interface ZLActionSheetViewController : UIViewController
@property (strong, nonatomic) UIView *actionSheetView;
@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *contentView;
@property (strong, nonatomic) UILabel *cancelLabel;
@property (nonatomic, weak) id<ZLActionSheetDelegate>delegate;

- (instancetype)initWithActionTitles:(NSArray *)actionTitles
                   cancelActionTitle:(NSString *)cancel
                            delegate:(id<ZLActionSheetDelegate>)delegate;
- (instancetype)initWithTitle:(NSString *)title
                 actionTitles:(NSArray *)actionTitles
            cancelActionTitle:(NSString *)cancel
                     delegate:(id<ZLActionSheetDelegate>)delegate;
- (instancetype)initWithTitle:(NSString *)title
                 actionTitles:(NSArray *)actionTitles
              hightlightIndex:(NSInteger)index
            cancelActionTitle:(NSString *)cancel
                     delegate:(id<ZLActionSheetDelegate>)delegate;
- (void)showWithAnimate:(BOOL)animate;
- (void)dismiss;

@end
