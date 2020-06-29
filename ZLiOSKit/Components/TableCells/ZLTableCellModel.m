//
//  ZLTableCellModel.m
//  iOSZlfund
//
//  Created by yezixcc on 2020/5/25.
//  Copyright © 2020 zlfund. All rights reserved.
//

#import "ZLTableCellModel.h"
#import "ZLTableCellContainer.h"

@implementation ZLTableCellModel

- (instancetype)initWithStyle:(ZLTableCellStyle)style {
    return [self initWithTitle:nil style:style];
}
- (instancetype)initWithTitle:(NSString *)title
                        style:(ZLTableCellStyle)style {
    return [self initWithTitle:title
                      subTitle:nil
                         style:style];
}
- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                        style:(ZLTableCellStyle)style {
    return [self initWithTitle:title
                      subTitle:subTitle
                    centerText:nil
                         style:style];
}
- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                   centerText:(NSString *)centerText
                        style:(ZLTableCellStyle)style {
    return [self initWithTitle:title
                   centerTitle:nil
                      subTitle:subTitle
                    centerText:centerText
                         style:style];
}
- (instancetype)initWithCenterTitle:(NSString *)centerTitle
                              style:(ZLTableCellStyle)style {
    return [self initWithTitle:nil
                   centerTitle:centerTitle
                      subTitle:nil
                    centerText:nil
                         style:style];
}
- (instancetype)initWithTitle:(NSString *)title
                  centerTitle:(NSString *)centerTitle
                     subTitle:(NSString *)subTitle
                   centerText:(NSString *)centerText
                        style:(ZLTableCellStyle)style {
    self = [super init];
    if (self) {
        _style = style;
        _title = title;
        _centerTitle = centerTitle;
        _subTitle = subTitle;
        _centerText = centerText;
        switch (_style) {
            case ZLTableCellStyleIndicator:
            case ZLTableCellStyleSubtitleAndIndicator:
            case ZLTableCellStyleCenterTextAndIndicator:
            case ZLTableCellStyleTextFieldAndIndicator:
                _indicatorImageName = @"指示器";
                break;
            case ZLTableCellStyleTextFieldAndIndicatorEditButton:
                _indicatorImageName = @"编辑";
                break;
            default:
                break;
        }
    }
    return self;
}

- (NSString *)title {
    if (_title) {
        return _title;
    }
    return self.cell.titleLabel.text;
}

- (NSString *)subTitle {
    if (_subTitle) {
        return _subTitle;
    }
    return self.cell.subTitleLabel.text;
}

- (NSString *)centerTitle {
    if (_centerTitle) {
        return _centerTitle;
    }
    return self.cell.centerTitleLabel.text;
}

- (NSString *)centerText {
    if (_centerText) {
        return _centerText;
    }
    return self.cell.centerTextLabel.text;
}

- (NSString *)textFieldPlacehold {
    if (_textFieldPlacehold) {
        return _textFieldPlacehold;
    }
    return self.cell.textField.placeholder;
}
@end
