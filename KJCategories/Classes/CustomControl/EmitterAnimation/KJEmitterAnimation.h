//
//  KJEmitterAnimation.h
//  KJCategories
//
//  Created by 77。 on 2019/8/27.
//  https://github.com/YangKJ/KJCategories

#import <QuartzCore/QuartzCore.h>
#import "KJEmitterAnimationProvider.h"

NS_ASSUME_NONNULL_BEGIN

@interface KJEmitterAnimation : CALayer

/// Initialization
/// @param provider request parameters
/// @param image Source image of particle animation
/// @param complete Animation complete callback
+ (instancetype)createWithProvider:(KJEmitterAnimationProvider *)provider
                      emitterImage:(UIImage *)image
                          complete:(nullable void(^)(void))complete;

- (void)restart;

@end

NS_ASSUME_NONNULL_END
