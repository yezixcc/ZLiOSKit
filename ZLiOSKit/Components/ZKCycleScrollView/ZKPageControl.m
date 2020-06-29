//
//  ZKPageControl.m
//  iOSCat
//
//  Created by jqq on 2019/7/5.
//  Copyright © 2019 zlfund. All rights reserved.
//

#import "ZKPageControl.h"

@interface ZKPageControl()

@end


@implementation ZKPageControl

- (instancetype)init{
    self = [super init];
    if (self) {
        self.userInteractionEnabled = NO;
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updateDots];
}


- (void)updateDots{
    for (int i = 0; i < [self.subviews count]; i++) {
        UIImageView *dot = [self imageViewForSubview:[self.subviews objectAtIndex:i] currPage:i];
        if (i == self.currentPage){
            dot.backgroundColor = [UIColor colorWithRed:160/255.0 green:0 blue:25/255.0 alpha:1];
//            dot.image = self.currentImage;
//            if (i == 0) {
//                CGFloat x =  (self.bounds.size.width-self.inactiveImageSize.width*(self.numberOfPages-1)-self.currentImageSize.width-(self.numberOfPages-1)*4)/2;
//                dot.superview.frame = CGRectMake(x, dot.superview.frame.origin.y, self.currentImageSize.width, self.currentImageSize.height);
//                dot.frame = dot.superview.bounds;
//            }else {
//                UIView *lastView = [self.subviews objectAtIndex:i-1];
//                dot.superview.frame = CGRectMake(CGRectGetMaxX(lastView.frame)+4, dot.superview.frame.origin.y, self.currentImageSize.width, self.currentImageSize.height);
//                dot.frame = dot.superview.bounds;
//            }
        }else{
            dot.backgroundColor = [UIColor colorWithRed:193/255.0 green:193/255.0 blue:193/255.0 alpha:1];
//            dot.image = self.inactiveImage;
//            if (i == 0) {
//                CGFloat x =  (self.bounds.size.width-self.inactiveImageSize.width*(self.numberOfPages-1)-self.currentImageSize.width-(self.numberOfPages-1)*4)/2;
//                dot.superview.frame = CGRectMake(x, dot.superview.frame.origin.y, self.inactiveImageSize.width, self.inactiveImageSize.height);
//                dot.frame = dot.superview.bounds;
//            }else {
//                UIView *lastView = [self.subviews objectAtIndex:i-1];
//                dot.superview.frame = CGRectMake(CGRectGetMaxX(lastView.frame)+4, dot.superview.frame.origin.y, self.inactiveImageSize.width, self.inactiveImageSize.height);
//                dot.frame = dot.superview.bounds;
//            }
        }
    }
}

- (UIImageView *)imageViewForSubview:(UIView *)view currPage:(int)currPage {
    UIImageView *dot = nil;
    if ([view isKindOfClass:[UIView class]]) {
        for (UIView *subview in view.subviews) {
            if ([subview isKindOfClass:[UIImageView class]]) {
                dot = (UIImageView *)subview;
                break;
            }
        }
        
        if (dot == nil) {
            dot = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 10, 2)];
            
            [view addSubview:dot];
        }
    }else {
        dot = (UIImageView *)view;
    }
    
    return dot;
}

@end
