//
//  UIButton+KJCountDown.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJCountDown)

/// Set countdown
/// @param timeout time interval
/// @param format countdown copywriting, the default is @"%zd seconds"
- (void)kj_startTime:(NSInteger)timeout CountDownFormat:(nullable NSString *)format;

/// Cancel countdown
- (void)kj_cancelTimer;

/// Callback for the end of the countdown
- (void)kj_countDownTimeStop:(void(^)(void))withBlock;

@end

NS_ASSUME_NONNULL_END
