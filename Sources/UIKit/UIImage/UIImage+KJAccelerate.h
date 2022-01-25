//
//  UIImage+KJAccelerate.h
//  KJEmitterView
//
//  Created by 77。 on 2019/7/24.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// http://www.invasivecode.com/weblog/ios-image-processing-with-the-accelerate/
// https://developer.apple.com/library/archive/releasenotes/General/iOS10APIDiffs/Objective-C/Accelerate.html
@interface UIImage (KJAccelerate)

/// Picture rotation
- (UIImage *)kj_rotateInRadians:(CGFloat)radians;

#pragma mark - Obfuscation

- (UIImage *)kj_blurImageSoft;
- (UIImage *)kj_blurImageLight;
- (UIImage *)kj_blurImageExtraLight;
- (UIImage *)kj_blurImageDark;

/// Specify the color linear blur
- (UIImage *)kj_blurImageWithTintColor:(UIColor *)color;

/// Linear blur (reserved transparent area) range 0 ~ 1
- (UIImage *)kj_linearBlurryImageBlur:(CGFloat)blur;

/// Blur processing
/// @param radius blur radius
/// @param color blur color
/// @param maskImage blur mask
/// @return returns the blurred image
- (UIImage *)kj_blurImageWithRadius:(CGFloat)radius
                              color:(UIColor *)color
                          maskImage:(UIImage* _Nullable)maskImage;

#pragma mark - Morphological image rendering

/// Balance calculation
- (UIImage *)kj_equalizationImage;
/// erosion
- (UIImage *)kj_erodeImage;
/// Form expansion/expansion
- (UIImage *)kj_dilateImage;
/// Multiple erosion
- (UIImage *)kj_erodeImageWithIterations:(int)iterations;
/// Form multiple expansion/expansion
- (UIImage *)kj_dilateImageWithIterations:(int)iterations;
/// Gradient
- (UIImage *)kj_gradientImageWithIterations:(int)iterations;
/// Top hat calculation
- (UIImage *)kj_tophatImageWithIterations:(int)iterations;
/// Black hat computing
- (UIImage *)kj_blackhatImageWithIterations:(int)iterations;

#pragma mark - Convolution processing

/// Convolution processing
- (UIImage *)kj_convolutionImageWithKernel:(int16_t *)kernel;
/// Sharpen
- (UIImage *)kj_sharpenImage;
/// Sharpen
- (UIImage *)kj_sharpenImageWithIterations:(int)iterations;
/// relief
- (UIImage *)kj_embossImage;
/// Gauss
- (UIImage *)kj_gaussianImage;
/// Edge detection
- (UIImage *)kj_marginImage;
/// Edge detection
- (UIImage *)kj_edgeDetection;

@end

NS_ASSUME_NONNULL_END
