//
//  KJEmitterAnimation.h
//  KJCategories
//
//  Created by 杨科军 on 2019/8/27.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <QuartzCore/QuartzCore.h>
#import "KJEmitterAnimationProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJEmitterAnimation : CALayer

/// 初始化
/// @param provider 请求参数
/// @param image 粒子动画源图
/// @param complete 动画完成回调
+ (instancetype)createWithProvider:(KJEmitterAnimationProvider *)provider
                      emitterImage:(UIImage *)image
                          complete:(nullable void(^)(void))complete;

/// 重置
- (void)restart;

@end

NS_ASSUME_NONNULL_END
