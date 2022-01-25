//
//  UIImage+KJProcessing.m
//  KJEmitterView
//
//  Created by 77。 on 2018/12/1.
//  Copyright © 2018 77。. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "UIImage+KJDoraemonBox.h"

@import Accelerate;

@implementation UIImage (KJDoraemonBox)

/// 透明图片穿透
- (bool)kj_transparentWithPoint:(CGPoint)point{
    unsigned char pixel[1] = {0};
    CGContextRef context = CGBitmapContextCreate(pixel,1,1,8,1,NULL,kCGImageAlphaOnly);
    UIGraphicsPushContext(context);
    [self drawAtPoint:CGPointMake(-point.x, -point.y)];
    UIGraphicsPopContext();
    CGContextRelease(context);
    CGFloat alpha = pixel[0]/255.0f;
    return alpha < 0.01f;
}
/// 获取图片平均颜色
- (UIColor *)kj_getImageAverageColor{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba,
                                                 1,
                                                 1,
                                                 8,
                                                 4,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0,0,1,1), self.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    if (rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat mu = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*mu
                               green:((CGFloat)rgba[1])*mu
                                blue:((CGFloat)rgba[2])*mu
                               alpha:alpha];
    } else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}
/// 获得灰度图
- (UIImage *)kj_getGrayImage{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat w = self.size.width * scale;
    CGFloat h = self.size.height * scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    //使用kCGImageAlphaPremultipliedLast保留Alpha通道，避免透明区域变成黑色
    CGContextRef context = CGBitmapContextCreate(nil,
                                                 w,
                                                 h,
                                                 8,
                                                 0,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast);
    CGContextDrawImage(context,CGRectMake(0,0,w,h),[self CGImage]);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    CGImageRelease(imageRef);
    return newImage;
}

/* 绘制图片 */
- (UIImage *)kj_mallocDrawImage{
    CGImageRef cgimage = self.CGImage;
    size_t width  = CGImageGetWidth(cgimage);
    size_t height = CGImageGetHeight(cgimage);
    UInt32 *data = (UInt32*)calloc(width * height * 4, sizeof(UInt32));
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(data,
                                                 width,
                                                 height,
                                                 8,
                                                 width * 4,
                                                 space,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), cgimage);
    for (size_t i = 10; i < height; i++){
        for (size_t j = 10; j < width; j++){
            size_t pixelIndex = i * width * 4 + j * 4;
            UInt32 red   = data[pixelIndex];
            UInt32 green = data[pixelIndex + 1];
            UInt32 blue  = data[pixelIndex + 2];
            //过滤代码
            if ((red < 0x2f && red > 0x07) && (green < 0xa0 && green > 0x84) && (blue < 0xbf && blue > 0xa8)) {
                data[pixelIndex] = 255;
                data[pixelIndex + 1] = 255;
                data[pixelIndex + 2] = 255;
            }
        }
    }
    cgimage = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:cgimage];
    CGColorSpaceRelease(space);
    CGContextRelease(context);
    CGImageRelease(cgimage);
    free(data);
    return newImage;
}

@end
