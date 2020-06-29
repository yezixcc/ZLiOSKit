//
//  ActionSheetViewController.h
//  iOSCat
//
//  Created by yezixcc on 2019/8/26.
//  Copyright © 2019 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZLActionSheetViewController;
@protocol ZLActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(ZLActionSheetViewController *)sheet didClickIndex:(NSInteger)index;
- (void)actionSheetDidClickCancel:(ZLActionSheetViewController *)sheet;

@end

@interface ZLActionSheetViewController : UIViewController

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
