//
//  UIImage+KJAccelerate.m
//  KJEmitterView
//
//  Created by 77。 on 2019/7/24.
//  https://github.com/YangKJ/KJCategories

#import "UIImage+KJAccelerate.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (KJAccelerate)
/// 图片旋转
- (UIImage *)kj_rotateInRadians:(CGFloat)radians{
    const size_t width  = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!context) return nil;
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
    UInt8 *data = (UInt8*)CGBitmapContextGetData(context);
    if (!data){
        CGContextRelease(context);
        return nil;
    }
    vImage_Buffer src  = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    Pixel_8888 bgColor = {0, 0, 0, 0};
    vImageRotate_ARGB8888(&src, &dest, NULL, radians, bgColor, kvImageBackgroundColorFill);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return newImage;
}

#pragma mark - 模糊处理
- (UIImage *)kj_blurImageSoft{
    return [self kj_blurImageWithTintColor:[UIColor colorWithWhite:0.84 alpha:0.36]];
}
- (UIImage *)kj_blurImageLight{
    return [self kj_blurImageWithTintColor:[UIColor colorWithWhite:1.0 alpha:0.3]];
}
- (UIImage *)kj_blurImageExtraLight{
    return [self kj_blurImageWithTintColor:[UIColor colorWithWhite:0.97 alpha:0.82]];
}
- (UIImage *)kj_blurImageDark{
    return [self kj_blurImageWithTintColor:[UIColor colorWithWhite:0.11 alpha:0.73]];
}
- (UIImage *)kj_blurImageWithTintColor:(UIColor *)color{
    const CGFloat alpha = 0.6;
    UIColor *effectColor = color;
    size_t componentCount = CGColorGetNumberOfComponents(color.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([color getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:alpha];
        }
    }else {
        CGFloat r, g, b;
        if ([color getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:alpha];
        }
    }
    return [self kj_blurImageWithRadius:20 color:effectColor maskImage:nil];
}
/// 模糊处理保留透明区域，范围0 ~ 1
- (UIImage *)kj_linearBlurryImageBlur:(CGFloat)blur{
    blur = MAX(MIN(blur,1),0);
    int boxSize = (int)(blur * 100);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = self.CGImage;
    vImage_Buffer inBuffer, outBuffer, rgbOutBuffer;
    vImage_Error error;
    void *pixelBuffer, *convertBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    convertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    rgbOutBuffer.width = CGImageGetWidth(img);
    rgbOutBuffer.height = CGImageGetHeight(img);
    rgbOutBuffer.rowBytes = CGImageGetBytesPerRow(img);
    rgbOutBuffer.data = convertBuffer;
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    if (pixelBuffer == NULL) NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    void *rgbConvertBuffer = malloc( CGImageGetBytesPerRow(img) * CGImageGetHeight(img) );
    vImage_Buffer outRGBBuffer;
    outRGBBuffer.width = CGImageGetWidth(img);
    outRGBBuffer.height = CGImageGetHeight(img);
    outRGBBuffer.rowBytes = CGImageGetBytesPerRow(img);
    outRGBBuffer.data = rgbConvertBuffer;
    /// box滤镜（模糊滤镜）
    error = vImageBoxConvolve_ARGB8888(&inBuffer,&outBuffer,NULL,0,0,boxSize,boxSize,NULL,kvImageEdgeExtend);
    if (error) NSLog(@"error from convolution %ld", error);
    
    /// 交换像素通道从BGRA到RGBA
    const uint8_t permuteMap[] = {2, 1, 0, 3};
    vImagePermuteChannels_ARGB8888(&outBuffer,&rgbOutBuffer,permuteMap,kvImageNoFlags);
    
    /// kCGImageAlphaPremultipliedLast 保留透明区域
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(rgbOutBuffer.data,
                                             rgbOutBuffer.width,
                                             rgbOutBuffer.height,
                                             8,
                                             rgbOutBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaPremultipliedLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    CGContextRelease(ctx);
    free(pixelBuffer);
    free(convertBuffer);
    free(rgbConvertBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
/// 模糊处理
- (UIImage *)kj_blurImageWithRadius:(CGFloat)radius color:(UIColor *)color maskImage:(UIImage* _Nullable)maskImage{
    CGRect imageRect = {CGPointZero, self.size};
    UIImage *effectImage = self;
    BOOL hasBlur = radius > __FLT_EPSILON__;
    if (hasBlur) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        CGFloat inputRadius = radius * [[UIScreen mainScreen] scale];
        NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
        if (radius % 2 != 1) radius += 1;
        vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        
        const int32_t divisor = 256;
        CGFloat s = 1.;
        CGFloat floatingPointSaturationMatrix[] = {
            0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
            0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
            0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
            0,                    0,                    0,  1,
        };
        NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
        int16_t saturationMatrix[matrixSize];
        for (NSUInteger i = 0; i < matrixSize; ++i) {
            saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
        }
        vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
        effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    if (color) {
        CGContextSaveGState(outputContext);
        CGContextSetBlendMode(outputContext, kCGBlendModeNormal);
        CGContextSetFillColorWithColor(outputContext, color.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}
#pragma mark - 形态操作
- (void)kj_common:(int)type src:(vImage_Buffer)src dest:(vImage_Buffer)dest{
    
}
/// 均衡运算
- (UIImage *)kj_equalizationImage{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!context) return nil;
    CGContextDrawImage(context, CGRectMake(0,0,width,height), self.CGImage);
    UInt8 * data = (UInt8*)CGBitmapContextGetData(context);
    if (!data){
        CGContextRelease(context);
        return nil; 
    }
    vImage_Buffer src  = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {data, height, width, bytesPerRow};
    vImageEqualization_ARGB8888(&src, &dest, kvImageNoFlags);
    CGImageRef destImageRef = CGBitmapContextCreateImage(context);
    UIImage* destImage = [UIImage imageWithCGImage:destImageRef];
    CGImageRelease(destImageRef);
    CGContextRelease(context);
    return destImage;
}
/// 侵蚀
- (UIImage *)kj_erodeImage{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    const size_t bytesPerRow = width * 4;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, width, height, 8, bytesPerRow, space, kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!context) return nil;
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextDrawImage(context, rect, self.CGImage);
    UInt8 * data = (UInt8*)CGBitmapContextGetData(context);
    if (!data){
        CGContextRelease(context);
        return nil;
    }
    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src  = {data, height, width, bytesPerRow};
    vImage_Buffer dest = {outt, height, width, bytesPerRow};
    vImageErode_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, kvImageCopyInPlace);
    memcpy(data, outt, n);
    free(outt);
    CGImageRef erodedImageRef = CGBitmapContextCreateImage(context);
    UIImage* eroded = [UIImage imageWithCGImage:erodedImageRef];
    CGImageRelease(erodedImageRef);
    CGContextRelease(context);
    return eroded;
}
/// 形态膨胀/扩张
- (UIImage *)kj_dilateImage{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 8,
                                                 width * 4,
                                                 space,
                                                 kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedFirst);
    CGColorSpaceRelease(space);
    if (!context) return nil;
    CGRect rect = CGRectMake(0, 0, width, height);
    CGContextDrawImage(context, rect, self.CGImage);
    UInt8 * data = (UInt8*)CGBitmapContextGetData(context);
    if (!data){
        CGContextRelease(context);
        return nil;
    }
    const size_t n = sizeof(UInt8) * width * height * 4;
    void* outt = malloc(n);
    vImage_Buffer src  = {data, height, width, width * 4};
    vImage_Buffer dest = {outt, height, width, width * 4};
    vImageDilate_ARGB8888(&src, &dest, 0, 0, morphological_kernel, 3, 3, kvImageCopyInPlace);
    memcpy(data, outt, n);
    free(outt);
    CGImageRef dilatedImageRef = CGBitmapContextCreateImage(context);
    UIImage* dilated = [UIImage imageWithCGImage:dilatedImageRef];
    CGImageRelease(dilatedImageRef);
    CGContextRelease(context);
    return dilated;
}
/// 多倍侵蚀
- (UIImage *)kj_erodeImageWithIterations:(int)iterations{
    UIImage *dstImage = self;
    for (int i = 0; i<iterations; i++) {
        dstImage = [dstImage kj_erodeImage];
    }
    return dstImage;
}
/// 形态多倍膨胀/扩张
- (UIImage *)kj_dilateImageWithIterations:(int)iterations{
    UIImage *dstImage = self;
    for (int i = 0; i<iterations; i++) {
        dstImage = [dstImage kj_dilateImage];
    }
    return dstImage;
}
/// 梯度
- (UIImage *)kj_gradientImageWithIterations:(int)iterations{
    UIImage *dilated = [self kj_dilateImageWithIterations:iterations];
    UIImage *eroded = [self kj_erodeImageWithIterations:iterations];
    UIImage *dstImage = [dilated kj_imageBlendedWithImage:eroded blendMode:kCGBlendModeDifference alpha:1.0];
    return dstImage;
}
/// 顶帽运算
- (UIImage *)kj_tophatImageWithIterations:(int)iterations {
    UIImage *dilated = [self kj_dilateImageWithIterations:iterations];
    UIImage *dstImage = [self kj_imageBlendedWithImage:dilated blendMode:kCGBlendModeDifference alpha:1.0];
    return dstImage;
}
/// 黑帽运算
- (UIImage *)kj_blackhatImageWithIterations:(int)iterations {
    UIImage *eroded = [self kj_erodeImageWithIterations:iterations];
    UIImage *dstImage = [eroded kj_imageBlendedWithImage:self blendMode:kCGBlendModeDifference alpha:1.0];
    return dstImage;
}
// 混合函数，CoreGraphics处理
- (UIImage *)kj_imageBlendedWithImage:(UIImage *)overlayImage blendMode:(CGBlendMode)blendMode alpha:(CGFloat)alpha{
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0,0,self.size.width,self.size.height)];
    [overlayImage drawAtPoint:CGPointZero blendMode:blendMode alpha:alpha];
    UIImage *blendedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return blendedImage;
}
#pragma mark - 卷积处理
/// 卷积处理
- (UIImage *)kj_convolutionImageWithKernel:(int16_t*)kernel{
    const size_t width = self.size.width;
    const size_t height = self.size.height;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL,
                                                 width,
                                                 height,
                                                 8,
                                                 width * 4,
                                                 space,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(space);
    if (!context) return nil;
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), self.CGImage);
    UInt8 * data = (UInt8*)CGBitmapContextGetData(context);
    if (!data){
        CGContextRelease(context);
        return nil;
    }
    const size_t n = sizeof(UInt8) * width * height * 4;
    void * outt = malloc(n);
    vImage_Buffer src  = {data, height, width, width * 4};
    vImage_Buffer dest = {outt, height, width, width * 4};
    vImageConvolve_ARGB8888(&src,&dest,NULL,0,0,kernel,3,3,1,backgroundColorBlack,kvImageCopyInPlace);
    memcpy(data, outt, n);
    free(outt);
    CGImageRef imageRef = CGBitmapContextCreateImage(context);
    UIImage *resultImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    CGContextRelease(context);
    return resultImage;
}
/// 浮雕函数
- (UIImage *)kj_embossImage{
    return [self kj_convolutionImageWithKernel:emboss_kernel];
}
/// 锐化
- (UIImage *)kj_sharpenImage{
    return [self kj_convolutionImageWithKernel:sharpen_kernel];
}
/// 锐化
- (UIImage *)kj_sharpenImageWithIterations:(int)iterations{
    int k = iterations;
    int16_t kernel[9] = {
        -k,-k,-k,
        -k,8*k+1,-k,
        -k,-k,-k
    };
    return [self kj_convolutionImageWithKernel:kernel];
}
/// 高斯
- (UIImage *)kj_gaussianImage{
    return [self kj_convolutionImageWithKernel:gaussian_kernel];
}
/// 边缘检测
- (UIImage *)kj_marginImage{
    return [self kj_convolutionImageWithKernel:margin_kernel];
}
- (UIImage *)kj_edgeDetection{
    return [self kj_convolutionImageWithKernel:edgedetect_kernel];
}
#pragma mark - 函数矩阵
static uint8_t backgroundColorBlack[4] = {0,0,0,0};
/// 高斯矩阵
static int16_t gaussian_kernel[9] = {
    1, 2, 1,
    2, 4, 2,
    1, 2, 1
};
/// 边缘检测矩阵
static int16_t margin_kernel[9] = {
    -1, -1, -1,
    0,  0,  0,
    1,  1,  1
};
/// 边缘检测矩阵
static int16_t edgedetect_kernel[9] = {
    -1, -1, -1,
    -1,  8, -1,
    -1, -1, -1
};
/// 锐化矩阵
static int16_t sharpen_kernel[9] = {
    -1, -1, -1,
    -1,  9, -1,
    -1, -1, -1
};
/// 浮雕矩阵
static int16_t emboss_kernel[9] = {
    -2, 0, 0,
    0, 1, 0,
    0, 0, 2
};
/// 侵蚀矩阵
static unsigned char morphological_kernel[9] = {
    1, 1, 1,
    1, 1, 1,
    1, 1, 1
};

@end
