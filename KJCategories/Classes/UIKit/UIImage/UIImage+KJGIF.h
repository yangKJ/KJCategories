//
//  UIImage+KJGIF.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  动态图播放

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJGIF)

/// 是否为动态图
@property (nonatomic,assign,readonly) BOOL isGif;

/// 本地动态图播放
/// @param name 动态图名称
/// @return 返回动态gif图
+ (UIImage *)kj_gifLocalityImageWithName:(NSString *)name;

/// 本地动图
/// @param data 数据源
/// @return 返回动态gif图
+ (UIImage *)kj_gifImageWithData:(NSData *)data;

/// 网络动图
/// @param URL 图片链接
/// @return 返回动态gif图
+ (UIImage *)kj_gifImageWithURL:(NSURL *)URL;

/// 图片播放，动态图
/// @param data 数据源
/// @return 返回动态gif图
+ (UIImage *)kj_playImageWithData:(NSData *)data;

/// 子线程播放动态图
/// @param xxblock 动态图生成回调
/// @param data 图片数据
void kPlayGifImageData(void(^xxblock)(bool isgif, UIImage * image), NSData * data);

@end

NS_ASSUME_NONNULL_END
