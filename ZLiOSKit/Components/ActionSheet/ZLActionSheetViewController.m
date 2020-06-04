//
//  ActionSheetViewController.m
//  iOSCat
//
//  Created by yezixcc on 2019/8/26.
//  Copyright © 2019 zlfund. All rights reserved.
//

#import "ZLActionSheetViewController.h"
#import "ZLTheme.h"
#import <Masonry/Masonry.h>

static CGFloat kSheetHeight = 50.f;
@interface ZLActionSheetViewController ()

@property (strong, nonatomic) UIView *bgView;
@property (nonatomic, copy) NSString *sheetTitle;
@property (nonatomic, copy) NSArray *actionTitles;
@property (nonatomic, copy) NSString *cancel;
@property (nonatomic, assign) NSInteger highlightIndex;

@end

@implementation ZLActionSheetViewController

- (instancetype)initWithActionTitles:(NSArray *)actionTitles
                   cancelActionTitle:(NSString *)cancel
                            delegate:(id<ZLActionSheetDelegate>)delegate {
    return [self initWithTitle:nil actionTitles:actionTitles cancelActionTitle:cancel delegate:delegate];
}

- (instancetype)initWithTitle:(NSString *)title
                 actionTitles:(NSArray *)actionTitles
            cancelActionTitle:(NSString *)cancel
                     delegate:(id<ZLActionSheetDelegate>)delegate {
    return [self initWithTitle:title actionTitles:actionTitles hightlightIndex:-1 cancelActionTitle:cancel delegate:delegate];
}

 - (instancetype)initWithTitle:(NSString *)title
                  actionTitles:(NSArray *)actionTitles
               hightlightIndex:(NSInteger)index
             cancelActionTitle:(NSString *)cancel
                      delegate:(id<ZLActionSheetDelegate>)delegate {
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        self.sheetTitle = title;
        self.actionTitles = actionTitles;
        self.cancel = cancel;
        self.delegate = delegate;
        self.highlightIndex = index;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.bgView];
    [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.view addSubview:self.actionSheetView];
    [self.actionSheetView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
    }];
    
    [self.actionSheetView addSubview:self.titleLabel];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(self.titleLabel.superview);
        CGFloat h = self.sheetTitle ? 47.5 : 0.0;
        make.height.mas_equalTo(h);
    }];
    
    [self.actionSheetView addSubview:self.cancelLabel];
    [self.cancelLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.cancelLabel.superview);
        make.height.mas_equalTo(kSheetHeight);
    }];
    
    [self.actionSheetView addSubview:self.contentView];
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.contentView.superview);
        make.top.equalTo(self.titleLabel.mas_bottom);
        make.bottom.equalTo(self.cancelLabel.mas_top).inset(10);
    }];
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.contentSize = CGSizeMake([UIScreen mainScreen].bounds.size.width, kSheetHeight*self.actionTitles.count);
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    CGFloat scrollHeight = MIN(3*kSheetHeight, kSheetHeight*self.actionTitles.count);
    [self.contentView addSubview:scrollView];
    [scrollView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(scrollHeight);
        make.width.mas_equalTo([UIScreen mainScreen].bounds.size.width);
    }];

    for (int i=0; i<self.actionTitles.count; i++) {
        UIView *actionView = [[UIView alloc] init];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, kSheetHeight);
        [button setTitle:self.actionTitles[i] forState:UIControlStateNormal];
        button.tag = 100 + i;
        button.titleLabel.fontKey = kFont_Title_Nor;
        UIColor *color = i == self.highlightIndex ? [ZLThemeManager colorForKey:kThemeColor]:[ZLThemeManager colorForKey:kTextColor_Main];
        [button setTitleColor:color forState:UIControlStateNormal];
        [button addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [actionView addSubview:button];
        
        UIView *separate = [[UIView alloc] init];
        separate.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 0.5);
        separate.backgroundColorKey = kSeparateLineColor;
        [actionView addSubview:separate];
        
        actionView.frame = CGRectMake(0, kSheetHeight*i, [UIScreen mainScreen].bounds.size.width, kSheetHeight);
        [scrollView addSubview:actionView];
    }
    
    self.titleLabel.text = self.sheetTitle;
    self.cancelLabel.text = self.cancel;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)];
    [self.cancelLabel addGestureRecognizer:tap];
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelAction)];
    [self.bgView addGestureRecognizer:tap1];
}

- (void)action:(UIButton *)button {
    [self dismiss];
    NSInteger index = button.tag - 100;
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheetDidClickIndex:)]) {
        [self.delegate actionSheetDidClickIndex:index];
    }
}

- (void)cancelAction {
    [self dismiss];
    if (self.delegate && [self.delegate respondsToSelector:@selector(actionSheetDidClickCancel)]) {
        [self.delegate actionSheetDidClickCancel];
    }
}

- (void)showWithAnimate:(BOOL)animate {
    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        weakSelf.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [controller presentViewController:self animated:YES completion:nil];
        weakSelf.bgView.alpha = 0.5;
    });
}

- (void)dismiss {
    [self dismissViewControllerAnimated:NO completion:^{
        self.bgView.alpha = 0;
    }];
}

#pragma mark - getters

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
    }
    return _bgView;
}

- (UIView *)actionSheetView {
    if (!_actionSheetView) {
        _actionSheetView = [[UIView alloc] init];
        _actionSheetView.backgroundColorKey = kBackgroundColor;
        _actionSheetView.layer.cornerRadius = 6;
        _actionSheetView.clipsToBounds = YES;
    }
    return _actionSheetView;
}

- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.fontKey = kFont_Text_Nor;
        _titleLabel.textColorKey = kTextColor_Minor;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor whiteColor];
    }
    return _titleLabel;
}

- (UILabel *)cancelLabel {
    if (!_cancelLabel) {
        _cancelLabel = [[UILabel alloc] init];
        _cancelLabel.textColorKey = kTextColor_Main;
        _cancelLabel.fontKey = kFont_Title_Nor;
        _cancelLabel.textAlignment = NSTextAlignmentCenter;
        _cancelLabel.backgroundColor = [UIColor whiteColor];
        _cancelLabel.userInteractionEnabled = YES;
    }
    return _cancelLabel;
}
@end
