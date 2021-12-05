//
//  NSString+KJSize.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/8/10.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  文字尺寸

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJSize)

/// 获取文本宽度
/// @param font 字体
/// @param height 固定高度
/// @param alignment 对齐方式
/// @param linebreakMode 行类型
/// @param lineSpace 行间距
- (CGFloat)kj_maxWidthWithFont:(UIFont *)font
                        Height:(CGFloat)height
                     Alignment:(NSTextAlignment)alignment
                 LinebreakMode:(NSLineBreakMode)linebreakMode
                     LineSpace:(CGFloat)lineSpace;

/// 获取文本高度
/// @param font 字体
/// @param width 固定宽度
/// @param alignment 对齐方式
/// @param linebreakMode 行类型
/// @param lineSpace 行间距
- (CGFloat)kj_maxHeightWithFont:(UIFont *)font
                          Width:(CGFloat)width
                      Alignment:(NSTextAlignment)alignment
                  LinebreakMode:(NSLineBreakMode)linebreakMode
                      LineSpace:(CGFloat)lineSpace;

/// 计算字符串高度尺寸
/// @param font 字体
/// @param size 尺寸
/// @param spacing 行间距
- (CGSize)kj_textSizeWithFont:(UIFont *)font
                    superSize:(CGSize)size
                      spacing:(CGFloat)spacing;
/// 文字转图片
/// @param size 尺寸
/// @param color 颜色
/// @param attributes 参数
- (UIImage *)kj_textBecomeImageWithSize:(CGSize)size
                        BackgroundColor:(UIColor *)color
                         TextAttributes:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
