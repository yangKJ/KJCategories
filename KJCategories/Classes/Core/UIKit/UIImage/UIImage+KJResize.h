//
//  UIImage+KJResize.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  图片尺寸相关

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJResize)

/// 通过比例来缩放图片
/// @param scale 缩放比例
- (UIImage *)kj_scaleImage:(CGFloat)scale;

/// 以固定宽度缩放图像
/// @param width 固定宽度
- (UIImage *)kj_scaleWithFixedWidth:(CGFloat)width;

/// 以固定高度缩放图像
/// @param height 固定高度
- (UIImage *)kj_scaleWithFixedHeight:(CGFloat)height;

/// 等比改变图片尺寸
/// @param size 尺寸框
- (UIImage *)kj_cropImageWithAnySize:(CGSize)size;

/// 等比缩小图片尺寸
/// @param size 缩小尺寸
- (UIImage *)kj_zoomImageWithMaxSize:(CGSize)size;

/// 不拉升填充图片
/// @param size 填充尺寸
- (UIImage *)kj_fitImageWithSize:(CGSize)size;

/// 旋转图片和镜像处理
/// @param orientation 旋转方向
- (UIImage *)kj_rotationImageWithOrientation:(UIImageOrientation)orientation;

/// 椭圆形图片，图片长宽不等会出现切出椭圆
- (UIImage *)kj_ellipseImage;

/// 圆形图片
- (UIImage *)kj_circleImage;

/// 边框圆形图片
/// @param borderWidth 边框宽度
/// @param borderColor 边框颜色
/// @return 返回添加边框的图片
- (UIImage *)kj_squareCircleImageWithBorderWidth:(CGFloat)borderWidth
                                     borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
