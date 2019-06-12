//
//  KJLoadImageView.m
//  iSchool
//
//  Created by 杨科军 on 2018/12/22.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "KJLoadImageView.h"
#import <objc/runtime.h>
#import <CommonCrypto/CommonDigest.h>

/** 网络下载相关
 *  图片下载器，没有直接使用NSURLSession之类的，是因为希望这套库可以支持iOS6
 */
@interface KJImageDownloader : NSObject<NSURLSessionDownloadDelegate>

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, assign) unsigned long long totalLength;
@property (nonatomic, assign) unsigned long long currentLength;
@property (nonatomic, copy) KJDownloadProgressBlock progressBlock;
@property (nonatomic, copy) KJDownLoadDataCallBack callbackOnFinished;

/// 下载图片
- (void)kj_startDownloadImageWithUrl:(NSString *)url Progress:(KJDownloadProgressBlock)progress Complete:(KJDownLoadDataCallBack)complete;

@end

@implementation KJImageDownloader

- (void)kj_startDownloadImageWithUrl:(NSString *)url Progress:(KJDownloadProgressBlock)progress Complete:(KJDownLoadDataCallBack)complete {
    self.progressBlock = progress;
    self.callbackOnFinished = complete;
    
    if ([NSURL URLWithString:url] == nil) {
        NSError *error = [NSError errorWithDomain:@"henishuo.com" code:101 userInfo:@{@"errorMessage": @"URL不正确"}];
        !complete ?: complete(nil, error);
        return;
    }
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:60];
    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    self.session = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:queue];
    NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request];
    [task resume];
    self.task = task;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    
    if (self.progressBlock) {
        self.progressBlock(self.totalLength, self.currentLength);
    }
    
    if (self.callbackOnFinished) {
        self.callbackOnFinished(data, nil);
        // 防止重复调用
        self.callbackOnFinished = nil;
    }
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    self.currentLength = totalBytesWritten;
    self.totalLength = totalBytesExpectedToWrite;
    
    if (self.progressBlock) {
        self.progressBlock(self.totalLength, self.currentLength);
    }
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if ([error code] != NSURLErrorCancelled) {
        if (self.callbackOnFinished) {
            self.callbackOnFinished(nil, error);
        }
        self.callbackOnFinished = nil;
    }
}

@end

/************************** 缓存相关 ******************************/
@interface UIApplication (KJCacheImage)

@property (nonatomic, strong, readonly) NSMutableDictionary *kj_cacheFaileDictionary;

///
- (UIImage *)kj_cacheImageForRequest:(NSURLRequest *)request;
- (void)kj_cacheImage:(UIImage *)image forRequest:(NSURLRequest *)request;
- (void)kj_cacheFailRequest:(NSURLRequest *)request;
/// 获取失败次数
- (NSUInteger)kj_failTimesForRequest:(NSURLRequest *)request;

@end

@implementation UIApplication (KJCacheImage)

- (NSMutableDictionary *)kj_cacheFaileDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, @selector(kj_cacheFaileDictionary));
    if (!dict) {
        dict = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, @selector(kj_cacheFaileDictionary), dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (void)kj_clearCache {
    [self.kj_cacheFaileDictionary removeAllObjects];
    objc_setAssociatedObject(self, @selector(kj_cacheFaileDictionary), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)kj_clearDiskCaches {
    NSString *directoryPath = KJBannerLoadImages;
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:directoryPath error:&error];
    }
    
    [self kj_clearCache];
}

- (NSUInteger)kj_failTimesForRequest:(NSURLRequest *)request {
    NSNumber *faileTimes = [self.kj_cacheFaileDictionary objectForKey:[self kj_md5:[self kj_keyForRequest:request]]];
    if (faileTimes && [faileTimes respondsToSelector:@selector(integerValue)]) {
        return faileTimes.integerValue;
    }
    return 0;
}

/// 缓存图片
- (UIImage *)kj_cacheImageForRequest:(NSURLRequest *)request {
    if (request) {
        NSString *directoryPath = KJBannerLoadImages;
        NSString *path = [NSString stringWithFormat:@"%@/%@", directoryPath, [self kj_md5:[self kj_keyForRequest:request]]];
        return [UIImage imageWithContentsOfFile:path];
    }
    return nil;
}
///
- (void)kj_cacheFailRequest:(NSURLRequest *)request {
    NSNumber *faileTimes = [self.kj_cacheFaileDictionary objectForKey:[self kj_md5:[self kj_keyForRequest:request]]];
    NSUInteger times = 0;
    if (faileTimes && [faileTimes respondsToSelector:@selector(integerValue)]) {
        times = [faileTimes integerValue];
    }
    times++;
    [self.kj_cacheFaileDictionary setObject:@(times) forKey:[self kj_md5:[self kj_keyForRequest:request]]];
}

- (void)kj_cacheImage:(UIImage *)image forRequest:(NSURLRequest *)request {
    if (image == nil || request == nil) {
        return;
    }
    
    NSString *directoryPath = KJBannerLoadImages;
    if (![[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:nil]) {
        NSError *error = nil;
        [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:&error];
        if (error) {
            return;
        }
    }
    
    NSString *path = [NSString stringWithFormat:@"%@/%@",directoryPath,[self kj_md5:[self kj_keyForRequest:request]]];
    NSData *data = UIImagePNGRepresentation(image);
    if (data) {
        /// 缓存数据
        [[NSFileManager defaultManager] createFileAtPath:path contents:data attributes:nil];
    }
}

#pragma mark - 内部方法
/// 拼接路径
- (NSString *)kj_keyForRequest:(NSURLRequest *)request {
    BOOL portait = NO;
    if (UIDeviceOrientationIsPortrait([[UIDevice currentDevice] orientation])) {
        portait = YES;
    }
    return [NSString stringWithFormat:@"%@%@", request.URL.absoluteString, portait ? @"portait" : @"lanscape"];
}

/// 加密
- (NSString *)kj_md5:(NSString *)string {
    if (string == nil || [string length] == 0) {
        return nil;
    }

    unsigned char digest[CC_MD5_DIGEST_LENGTH], i;
    CC_MD5([string UTF8String], (int)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding], digest);
    NSMutableString *ms = [NSMutableString string];

    for (i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [ms appendFormat:@"%02x", (int)(digest[i])];
    }
    return [ms copy];
}

@end

@interface KJLoadImageView (){
    __weak KJImageDownloader *_imageDownloader;
}

@end

@implementation KJLoadImageView

- (void)configureLayout {
    self.contentMode = UIViewContentModeScaleToFill;
    self.kj_failedTimes = 2;
    self.kj_isScale = NO;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configureLayout];
    }
    return self;
}

- (void)kj_setImageWithURLString:(NSString *)url Placeholder:(UIImage *)placeholderImage {
    return [self kj_setImageWithURLString:url Placeholder:placeholderImage Completion:nil];
}

- (void)kj_setImageWithURLString:(NSString *)url Placeholder:(UIImage *)placeholderImage Completion:(void (^)(UIImage *image))completion {
    self.kj_completionBlock = completion;
    if (url == nil || [url isKindOfClass:[NSNull class]] || (![url hasPrefix:@"http://"] && ![url hasPrefix:@"https://"])){
        self.image = placeholderImage;
        if (completion) {
            self.kj_completionBlock(self.image);
        }
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self kj_downloadWithReqeust:request holder:placeholderImage];
}

#pragma mark - 内部方法
/// 下载图片
- (void)kj_downloadWithReqeust:(NSURLRequest *)theRequest holder:(UIImage *)holder {
    UIImage *cachedImage = [[UIApplication sharedApplication] kj_cacheImageForRequest:theRequest];
    if (cachedImage) {
        self.image = cachedImage;
        if (self.kj_completionBlock) {
            self.kj_completionBlock(cachedImage);
        }
        return;
    }
    self.image = holder;
    
    /// 判断失败次数
    if ([[UIApplication sharedApplication] kj_failTimesForRequest:theRequest] >= self.kj_failedTimes) {
        return;
    }
    
    [self kj_cancelRequest];
    _imageDownloader = nil;
    
    __weak __typeof(self) weakSelf = self;
    KJImageDownloader *downloader = [[KJImageDownloader alloc] init];
    _imageDownloader = downloader;
    [downloader kj_startDownloadImageWithUrl:theRequest.URL.absoluteString Progress:^(unsigned long long total, unsigned long long current) {
        !self.kj_progressBlock?:self.kj_progressBlock(total,current);
    } Complete:^(NSData *data, NSError *error) {
        // 成功
        if (data != nil && error == nil) {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                UIImage *image = [UIImage imageWithData:data];
                UIImage *finalImage = image;
                
                if (image) {
                    if (weakSelf.kj_isScale) {
                        // 剪裁
                        if (fabs(weakSelf.frame.size.width - image.size.width) != 0 && fabs(weakSelf.frame.size.height - image.size.height) != 0) {
                            finalImage = [KJLoadImageView kj_clipImage:image Size:weakSelf.frame.size IsScaleToMax:YES];
                        }
                    }
                    [[UIApplication sharedApplication] kj_cacheImage:finalImage forRequest:theRequest];
                } else {
                    [[UIApplication sharedApplication] kj_cacheFailRequest:theRequest];
                }
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (finalImage) {
                        weakSelf.image = finalImage;
                        !weakSelf.kj_completionBlock?:weakSelf.kj_completionBlock(weakSelf.image);
                    } else {// error data
                        !weakSelf.kj_completionBlock?:weakSelf.kj_completionBlock(weakSelf.image);
                    }
                });
            });
        } else { // error
            [[UIApplication sharedApplication] kj_cacheFailRequest:theRequest];
            !weakSelf.kj_completionBlock?:weakSelf.kj_completionBlock(weakSelf.image);
        }
    }];
}

- (void)kj_cancelRequest {
    [_imageDownloader.task cancel];
}


/**
 *  此处公开此API，是方便大家可以在别的地方使用。等比例剪裁图片大小到指定的size
 *  @param image 剪裁前的图片
 *  @param size  最终图片大小
 *  @param isScaleToMax 是取最大比例还是最小比例，YES表示取最大比例
 *
 *  @return 裁剪后的图片
 */
+ (UIImage *)kj_clipImage:(UIImage *)image Size:(CGSize)size IsScaleToMax:(BOOL)isScaleToMax {
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGSize aspectFitSize = CGSizeZero;
    if (image.size.width != 0 && image.size.height != 0) {
        CGFloat rateWidth = size.width / image.size.width;
        CGFloat rateHeight = size.height / image.size.height;
        
        CGFloat rate = isScaleToMax ? MAX(rateHeight, rateWidth) : MIN(rateHeight, rateWidth);
        aspectFitSize = CGSizeMake(image.size.width * rate, image.size.height * rate);
    }
    
    [image drawInRect:CGRectMake(0, 0, aspectFitSize.width, aspectFitSize.height)];
    UIImage *finalImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return finalImage;
}

#pragma mark - 缓存相关方法
+ (void)kj_clearImagesCache {
    [[UIApplication sharedApplication] kj_clearDiskCaches];
}

+ (unsigned long long)kj_imagesCacheSize {
    NSString *directoryPath = KJBannerLoadImages;
    BOOL isDir = NO;
    unsigned long long total = 0;
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    
    return total;
}

@end
