//
//  KJEmitterAnimationProvider.m
//  KJCategories
//
//  Created by 77。 on 2019/8/27.
//  https://github.com/YangKJ/KJCategories

#import "KJEmitterAnimationProvider.h"

@implementation KJEmitterAnimationProvider

- (instancetype)init{
    if (self = [super init]) {
        self.dropSpeed = 0.5;
        self.pixelBeginPoint = CGPointZero;
    }
    return self;
}

/// 异步拆分像素粒子
- (void)asyncResolutionPixelImage:(UIImage *)image withBlock:(void(^)(NSArray<KJEmitterImagePixel *> *))withBlock{
    __weak __typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSArray * array = [weakself resolutionImagePixels:image];
        if (array.count) {
            dispatch_async(dispatch_get_main_queue(), ^{
                withBlock ? withBlock(array) : nil;
            });
        }
    });
}

/// 将图片拆分为像素粒子
- (NSArray<KJEmitterImagePixel *> *)resolutionImagePixels:(UIImage *)image{
    CGImageRef imageRef = [image CGImage];
    NSUInteger width  = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bytesPerPixel = 4;
    NSUInteger bytesPerRow = bytesPerPixel * width;
    unsigned char *data = (unsigned char *)calloc(height * width * bytesPerPixel, sizeof(unsigned char));
    CGContextRef context = CGBitmapContextCreate(data,
                                                 width,
                                                 height,
                                                 8,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    CGContextRelease(context);
    CGFloat addY = (_maxPixels == 0) ? 1 : MAX(1, (height / _maxPixels));
    CGFloat addX = (_maxPixels == 0) ? 1 : MAX(1, (width / _maxPixels));
    NSMutableArray *result = [NSMutableArray array];
    for (int y = 0; y < height; y += addY) {
        for (int x = 0; x < width; x += addX) {
            NSUInteger byteIndex = bytesPerRow * y + bytesPerPixel * x;
            CGFloat red   = ((CGFloat)data[byteIndex + 0]) / 255.0f;
            CGFloat green = ((CGFloat)data[byteIndex + 1]) / 255.0f;
            CGFloat blue  = ((CGFloat)data[byteIndex + 2]) / 255.0f;
            CGFloat alpha = ((CGFloat)data[byteIndex + 3]) / 255.0f;
            /// 要忽略的粒子
            if ((_whiteIgnored && (red + green + blue == 3)) ||
                (_blockIgnored && (red + green + blue == 0)) ||
                alpha == 0) {
                continue;
            }
            KJEmitterImagePixel * pixel = [[KJEmitterImagePixel alloc] init];
            pixel.point = CGPointMake(x, y);
            if (self.pixelColor) {
                const CGFloat *components = CGColorGetComponents(self.pixelColor.CGColor);
                pixel.red = components[0];
                pixel.green = components[1];
                pixel.blue = components[2];
                pixel.alpha = components[3];
            } else {
                pixel.red = red;
                pixel.green = green;
                pixel.blue = blue;
                pixel.alpha = alpha;
            }
            if (_pixelRandomRange > 0) pixel.randomPointRange = _pixelRandomRange;
            [result addObject:pixel];
        }
    }
    free(data);
    return result.mutableCopy;
}

@end

@implementation KJEmitterImagePixel

- (instancetype)init{
    if (self = [super init]) {
        _delayTime = arc4random_uniform(30);
        _delayDuration = arc4random_uniform(10);
    }
    return self;
}

- (void)setRandomPointRange:(CGFloat)randomPointRange {
    _randomPointRange = randomPointRange;
    if (_randomPointRange != 0) {
        _point.x = _point.x - _randomPointRange + arc4random_uniform(_randomPointRange * 2);
        _point.y = _point.y - _randomPointRange + arc4random_uniform(_randomPointRange * 2);
    }
}

@end
