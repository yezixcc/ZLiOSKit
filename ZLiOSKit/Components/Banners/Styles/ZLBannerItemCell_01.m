//
//  ZLBannerItemCell_01.m
//  iOSZlfund
//
//  Created by yezixcc on 2019/12/2.
//  Copyright © 2019 zlfund. All rights reserved.
//

#import "ZLBannerItemCell_01.h"
/// models
#import "ZLNewsModel.h"
/// kits
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <Masonry/Masonry.h>
#import "ZLTheme.h"

@implementation ZLBannerItemCell_01

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        [self.imageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.contentView).insets(UIEdgeInsetsZero);
        }];
    }
    return self;
}

- (void)reloadData:(id)data {
    if ([data isKindOfClass:[ZLNewsModel class]]) {
        ZLNewsModel *model = (ZLNewsModel *)data;
        UIImage *defaultImage = [ZLThemeManager imageForImageName:@"滚动默认图"];
        NSURL *imageUrl = [NSURL URLWithString:model.imageUrl];
        [self.imageView setImageWithURL:imageUrl placeholderImage:defaultImage];
    }else {
        self.imageView.image = nil;
    }
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

@end
