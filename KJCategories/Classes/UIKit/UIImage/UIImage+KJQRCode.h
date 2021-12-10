//
//  UIImage+KJQRCode.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJQRCode)

/// Convert string to barcode
/// @param content QR code content
/// @return returns the QR code image
+ (UIImage *)kj_barCodeImageWithContent:(NSString *)content;

/// Generate QR code
/// @param content QR code content
/// @param size QR code size
/// @return returns the QR code image
+ (UIImage *)kj_QRCodeImageWithContent:(NSString *)content
                         codeImageSize:(CGFloat)size;

/// Generate the specified color QR code
/// @param content QR code content
/// @param size QR code size
/// @param color QR code color
/// @return returns the QR code image
+ (UIImage *)kj_QRCodeImageWithContent:(NSString *)content
                         codeImageSize:(CGFloat)size
                                 color:(UIColor *)color;

/// Generate barcode
/// @param content barcode content
/// @param size barcode size
/// @return returns the barcode image
+ (UIImage *)kj_barcodeImageWithContent:(NSString *)content
                          codeImageSize:(CGFloat)size;

/// Generate barcode of specified color
/// @param content barcode content
/// @param size barcode size
/// @param color barcode color
/// @return returns the barcode image
+ (UIImage *)kj_barcodeImageWithContent:(NSString *)content
                          codeImageSize:(CGFloat)size
                                  color:(UIColor *)color;

/// Generate QR code asynchronously
/// @param codeImage Generate QR code callback
/// @param content QR code content
/// @param size QR code size
extern void kQRCodeImage(void(^codeImage)(UIImage * image), NSString * content, CGFloat size);

/// Generate the specified color QR code asynchronously
/// @param codeImage Generate QR code callback
/// @param content QR code content
/// @param size QR code size
/// @param color QR code color
extern void kQRCodeImageFromColor(void(^codeImage)(UIImage * image),
                                  NSString * content,
                                  CGFloat size, UIColor * color);

@end

NS_ASSUME_NONNULL_END
