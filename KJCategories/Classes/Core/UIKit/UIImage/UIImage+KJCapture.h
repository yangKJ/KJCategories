//
//  UIImage+KJCapture.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  截图处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJCapture)

/// 当前视图截图
+ (UIImage *)kj_captureScreen:(UIView *)view;

/// 指定位置屏幕截图
/// @param view 截图控件
/// @param rect 截取尺寸
+ (UIImage *)kj_captureScreen:(UIView *)view Rect:(CGRect)rect;

/// 自定义质量的截图
/// @param view 被截取视图
/// @param rect 截取尺寸
/// @param quality 质量倍数
/// @return 返回截图
+ (UIImage *)kj_captureScreen:(UIView *)view Rect:(CGRect)rect Quality:(NSInteger)quality;

/// 截取当前屏幕（窗口截图）
+ (UIImage *)kj_captureScreenWindow;

/// 截取当前屏幕（根据手机方向旋转）
+ (UIImage *)kj_captureScreenWindowForInterfaceOrientation;

/// 截取滚动视图的长图
/// @param scroll 截取视图
/// @param contentOffset 开始截取位置
/// @return 返回截图
+ (UIImage *)kj_captureScreenWithScrollView:(UIScrollView *)scroll
                              contentOffset:(CGPoint)contentOffset;

@end

NS_ASSUME_NONNULL_END
