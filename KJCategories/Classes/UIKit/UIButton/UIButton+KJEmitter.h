//
//  UIButton+KJEmitter.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  粒子效果

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJEmitter)

/// 是否开启粒子效果
@property (nonatomic, assign) BOOL openEmitter;
/// 粒子，备注 name 属性不要更改
@property (nonatomic, strong, readonly) CAEmitterCell * emitterCell;
/// 设置粒子效果
/// @param image 粒子图片
/// @param open 是否开启粒子效果
- (void)kj_buttonSetEmitterImage:(UIImage * _Nullable)image OpenEmitter:(BOOL)open;

@end

NS_ASSUME_NONNULL_END
