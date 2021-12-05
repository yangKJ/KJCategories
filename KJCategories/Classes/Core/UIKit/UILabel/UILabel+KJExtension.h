//
//  UILabel+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/9/24.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  文本位置和尺寸获取

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (KJExtension)

/// 获取宽度
- (CGFloat)kj_calculateWidth;
/// 获取高度
- (CGFloat)kj_calculateHeightWithWidth:(CGFloat)width;

/// 获取高度，指定行高
/// @param width 固定宽度
/// @param height 一行文字高度
/// @return 返回总高度
- (CGFloat)kj_calculateHeightWithWidth:(CGFloat)width oneLineHeight:(CGFloat)height;

/// 获取文字尺寸
/// @param title 文字
/// @param font 字体
/// @param size 宽高尺寸
/// @param lineBreakMode 行类型
/// @return 返回文字尺寸
+ (CGSize)kj_calculateLabelSizeWithTitle:(NSString *)title
                                    font:(UIFont *)font
                       constrainedToSize:(CGSize)size
                           lineBreakMode:(NSLineBreakMode)lineBreakMode;
/// 改变行间距
- (void)kj_changeLineSpace:(float)space;
/// 改变字间距
- (void)kj_changeWordSpace:(float)space;
/// 改变行间距和段间距
- (void)kj_changeLineSpace:(float)space paragraphSpace:(float)paragraphSpace;
/// 改变行间距和字间距
- (void)kj_changeLineSpace:(float)lineSpace wordSpace:(float)wordSpace;

@end

NS_ASSUME_NONNULL_END
