//
//  UIImage+KJExtension.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJExtension)

/// 生成颜色图片
/// @param color 生成图片颜色，支持渐变色
/// @param size 图片尺寸
+ (UIImage *)kj_imageWithColor:(UIColor *)color size:(CGSize)size;

/// 改变图片背景颜色
/// @param color 目标颜色
- (UIImage *)kj_changeImageColor:(UIColor *)color;

/// 改变图片内部像素颜色
/// @param color 像素颜色
- (UIImage *)kj_changeImagePixelColor:(UIColor *)color;

/// 改变图片透明度
/// @param alpha 透明度，0 - 1
- (UIImage *)kj_changeImageAlpha:(CGFloat)alpha;

/// 改变图片亮度
/// @param luminance 亮度，0 - 1
- (UIImage *)kj_changeImageLuminance:(CGFloat)luminance;

/// 修改图片线条颜色
/// @param color 修改颜色
- (UIImage *)kj_imageLinellaeColor:(UIColor *)color;

/// 图层混合，https://blog.csdn.net/yignorant/article/details/77864887
/// @param blendMode 混合类型
/// @param tintColor 颜色
/// @return 返回混合之后的图片
- (UIImage *)kj_imageBlendMode:(CGBlendMode)blendMode tineColor:(UIColor *)tintColor;

@end

NS_ASSUME_NONNULL_END
