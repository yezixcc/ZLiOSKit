//
//  LocalImageCell.m
//  ZKCycleScrollViewDemo-OC
//
//  Created by bestdew on 2019/3/21.
//  Copyright © 2019 bestdew. All rights reserved.
//

#import "LocalImageCell.h"

@interface LocalImageCell ()

@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@end

@implementation LocalImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgImageView.layer.cornerRadius = 6;
    [self.bgImageView.layer setMasksToBounds:YES];
}

@end
