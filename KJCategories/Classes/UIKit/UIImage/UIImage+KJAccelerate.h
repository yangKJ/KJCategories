//
//  UIImage+KJAccelerate.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/7/24.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  Accelerate 框架的图片处理
//  介绍文档：http://www.invasivecode.com/weblog/ios-image-processing-with-the-accelerate/
//  官网文档地址：https://developer.apple.com/library/archive/releasenotes/General/iOS10APIDiffs/Objective-C/Accelerate.html

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJAccelerate)
/// 图片旋转
- (UIImage *)kj_rotateInRadians:(CGFloat)radians;

#pragma mark - 模糊处理
- (UIImage *)kj_blurImageSoft;
- (UIImage *)kj_blurImageLight;
- (UIImage *)kj_blurImageExtraLight;
- (UIImage *)kj_blurImageDark;
/// 指定颜色线性模糊
- (UIImage *)kj_blurImageWithTintColor:(UIColor *)color;
/// 线性模糊（保留透明区域）范围 0 ~ 1
- (UIImage *)kj_linearBlurryImageBlur:(CGFloat)blur;
/// 模糊处理
/// @param radius 模糊半径
/// @param color 模糊颜色
/// @param maskImage 模糊蒙板
/// @return 返回模糊处理之后的图片
- (UIImage *)kj_blurImageWithRadius:(CGFloat)radius
                              color:(UIColor *)color
                          maskImage:(UIImage* _Nullable)maskImage;

#pragma mark - 形态学图像渲染
/// 均衡运算
- (UIImage *)kj_equalizationImage;
/// 侵蚀
- (UIImage *)kj_erodeImage;
/// 形态膨胀/扩张
- (UIImage *)kj_dilateImage;
/// 多倍侵蚀
- (UIImage *)kj_erodeImageWithIterations:(int)iterations;
/// 形态多倍膨胀/扩张
- (UIImage *)kj_dilateImageWithIterations:(int)iterations;
/// 梯度
- (UIImage *)kj_gradientImageWithIterations:(int)iterations;
/// 顶帽运算
- (UIImage *)kj_tophatImageWithIterations:(int)iterations;
/// 黑帽运算
- (UIImage *)kj_blackhatImageWithIterations:(int)iterations;

#pragma mark - 卷积处理
/// 卷积处理
- (UIImage *)kj_convolutionImageWithKernel:(int16_t *)kernel;
/// 锐化
- (UIImage *)kj_sharpenImage;
/// 锐化
- (UIImage *)kj_sharpenImageWithIterations:(int)iterations;
/// 浮雕
- (UIImage *)kj_embossImage;
/// 高斯
- (UIImage *)kj_gaussianImage;
/// 边缘检测
- (UIImage *)kj_marginImage;
/// 边缘检测
- (UIImage *)kj_edgeDetection;

@end

NS_ASSUME_NONNULL_END
