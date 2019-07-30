//
//  NSString+KJBannerGIF.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/7/30.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "NSString+KJBannerGIF.h"

@implementation NSString (KJBannerGIF)

- (BOOL)isValidUrl {
    NSString *regex =@"[a-zA-z]+://[^\\s]*";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

- (BOOL)isGifImage {
    NSString *ext = self.pathExtension.lowercaseString;
    if ([ext isEqualToString:@"gif"]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isGifWithImageData:(NSData *)data{
    return [self contentTypeWithImageData:data] == KJBannerGIFTypeGif ? YES : NO;
}

+ (KJBannerGIFType)contentTypeWithImageData:(NSData *)data {
    uint8_t c;
    [data getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return KJBannerGIFTypeJpeg;
        case 0x89:
            return KJBannerGIFTypePng;
        case 0x47:
            return KJBannerGIFTypeGif;
        case 0x49:
        case 0x4D:
            return KJBannerGIFTypeTiff;
        case 0x52:
            if ([data length] < 12) {
                return KJBannerGIFTypeUnknown;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return KJBannerGIFTypeWebp;
            }
            return KJBannerGIFTypeUnknown;
    }
    return KJBannerGIFTypeUnknown;
}

@end
