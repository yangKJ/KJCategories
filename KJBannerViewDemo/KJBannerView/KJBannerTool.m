//
//  KJBannerTool.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/7/30.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJBannerTool.h"
#import <CommonCrypto/CommonDigest.h>

@implementation KJBannerDatasInfo

- (void)setImageUrl:(NSString *)imageUrl{
    _imageUrl = imageUrl;
    switch (_superType) {
        case 0:{ // 混合，本地图片、网络图片、网络GIF
            //1.判断是本地还是网络
            if ([KJBannerTool kj_bannerImageWithImageUrl:_imageUrl] == YES) { /// 本地图片
                _type = KJBannerImageInfoTypeLocality;
                _image = [UIImage imageNamed:_imageUrl];
            }else{
                //2.判断是GIF还是网络图片
                if ([KJBannerTool kj_bannerIsGifWithURL:_imageUrl] == YES) {
                    _image = [KJBannerTool kj_bannerGetImageWithURL:_imageUrl];
                    _type = KJBannerImageInfoTypeGIFImage;
                }else{
                    //3.网络图片
                    _type = KJBannerImageInfoTypeNetIamge;
                }
            }
        }
            break;
        case 1:{ // 网络GIF和网络图片混合
            if ([KJBannerTool kj_bannerIsGifWithURL:_imageUrl] == YES) {
                _image = [KJBannerTool kj_bannerGetImageWithURL:_imageUrl];
                _type = KJBannerImageInfoTypeGIFImage;
            }else{
                //3.网络图片
                _type = KJBannerImageInfoTypeNetIamge;
            }
        }
            break;
        case 2:{ // 本地图片
            _type = KJBannerImageInfoTypeLocality;
            _image = [UIImage imageNamed:_imageUrl];
        }
            break;
        case 3:{ // 网络图片
            _type = KJBannerImageInfoTypeNetIamge;
        }
            break;
        case 4:{ // 网络GIF图片
            _image = [KJBannerTool kj_bannerGetImageWithURL:_imageUrl];
            _type = KJBannerImageInfoTypeGIFImage;
        }
            break;
        default:
            break;
    }
}

#pragma mark - 内部方法
/// 本地GIF和本地图片
- (void)kj_ImageLociaWithURL:(NSString*)imageUrl{
    //2.判断是否为本地的gif
    if ([KJBannerTool kj_bannerIsGifImageWithImageName:imageUrl] == NO) {
        
    }
}

@end

@implementation KJBannerTool

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static id _sharedInstance;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
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
/// 根据image的data 判断图片类型
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
            if ([data length] < 12) return KJBannerImageTypeUnknown;
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) return KJBannerImageTypeWebp;
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
+ (NSTimeInterval)kj_bannerPlayGifWithImageView:(UIImageView*)imageView URL:(id)url{
    if (![url isKindOfClass:[NSURL class]]) url = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    CGImageSourceRef imageSource = CGImageSourceCreateWithData(CFBridgingRetain(data), nil);
    size_t imageCount = CGImageSourceGetCount(imageSource);
    NSMutableArray *images = [NSMutableArray array];
    NSTimeInterval totalDuration = 0;
    for (int i = 0; i<imageCount; i++) {
        CGImageRef cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil);
        UIImage *image = [UIImage imageWithCGImage:cgImage];
        [images addObject:image];
        NSDictionary *properties = (__bridge_transfer NSDictionary*)CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil);
        NSDictionary *gifDict = [properties objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
        NSNumber *frameDuration = [gifDict objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime];
        totalDuration += frameDuration.doubleValue;
    }
    imageView.animationImages = images;
    imageView.animationDuration = totalDuration;
    imageView.animationRepeatCount = 0;
    [imageView startAnimating];
    return totalDuration;
}
// 获取网络GIF图
+ (UIImage*)kj_bannerGetImageWithURL:(id)url{
    if (![url isKindOfClass:[NSURL class]]) url = [NSURL URLWithString:url];
    NSData *data = [NSData dataWithContentsOfURL:url];
    CGImageSourceRef imageSource = CGImageSourceCreateWithData(CFBridgingRetain(data), nil);
    size_t imageCount = CGImageSourceGetCount(imageSource);
    UIImage *animatedImage;
    if (imageCount <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }else{
        NSMutableArray *images = [NSMutableArray array];
        NSTimeInterval totalDuration = 0;
        CGImageRef cgImage = NULL;
        for (int i = 0; i<imageCount; i++) {
            cgImage = CGImageSourceCreateImageAtIndex(imageSource,i,nil);
            [images addObject:[UIImage imageWithCGImage:cgImage]];
            NSDictionary *properties = (__bridge_transfer NSDictionary*)CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil);
            NSDictionary *gifDict = [properties objectForKey:(__bridge NSString *)kCGImagePropertyGIFDictionary];
            NSNumber *frameDuration = [gifDict objectForKey:(__bridge NSString *)kCGImagePropertyGIFDelayTime];
            totalDuration += frameDuration.doubleValue;
        }
        animatedImage = [UIImage animatedImageWithImages:images duration:totalDuration];
        CGImageRelease(cgImage);
        images = nil;
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
        if (error) return;
    }
    if ([url isKindOfClass:[NSURL class]]) url = [url absoluteString];
    NSString *name = [self kj_bannerMD5WithString:url];
    NSString *path = [directoryPath stringByAppendingPathComponent:name];
    NSData *data = UIImagePNGRepresentation(image);
    if (data) [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
}
/// 从 File 当中获取Gif文件
+ (UIImage*)kj_bannerGetImageInFileWithURL:(id)url{
    if ([url isKindOfClass:[NSURL class]]) url = [url absoluteString];
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
    unsigned char digist[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, (uint)strlen(original_str), digist);
    NSMutableString *outPutStr = [NSMutableString stringWithCapacity:10];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [outPutStr appendFormat:@"%02X", digist[i]];
    }
    return [outPutStr lowercaseString];
}

@end

