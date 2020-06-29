//
//  ZKPageControl.h
//  iOSCat
//
//  Created by jqq on 2019/7/5.
//  Copyright © 2019 zlfund. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKPageControl : UIPageControl

@property (nonatomic, strong) UIImage *currentImage;
@property (nonatomic, strong) UIImage *inactiveImage;

@property (nonatomic, assign) CGSize currentImageSize;
@property (nonatomic, assign) CGSize inactiveImageSize;

@end

