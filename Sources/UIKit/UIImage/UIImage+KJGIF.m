//
//  UIImage+KJGIF.m
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  https://github.com/YangKJ/KJCategories


#import "UIImage+KJGIF.h"

#if __has_feature(objc_arc)
#define GIFTOCF (__bridge CFTypeRef)
#define GIFFROMCF (__bridge id)
#else
#define GIFTOCF (CFTypeRef)
#define GIFFROMCF (id)
#endif

@implementation UIImage (KJGIF)

- (BOOL)isGif{
    return (self.images != nil);
}
+ (UIImage *)kj_gifLocalityImageWithName:(NSString *)name{
    NSData *localData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:name ofType:@"gif"]];
    return [self kj_gifImageWithData:localData];
}
+ (UIImage *)kj_gifImageWithData:(NSData*)data {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithData(GIFTOCF data, NULL));
}
+ (UIImage *)kj_gifImageWithURL:(NSURL *)URL {
    return animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceCreateWithURL(GIFTOCF URL, NULL));
}
static int delayCentisecondsForImageAtIndex(CGImageSourceRef const source, size_t const i) {
    int delayCentiseconds = 1;
    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(source, i, NULL);
    if (properties) {
        CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
        if (gifProperties) {
            NSNumber *number = GIFFROMCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (number == NULL || [number doubleValue] == 0) {
                number = GIFFROMCF CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            if ([number doubleValue] > 0) delayCentiseconds = (int)lrint([number doubleValue] * 100);
        }
        CFRelease(properties);
    }
    return delayCentiseconds;
}
static void createImagesAndDelays(CGImageSourceRef source, size_t count, CGImageRef imagesOut[count], int delayCentisecondsOut[count]) {
    for (size_t i = 0; i < count; ++i) {
        imagesOut[i] = CGImageSourceCreateImageAtIndex(source, i, NULL);
        delayCentisecondsOut[i] = delayCentisecondsForImageAtIndex(source, i);
    }
}
static int sum(size_t const count, int const *const values) {
    int theSum = 0;
    for (size_t i = 0; i < count; ++i) {
        theSum += values[i];
    }
    return theSum;
}
static int pairGCD(int a, int b) {
    if (a < b) return pairGCD(b, a);
    while (true) {
        int const r = a % b;
        if (r == 0) return b;
        a = b;
        b = r;
    }
}
static int vectorGCD(size_t const count, int const *const values) {
    int gcd = values[0];
    for (size_t i = 1; i < count; ++i) {
        gcd = pairGCD(values[i], gcd);
    }
    return gcd;
}
static NSArray * frameArray(size_t const count, CGImageRef const images[count], int const delayCentiseconds[count], int const totalDurationCentiseconds) {
    int const gcd = vectorGCD(count, delayCentiseconds);
    size_t const frameCount = totalDurationCentiseconds / gcd;
    UIImage *frames[frameCount];
    for (size_t i = 0, f = 0; i < count; ++i) {
        UIImage *const frame = [UIImage imageWithCGImage:images[i]];
        for (size_t j = delayCentiseconds[i] / gcd; j > 0; --j) {
            frames[f++] = frame;
        }
    }
    return [NSArray arrayWithObjects:frames count:frameCount];
}
static void releaseImages(size_t const count, CGImageRef const images[count]) {
    for (size_t i = 0; i < count; ++i) {
        CGImageRelease(images[i]);
    }
}

static UIImage * animatedImageWithAnimatedGIFImageSource(CGImageSourceRef const source) {
    size_t const count = CGImageSourceGetCount(source);
    CGImageRef images[count];
    int delayCentiseconds[count];
    createImagesAndDelays(source, count, images, delayCentiseconds);
    int const totalDurationCentiseconds = sum(count, delayCentiseconds);
    NSArray *const frames = frameArray(count, images, delayCentiseconds, totalDurationCentiseconds);
    UIImage *const animation = [UIImage animatedImageWithImages:frames duration:(NSTimeInterval)totalDurationCentiseconds / 100.0];
    releaseImages(count, images);
    return animation;
}

static UIImage * animatedImageWithAnimatedGIFReleasingImageSource(CGImageSourceRef CF_RELEASES_ARGUMENT source) {
    if (source) {
        UIImage *const image = animatedImageWithAnimatedGIFImageSource(source);
        CFRelease(source);
        return image;
    }else {
        return nil;
    }
}
/// 动态图和网图播放
+ (UIImage *)kj_playImageWithData:(NSData*)data{
    if (data == nil) return nil;
    CGImageSourceRef imageSource = CGImageSourceCreateWithData(CFBridgingRetain(data), nil);
    size_t imageCount = CGImageSourceGetCount(imageSource);
    UIImage *animatedImage;
    if (imageCount <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    } else {
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:imageCount];
        NSTimeInterval time = 0;
        for (int i = 0; i<imageCount; i++) {
            CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil);
            [images addObject:[UIImage imageWithCGImage:cgImage]];
            CGImageRelease(cgImage);
            CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, NULL);
            CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
            NSNumber *duration = (__bridge id)CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
            if (duration == NULL || [duration doubleValue] == 0) {
                duration = (__bridge id)CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
            }
            CFRelease(properties);
            time += duration.doubleValue;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:time];
    }
    CFRelease(imageSource);
    return animatedImage;
}

/// 子线程处理动态图
void kPlayGifImageData(void(^xxblock)(bool isgif, UIImage * image), NSData *data){
    if (xxblock) {
        if (data == nil || data.length == 0) xxblock(false,nil);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            CGImageSourceRef imageSource = CGImageSourceCreateWithData(CFBridgingRetain(data), nil);
            size_t count = CGImageSourceGetCount(imageSource);
            if (count <= 1) {
                UIImage *animatedImage = [[UIImage alloc] initWithData:data];
                dispatch_async(dispatch_get_main_queue(), ^{
                    xxblock(false,animatedImage);
                });
            } else {
                NSMutableArray *images = [NSMutableArray arrayWithCapacity:count];
                NSTimeInterval time = 0;
                for (int i = 0; i<count; i++) {
                    CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil);
                    [images addObject:[UIImage imageWithCGImage:cgImage]];
                    CGImageRelease(cgImage);
                    CFDictionaryRef const properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, NULL);
                    CFDictionaryRef const gifProperties = CFDictionaryGetValue(properties, kCGImagePropertyGIFDictionary);
                    NSNumber *duration = (__bridge id)CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFUnclampedDelayTime);
                    if (duration == NULL || [duration doubleValue] == 0) {
                        duration = (__bridge id)CFDictionaryGetValue(gifProperties, kCGImagePropertyGIFDelayTime);
                    }
                    CFRelease(properties);
                    time += duration.doubleValue;
                }
                UIImage *animatedImage = [UIImage animatedImageWithImages:images duration:time];
                dispatch_async(dispatch_get_main_queue(), ^{
                    xxblock(true,animatedImage);
                });
            }
            CFRelease(imageSource);
        });
    }
}

@end
