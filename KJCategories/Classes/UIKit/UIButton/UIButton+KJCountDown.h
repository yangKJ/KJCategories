//
//  UIButton+KJCountDown.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  倒计时按钮

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJCountDown)

/// 设置倒计时
/// @param timeout 时间间隔
/// @param format 倒计时文案，默认为 @"%zd秒"
- (void)kj_startTime:(NSInteger)timeout CountDownFormat:(nullable NSString *)format;

/// 取消倒计时
- (void)kj_cancelTimer;

/// 倒计时结束的回调
- (void)kj_countDownTimeStop:(void(^)(void))withBlock;

@end

NS_ASSUME_NONNULL_END
