//
//  KJBannerTool.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/7/30.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJBannerTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation KJBannerTool

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id _sharedInstance;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init{
    if (self==[super init]) {
        self.imageTemps = [NSMutableArray array];
    }
    return self;
}

/** 判断该字符串是不是一个有效的URL */
+ (BOOL)kj_bannerValidUrl:(NSString*)url{
    NSString *regex = @"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:url];
}
/** 根据图片名 判断是否是gif图 */
+ (BOOL)kj_bannerIsGifImageWithImageName:(NSString*)imageName{
    NSString *ext = imageName.pathExtension.lowercaseString;
    return [ext isEqualToString:@"gif"] ? YES : NO;
}
/** 根据图片url 判断是否是gif图 */
+ (BOOL)kj_bannerIsGifWithURL:(id)url{
    if (![url isKindOfClass:[NSURL class]]) {
        url = [NSURL URLWithString:url];
    }
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [self contentTypeWithImageData:data] == KJBannerImageTypeGif ? YES : NO;
}
/** 根据image的data 判断图片类型
 @param data 图片data
 @return 图片类型(png、jpg...)
 */
+ (KJBannerImageType)contentTypeWithImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return KJBannerImageTypeJpeg;
        case 0x89:
            return KJBannerImageTypePng;
        case 0x47:
            return KJBannerImageTypeGif;
        case 0x49:
        case 0x4D:
            return KJBannerImageTypeTiff;
        case 0x52:
            if ([data length] < 12) {
                return KJBannerImageTypeUnknown;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return KJBannerImageTypeWebp;
            }
            return KJBannerImageTypeUnknown;
    }
    return KJBannerImageTypeUnknown;
}

/// 判断是网络图片还是本地
+ (BOOL)kj_bannerImageWithImageUrl:(NSString*)imageUrl{
    //    NSRange rangeurl = [imageUrl rangeOfString:@"http"];
    //    return rangeurl.location != NSNotFound ? NO : YES;
    return ([imageUrl hasPrefix:@"http"] || [imageUrl hasPrefix:@"https"]) ? NO : YES;
}
/// 播放网络Gif
+ (void)kj_bannerPlayGifWithImageView:(UIImageView*)imageView URL:(id)url{
    //1.加载Gif图片，转换成Data类型
    //    NSString *path = [NSBundle.mainBundle pathForResource:@"demo" ofType:@"gif"];
    //    NSData *data = [NSData dataWithContentsOfFile:path];
    if (![url isKindOfClass:[NSURL class]]) {
        url = [NSURL URLWithString:url];
    }
    NSData *data = [NSData dataWithContentsOfURL:url];
    //2.将data数据转换成CGImageSource对象
    CGImageSourceRef imageSource = CGImageSourceCreateWithData(CFBridgingRetain(data), nil);
    size_t imageCount = CGImageSourceGetCount(imageSource);
    
    //3.遍历所有图片
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval totalDuration = 0;
    for (int i = 0; i<imageCount; i++) {
        //取出每一张图片
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil);
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        [images addObject:image];
        
        //持续时间
        NSDictionary *properties = (__bridge_transfer NSDictionary*)CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil);
        NSDictionary *gifDict = [properties objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        NSNumber *frameDuration = [gifDict objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime];
        totalDuration += frameDuration.doubleValue;
    }
    
    //4.设置imageView属性
    imageView.animationImages = images;
    imageView.animationDuration = totalDuration;
    imageView.animationRepeatCount = 0;
    
    //5.开始播放
    [imageView startAnimating];
}
// 得到Gif
+ (UIImage*)kj_bannerGetImageWithURL:(id)url{
    if (![url isKindOfClass:[NSURL class]]) {
        url = [NSURL URLWithString:url];
    }
    NSData *data = [NSData dataWithContentsOfURL:url];
    //2.将data数据转换成CGImageSource对象
    CGImageSourceRef imageSource = CGImageSourceCreateWithData(CFBridgingRetain(data), nil);
    size_t imageCount = CGImageSourceGetCount(imageSource);
    UIImage *animatedImage;
    if (imageCount <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }else{
        //3.遍历所有图片
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval totalDuration = 0;
        for (int i = 0; i<imageCount; i++) {
            //取出每一张图片
            CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil);
            [images addObject:[UIImage imageWithCGImage:cgImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(cgImage);
            //持续时间
            NSDictionary *properties = (__bridge_transfer NSDictionary*)CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil);
            NSDictionary *gifDict = [properties objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *frameDuration = [gifDict objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime];
            totalDuration += frameDuration.doubleValue;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:totalDuration];
    }
    CFRelease(imageSource);
    return animatedImage;
}
/// 保存gif在本地
+ (void)kj_bannerSaveWithImage:(UIImage*)image URL:(id)url{
    NSString *directoryPath = KJBannerLoadImages;
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            return;
        }
    }
    if ([url isKindOfClass:[NSURL class]]) {
        url = [url absoluteString];
    }
    NSString *name = [self kj_bannerMD5WithString:url];
    NSString *path = [directoryPath stringByAppendingPathComponent:name];
    NSData *data = UIImagePNGRepresentation(image);
    if (data) {
        /// 缓存数据
        [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    }
}
/// 从 File 当中获取Gif文件
+ (UIImage*)kj_bannerGetImageInFileWithURL:(id)url{
    if ([url isKindOfClass:[NSURL class]]) {
        url = [url absoluteString];
    }
    NSString *directoryPath = KJBannerLoadImages;
    NSString *name = [KJBannerTool kj_bannerMD5WithString:url];
    NSString *path = [directoryPath stringByAppendingPathComponent:name];
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];
    NSData *fileData = [handle readDataToEndOfFile];
    [handle closeFile];
    return [[UIImage alloc]initWithData:fileData];
}
/// md5加密
+ (NSString*)kj_bannerMD5WithString:(NSString*)string{
    const char *original_str = [string UTF8String];
    unsigned char digist[CC_MD5_DIGEST_LENGTH]; //CC_MD5_DIGEST_LENGTH = 16
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    NSMutableString *outPutStr = [NSMutableString stringWithCapacity:10];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [outPutStr appendFormat:@"%02X", digist[i]];//小写x表示输出的是小写MD5，大写X表示输出的是大写MD5
    }
    return [outPutStr lowercaseString];
}

@end

