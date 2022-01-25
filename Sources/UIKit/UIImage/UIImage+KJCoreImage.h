//
//  UIImage+KJCoreImage.h
//  KJEmitterView
//
//  Created by 77。 on 2019/7/24.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJCoreImagePhotoshopType) {
    KJCoreImagePhotoshopTypeBrightnes, /// Brightness, -1～1 The larger the number, the brighter
    KJCoreImagePhotoshopTypeSaturation, /// Saturation 0 ～ 2
    KJCoreImagePhotoshopTypeContrast, /// Contrast 0 ～ 4
    KJCoreImagePhotoshopTypeAngle, /// Hue, angle -π ～ π
    KJCoreImagePhotoshopTypeExposure, /// Exposure,
    KJCoreImagePhotoshopTypeSharpness, /// Sharpen, 0～100
    KJCoreImagePhotoshopTypePower, /// Gamma adjustment (adjusting the gamma can effectively change the transition slope between black and white) 0 ～ 1
    KJCoreImagePhotoshopTypeGaussianBlur, /// Gaussian blur, blur radius 0～100
};
/// Filter filter
static NSString * const _Nonnull KJImageFilterTypeStringMap[] = {
    [KJCoreImagePhotoshopTypeBrightnes] = @"CIColorControls", /// Color control
    [KJCoreImagePhotoshopTypeSaturation] = @"CIColorControls",
    [KJCoreImagePhotoshopTypeContrast] = @"CIColorControls",
    [KJCoreImagePhotoshopTypeAngle] = @"CIHueAdjust", /// Hue filter
    [KJCoreImagePhotoshopTypeExposure] = @"CIExposureAdjust",/// Exposure filter
    [KJCoreImagePhotoshopTypeSharpness] = @"CISharpenLuminance",/// Detail sharpening filter
    [KJCoreImagePhotoshopTypePower] = @"CIGammaAdjust",/// Gamma adjustment
    [KJCoreImagePhotoshopTypeGaussianBlur] = @"CIGaussianBlur",/// Gaussian Blur
};
static NSString * const _Nonnull KJCoreImagePhotoshopTypeStringMap[] = {
    [KJCoreImagePhotoshopTypeBrightnes]  = @"inputBrightness",
    [KJCoreImagePhotoshopTypeSaturation] = @"inputSaturation",
    [KJCoreImagePhotoshopTypeContrast]   = @"inputContrast",
    [KJCoreImagePhotoshopTypeAngle]      = @"inputAngle",
    [KJCoreImagePhotoshopTypeExposure]   = @"inputEV",
    [KJCoreImagePhotoshopTypeSharpness]  = @"inputSharpness",
    [KJCoreImagePhotoshopTypePower]      = @"inputPower",
    [KJCoreImagePhotoshopTypeGaussianBlur] = @"inputRadius",
};

//  The CoreImage framework is organized. Here we choose GPU-based image processing
//  https://developer.apple.com/library/archive/documentation/GraphicsImaging/Reference/CoreImageFilterReference/index.html#//apple_ref/doc/filter/ci/CIAccordionFoldTransition
@interface UIImage (KJCoreImage)

/// Photoshop filter related operations
- (UIImage *)kj_coreImagePhotoshopWithType:(KJCoreImagePhotoshopType)type Value:(CGFloat)value;

/// General method-pass in the filter name and required parameters
- (UIImage *)kj_coreImageCustomWithName:(NSString*_Nonnull)name Dicts:(NSDictionary*_Nullable)dicts;

/// Adjust the tone mapping of the image
/// @param highlight highlight
/// @param shadow shadow
- (UIImage *)kj_coreImageHighlightShadowWithHighlightAmount:(CGFloat)highlight
                                               shadowAmount:(CGFloat)shadow;

/// Make the black in the picture transparent
- (UIImage *)kj_coreImageBlackMaskToAlpha;

/// Mosaic
- (UIImage *)kj_coreImagePixellateWithCenter:(CGPoint)center Scale:(CGFloat)scale;

/// Picture circular deformation
- (UIImage *)kj_coreImageCircularWrapWithCenter:(CGPoint)center
                                         Radius:(CGFloat)radius
                                          Angle:(CGFloat)angle;
/// Ring lens distortion
- (UIImage *)kj_coreImageTorusLensDistortionCenter:(CGPoint)center
                                            Radius:(CGFloat)radius
                                             Width:(CGFloat)width
                                        Refraction:(CGFloat)refraction;

/// Empty deformation
- (UIImage *)kj_coreImageHoleDistortionCenter:(CGPoint)center Radius:(CGFloat)radius;

/// Apply perspective correction to convert any quadrilateral area in the source image into a rectangular output image
- (UIImage *)kj_coreImagePerspectiveCorrectionWithTopLeft:(CGPoint)TopLeft
                                                 TopRight:(CGPoint)TopRight
                                              BottomRight:(CGPoint)BottomRight
                                               BottomLeft:(CGPoint)BottomLeft;

/// Perspective transformation, perspective filter tilts the image
- (UIImage *)kj_coreImagePerspectiveTransformWithTopLeft:(CGPoint)TopLeft
                                                TopRight:(CGPoint)TopRight
                                             BottomRight:(CGPoint)BottomRight
                                              BottomLeft:(CGPoint)BottomLeft;

/// Picture compression
- (UIImage *)kj_coreImageChangeImageSize:(CGSize)size;

/// Soft decoration exclusive perspective-there is a corresponding coordinate conversion inside
- (UIImage *)kj_softFitmentFluoroscopyWithTopLeft:(CGPoint)TopLeft
                                         TopRight:(CGPoint)TopRight
                                      BottomRight:(CGPoint)BottomRight
                                       BottomLeft:(CGPoint)BottomLeft;

@end

NS_ASSUME_NONNULL_END
