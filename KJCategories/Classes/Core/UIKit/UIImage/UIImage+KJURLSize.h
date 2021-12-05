//
//  UIImage+KJURLSize.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  获取网络图片尺寸

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJURLSize)

/// 获取网络图片尺寸
/// @param URL 图片链接
+ (CGSize)kj_imageSizeWithURL:(NSURL *)URL;

/// 同步获取网络图片大小，信号量
/// @param URL 图片链接
+ (CGSize)kj_imageAsyncGetSizeWithURL:(NSURL *)URL;

@end

NS_ASSUME_NONNULL_END
