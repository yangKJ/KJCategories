//
//  UIImage+KJMask.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJImageWaterType) {
    KJImageWaterTypeTopLeft = 0,
    KJImageWaterTypeTopRight,
    KJImageWaterTypeBottomLeft,
    KJImageWaterTypeBottomRight,
    KJImageWaterTypeCenter,
};
@interface UIImage (KJMask)

/// Text watermark
/// @param text text content
/// @param direction Watermark position
/// @param color text color
/// @param font text font
/// @param margin display position
/// @return returns the watermarked picture
- (UIImage *)kj_waterText:(NSString *)text
                direction:(KJImageWaterType)direction
                textColor:(UIColor *)color
                     font:(UIFont *)font
                   margin:(CGPoint)margin;

/// Picture watermark
/// @param image watermark image
/// @param direction Watermark position
/// @param size watermark size
/// @param margin watermark position
/// @return returns the watermarked picture
- (UIImage *)kj_waterImage:(UIImage *)image
                 direction:(KJImageWaterType)direction
                 waterSize:(CGSize)size
                    margin:(CGPoint)margin;

/// Add watermark to picture
/// @param mark watermark image
/// @param rect watermark position
/// @return returns the watermarked picture
- (UIImage *)kj_waterMark:(UIImage *)mark InRect:(CGRect)rect;

/// Mask image processing
/// @param maskImage mask image
- (UIImage *)kj_maskImage:(UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
