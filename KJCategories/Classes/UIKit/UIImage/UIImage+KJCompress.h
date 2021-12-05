//
//  UIImage+KJCompress.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  图片压缩相关

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJCompress)

/// 压缩图片到指定大小
/// @param maxLength 指定大小
- (UIImage *)kj_compressTargetByte:(NSUInteger)maxLength;
+ (UIImage *)kj_compressImage:(UIImage *)image TargetByte:(NSUInteger)maxLength;

/// UIKit方式
- (UIImage *)kj_UIKitChangeImageSize:(CGSize)size;

/// Quartz 2D
- (UIImage *)kj_QuartzChangeImageSize:(CGSize)size;

/// ImageIO，性能最优
- (UIImage *)kj_ImageIOChangeImageSize:(CGSize)size;

/// CoreGraphics
- (UIImage *)kj_BitmapChangeImageSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END
