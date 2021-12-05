//
//  UIColor+KJGradient.h
//  KJCategories
//
//  Created by 77。 on 2021/11/7.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (KJGradient)

/// 图片生成颜色
+ (UIColor *)kj_colorWithImage:(UIImage *)image;

/// 可变参数渐变色
/// @param size 渐变色尺寸框
/// @param color 不定数量渐变色，需以nil结尾
- (UIColor *)kj_gradientSize:(CGSize)size color:(UIColor *)color,... NS_REFINED_FOR_SWIFT;

/// 竖直渐变颜色
/// @param color 结束颜色
/// @param height 渐变色高度
/// @return 返回竖直渐变颜色
- (UIColor *)kj_gradientVerticalToColor:(UIColor *)color height:(CGFloat)height;

/// 横向渐变颜色
/// @param color 结束颜色
/// @param width 渐变色宽度
/// @return 返回横向渐变颜色
- (UIColor *)kj_gradientAcrossToColor:(UIColor *)color width:(CGFloat)width;

/// 生成附带边框的渐变色图片
/// @param colors 渐变色数组
/// @param locations 渐变色每组所占比例
/// @param size 尺寸
/// @param borderWidth 边框宽度
/// @param borderColor 边框颜色
+ (UIImage *)kj_colorImageWithColors:(NSArray<UIColor *> *)colors
                           locations:(NSArray<NSNumber *> *)locations
                                size:(CGSize)size
                         borderWidth:(CGFloat)borderWidth
                         borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
