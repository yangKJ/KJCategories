//
//  UIImage+KJCut.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  图片裁剪器相关

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJCut)

/// 不规则图形切图
/// @param view 裁剪视图
/// @param path 裁剪路径
/// @return 返回裁剪图
+ (UIImage *)kj_cutAnomalyImage:(UIView *)view bezierPath:(UIBezierPath *)path;

/// 多边形切图
/// @param view 裁剪视图
/// @param points 多边形点坐标
/// @return 返回裁剪图
+ (UIImage *)kj_cutPolygonImage:(UIImageView *)view pointArray:(NSArray *)points;

/// 指定区域裁剪
/// @param cropRect 裁剪区域
/// @return 返回裁剪图
- (UIImage *)kj_cutImageWithCropRect:(CGRect)cropRect;

/// quartz 2d 实现裁剪
/// @return 返回裁剪图
- (UIImage *)kj_quartzCutImageWithCropRect:(CGRect)cropRect;

/// 图片路径裁剪，裁剪路径 "以外" 部分
/// @param path 裁剪路径
/// @param rect 画布尺寸
/// @return 返回裁剪图
- (UIImage *)kj_cutOuterImageBezierPath:(UIBezierPath *)path rect:(CGRect)rect;

/// 图片路径裁剪，裁剪路径 "以内" 部分
/// @param path 裁剪路径
/// @param rect 画布尺寸
/// @return 返回裁剪图
- (UIImage *)kj_cutInnerImageBezierPath:(UIBezierPath *)path rect:(CGRect)rect;

/// 裁剪图片处理，以图片中心位置开始裁剪
/// @param size 裁剪尺寸
/// @return 返回裁剪图
- (UIImage *)kj_cutCenterClipImageWithSize:(CGSize)size;

/// 裁剪掉图片周围的透明部分
- (UIImage *)kj_cutRoundAlphaZero;

@end

NS_ASSUME_NONNULL_END
