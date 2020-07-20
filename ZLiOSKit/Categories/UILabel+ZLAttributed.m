//
//  UILabel+ZLAttributed.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/7/2.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "UILabel+ZLAttributed.h"

@implementation UILabel (ZLAttributed)

-(void)setLineSpace:(CGFloat)space {
    [self setLineSpace:space text:self.text];
}

-(void)setLineSpace:(CGFloat)space text:(NSString *)text {
    if (text == nil) {
        return;
    }
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = space; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:self.font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                          };
    NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:text attributes:dic];
    self.attributedText = attributeStr;
}
    
@end
