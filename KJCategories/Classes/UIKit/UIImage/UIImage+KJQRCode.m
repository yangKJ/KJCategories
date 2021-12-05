//
//  UIImage+KJQRCode.m
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories


#import "UIImage+KJQRCode.h"
#import <CoreImage/CoreImage.h>

@implementation UIImage (KJQRCode)

#pragma mark - 二维码/条形码生成器
+ (CIImage*)kj_QRCodeImageWithContent:(NSString *)content{
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [filter setDefaults];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKeyPath:@"inputMessage"];
    return [filter outputImage];
}
/// 生成二维码
+ (UIImage *)kj_QRCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size{
    CIImage *image = [self kj_QRCodeImageWithContent:content];
    return [self kj_changeCIImage:image codeImageSize:size];
}
/// 生成指定颜色二维码
+ (UIImage *)kj_QRCodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size color:(UIColor *)color{
    UIImage *image = [self kj_QRCodeImageWithContent:content codeImageSize:size];
    return kChangeImagePixelColor(image, color);
}

#pragma mark - 条形码
/// 将字符串转成条形码
+ (UIImage *)kj_barCodeImageWithContent:(NSString *)content{
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setDefaults];
    NSData *data = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:data forKey:@"inputMessage"];
    CIImage *outputImage = [filter outputImage];
    
    CGSize size = CGSizeMake(300, 90);
    CGRect extent = CGRectIntegral(outputImage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:outputImage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpace);
    UIImage *image = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return image;
}
/// 生成条形码滤镜
+ (CIImage*)kj_barcodeCIImageWithContent:(NSString *)content{
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    NSData *contentData = [content dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:contentData forKey:@"inputMessage"];
    [filter setValue:@(0.00) forKey:@"inputQuietSpace"];
    return filter.outputImage;
}
/// 生成条形码
+ (UIImage *)kj_barcodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size{
    CIImage *image = [self kj_barcodeCIImageWithContent:content];
    return [UIImage kj_changeCIImage:image codeImageSize:size];
}
/// 生成指定颜色条形码
+ (UIImage *)kj_barcodeImageWithContent:(NSString *)content codeImageSize:(CGFloat)size color:(UIColor *)color{
    UIImage *image = [self kj_barcodeImageWithContent:content codeImageSize:size];
    return kChangeImagePixelColor(image, color);
}

#pragma mark - private

+ (UIImage *)kj_changeCIImage:(CIImage *)image codeImageSize:(CGFloat)size{
    CGRect integralRect = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(integralRect), size/CGRectGetHeight(integralRect));
    size_t width = CGRectGetWidth(integralRect)*scale;
    size_t height = CGRectGetHeight(integralRect)*scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:integralRect];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, integralRect, bitmapImage);
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGColorSpaceRelease(colorSpaceRef);
    UIImage *__image = [UIImage imageWithCGImage:scaledImage];
    CGImageRelease(scaledImage);
    return __image;
}

NS_INLINE UIImage * kChangeImagePixelColor(UIImage * image, UIColor * color){
    CGFloat red = 0, green = 0, blue = 0, a;
    [color getRed:&red green:&green blue:&blue alpha:&a];
    int imageWidth  = image.size.width;
    int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow * imageHeight);
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf,
                                                 imageWidth,
                                                 imageHeight,
                                                 8,
                                                 bytesPerRow,
                                                 space,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    int pixelNum = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0; i<pixelNum; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t *ptr = (uint8_t*)pCurPtr;
            ptr[3] = red*255;
            ptr[2] = green*255;
            ptr[1] = blue*255;
        } else {
            uint8_t *ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, kQRCodeProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth,
                                        imageHeight,
                                        8,
                                        32,
                                        bytesPerRow,
                                        space,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little,
                                        dataProvider,
                                        NULL,
                                        true,
                                        kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(space);
    return resultImage;
}
/// 释放
static void kQRCodeProviderReleaseData(void *info, const void * data, size_t size){
    free((void*)data);
}

/// 生成二维码
void kQRCodeImage(void(^codeImage)(UIImage * image), NSString *content, CGFloat size){
    if (codeImage) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            CIImage *image = [UIImage kj_QRCodeImageWithContent:content];
            UIImage *newImage = [UIImage kj_changeCIImage:image codeImageSize:size];
            dispatch_async(dispatch_get_main_queue(), ^{
                codeImage(newImage);
            });
        });
    }
}
/// 生成指定颜色二维码
void kQRCodeImageFromColor(void(^codeImage)(UIImage * image), NSString *content, CGFloat size, UIColor *color){
    kQRCodeImage(^(UIImage *image) {
        if (codeImage) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                UIImage *newImage = kChangeImagePixelColor(image, color);
                dispatch_async(dispatch_get_main_queue(), ^{
                    codeImage(newImage);
                });
            });
        }
    }, content, size);
}

@end
