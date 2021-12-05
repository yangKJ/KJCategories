//
//  UIImage+KJQRCode.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  二维码/条形码生成器

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJQRCode)

/// 将字符串转成条形码
/// @param content 二维码内容
/// @return 返回二维码图片
+ (UIImage *)kj_barCodeImageWithContent:(NSString *)content;

/// 生成二维码
/// @param content 二维码内容
/// @param size 二维码尺寸
/// @return 返回二维码图片
+ (UIImage *)kj_QRCodeImageWithContent:(NSString *)content
                         codeImageSize:(CGFloat)size;
/// 生成指定颜色二维码
/// @param content 二维码内容
/// @param size 二维码尺寸
/// @param color 二维码颜色
/// @return 返回二维码图片
+ (UIImage *)kj_QRCodeImageWithContent:(NSString *)content
                         codeImageSize:(CGFloat)size
                                 color:(UIColor *)color;
/// 生成条形码
/// @param content 条形码内容
/// @param size 条形码尺寸
/// @return 返回条形码图片
+ (UIImage *)kj_barcodeImageWithContent:(NSString *)content
                          codeImageSize:(CGFloat)size;
/// 生成指定颜色条形码
/// @param content 条形码内容
/// @param size 条形码尺寸
/// @param color 条形码颜色
/// @return 返回条形码图片
+ (UIImage *)kj_barcodeImageWithContent:(NSString *)content
                          codeImageSize:(CGFloat)size
                                  color:(UIColor *)color;
/// 异步生成二维码
/// @param codeImage 生成二维码回调
/// @param content 二维码内容
/// @param size 二维码尺寸
extern void kQRCodeImage(void(^codeImage)(UIImage * image), NSString * content, CGFloat size);

/// 异步生成指定颜色二维码
/// @param codeImage 生成二维码回调
/// @param content 二维码内容
/// @param size 二维码尺寸
/// @param color 二维码颜色
extern void kQRCodeImageFromColor(void(^codeImage)(UIImage * image),
                                  NSString * content,
                                  CGFloat size, UIColor * color);

@end

NS_ASSUME_NONNULL_END
