//
//  UIImage+KJDoraemonBox.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  图片百宝箱

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJDoraemonBox)

/// 获取图片平均颜色
- (UIColor *)kj_getImageAverageColor;

/// 获得灰度图
- (UIImage *)kj_getGrayImage;

/// 绘制图片
- (UIImage *)kj_mallocDrawImage;

/// 图片透明区域点击穿透处理
/// @param point 点坐标
- (bool)kj_transparentWithPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
