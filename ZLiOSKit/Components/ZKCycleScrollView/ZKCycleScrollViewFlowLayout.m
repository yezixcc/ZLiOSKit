//
//  ZKCycleScrollViewFlowLayout.m
//  ZKCycleScrollViewDemo-OC
//
//  Created by bestdew on 2019/3/21.
//  Copyright © 2019 bestdew. All rights reserved.
//
//                      d*##$.
// zP"""""$e.           $"    $o
//4$       '$          $"      $
//'$        '$        J$       $F
// 'b        $k       $>       $
//  $k        $r     J$       d$
//  '$         $     $"       $~
//   '$        "$   '$E       $
//    $         $L   $"      $F ...
//     $.       4B   $      $$$*"""*b
//     '$        $.  $$     $$      $F
//      "$       R$  $F     $"      $
//       $k      ?$ u*     dF      .$
//       ^$.      $$"     z$      u$$$$e
//        #$b             $E.dW@e$"    ?$
//         #$           .o$$# d$$$$c    ?F
//          $      .d$$#" . zo$>   #$r .uF
//          $L .u$*"      $&$$$k   .$$d$$F
//           $$"            ""^"$$$P"$P9$
//          JP              .o$$$$u:$P $$
//          $          ..ue$"      ""  $"
//         d$          $F              $
//         $$     ....udE             4B
//          #$    """"` $r            @$
//           ^$L        '$            $F
//             RN        4N           $
//              *$b                  d$
//               $$k                 $F
//               $$b                $F
//                 $""               $F
//                 '$                $
//                  $L               $
//                  '$               $
//                   $               $

#import "ZKCycleScrollViewFlowLayout.h"

@implementation ZKCycleScrollViewFlowLayout

- (instancetype)init {
    if (self = [super init]) {
        
        _zoomScale = 1.f;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        
        _zoomScale = 1.f;
    }
    return self;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributes = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            CGFloat offset = CGRectGetMidY(self.collectionView.bounds);
            CGFloat distanceForScale = self.itemSize.height + self.minimumLineSpacing;
            for (UICollectionViewLayoutAttributes *attr in attributes) {
                CGFloat scale = 0.f;
                CGFloat distance = ABS(offset - attr.center.y);
                if (distance >= distanceForScale) {
                    scale = _zoomScale;
                } else if (distance == 0.f) {
                    scale = 1.f;
                    attr.zIndex = 1;
                } else {
                    scale = _zoomScale + (distanceForScale - distance) * (1.f - _zoomScale) / distanceForScale;
                }
                attr.transform = CGAffineTransformMakeScale(scale, scale);
            }
            break;
        }
        default: {
//            for (int i = 0; i<attributes.count; i++) {
//                UICollectionViewLayoutAttributes *attr = attributes[i];
//                if (i>0) {
//                    UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i-1];
//                    CGFloat maximumSpacing = 15; //这里设置最大间距
//                    CGFloat origin = CGRectGetMaxX(prevLayoutAttributes.frame);
//                   if(origin + maximumSpacing + attr.frame.size.width < self.collectionViewContentSize.width) {
//                       CGRect frame = attr.frame;
//                       frame.origin.x = origin + maximumSpacing;
//                       attr.frame = frame;
//                   }
//                }
//            }
            CGFloat offset = CGRectGetMidX(self.collectionView.bounds);
            CGFloat distanceForScale = self.itemSize.width + self.minimumLineSpacing;
            for (UICollectionViewLayoutAttributes *attr in attributes) {
                CGFloat scale = 0.f;
                CGFloat distance = ABS(offset - attr.center.x);
                if (distance >= distanceForScale) {
                    scale = _zoomScale;
                } else if (distance == 0.f) {
                    scale = 1.f;
                    attr.zIndex = 1;
                } else {
                    scale = _zoomScale + (distanceForScale - distance) * (1.f - _zoomScale) / distanceForScale;
                }
                attr.transform = CGAffineTransformMakeScale(scale, scale);
            }
            break;
        }
    }
    return attributes;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    switch (self.scrollDirection) {
        case UICollectionViewScrollDirectionVertical: {
            // 计算出最终显示的矩形框
            CGRect rect;
            rect.origin.x = 0.f;
            rect.origin.y = proposedContentOffset.y;
            rect.size = self.collectionView.frame.size;

            // 计算collectionView最中心点的y值
            CGFloat centerY = proposedContentOffset.y + self.collectionView.frame.size.height * 0.5;

            // 存放最小的间距值
            CGFloat minDelta = MAXFLOAT;
            // 获得super已经计算好的布局属性
            NSArray *array = [super layoutAttributesForElementsInRect:rect];

            for (UICollectionViewLayoutAttributes *attrs in array) {
                if (ABS(minDelta) > ABS(attrs.center.y - centerY)) {
                    minDelta = attrs.center.y - centerY;
                }
            }
            // 修改原有的偏移量
            proposedContentOffset.y += minDelta;
            break;
        }
        default: {
            // 计算出最终显示的矩形框
            CGRect rect;
            rect.origin.y = 0.f;
            rect.origin.x = proposedContentOffset.x;
            rect.size = self.collectionView.frame.size;

            // 计算collectionView最中心点的x值
            CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;

            // 存放最小的间距值
            CGFloat minDelta = MAXFLOAT;
            // 获得super已经计算好的布局属性
            NSArray *array = [super layoutAttributesForElementsInRect:rect];

            for (UICollectionViewLayoutAttributes *attrs in array) {
                if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
                    minDelta = attrs.center.x - centerX;
                }
            }
            // 修改原有的偏移量
            proposedContentOffset.x += minDelta;
            break;
        }
    }
    return proposedContentOffset;
}

@end
