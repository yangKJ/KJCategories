//
//  UIColor+KJExtension2.h
//  KJEmitterView
//
//  Created by 77。 on 2021/10/28.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger,KJGradietColorType) {
    KJGradietColorTypeTopToBottom = 0,
    KJGradietColorTypeLeftToRight = 1,
    KJGradietColorTypeUpLeftToLowRight,
    KJGradietColorTypeUpRightToLowLeft,
};
@interface UIColor (KJExtension2)

/// Gradient color
/// @param colors gradient color array
/// @param type gradient type
/// @param size Gradient color size
+ (UIColor *)kj_gradientColorWithColors:(NSArray *)colors
                           gradientType:(KJGradietColorType)type
                                   size:(CGSize)size;

/// Get the average value of the color
+ (UIColor *)kj_averageColors:(NSArray<UIColor*> *)colors;

/// Get the color of the specified point on the picture
+ (UIColor *)kj_colorAtImage:(UIImage *)image Point:(CGPoint)point;

/// Get the image color of the specified point on the ImageView
+ (UIColor *)kj_colorAtImageView:(UIImageView *)imageView Point:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
