//
//  UIColor+KJExtension2.h
//  KJEmitterView
//
//  Created by 77。 on 2021/10/28.
//  Copyright © 2021 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,KJGradietColorType) {
    KJGradietColorTypeTopToBottom = 0, /// 从上到下
    KJGradietColorTypeLeftToRight = 1, /// 从左到右
    KJGradietColorTypeUpLeftToLowRight,/// 从左上到右下
    KJGradietColorTypeUpRightToLowLeft,/// 从右上到左下
};
@interface UIColor (KJExtension2)

/// 渐变颜色
/// @param colors 渐变色数组
/// @param type 渐变类型
/// @param size 渐变色尺寸
+ (UIColor *)kj_gradientColorWithColors:(NSArray *)colors
                           gradientType:(KJGradietColorType)type
                                   size:(CGSize)size;

/// 获取颜色的均值
+ (UIColor *)kj_averageColors:(NSArray<UIColor*> *)colors;

/// 获取图片上指定点的颜色
+ (UIColor *)kj_colorAtImage:(UIImage *)image Point:(CGPoint)point;

/// 获取ImageView上指定点的图片颜色
+ (UIColor *)kj_colorAtImageView:(UIImageView *)imageView Point:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
