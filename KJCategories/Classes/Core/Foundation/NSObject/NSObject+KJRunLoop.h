//
//  NSObject+KJRunLoop.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/15.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJRunLoop)

/// 常驻线程，线程保活
- (void)kj_residentThread:(dispatch_block_t)withBlock;

/// 停止常驻线程
- (void)kj_stopResidentThread;

/// 空闲时刻执行
/// @param withBlock 执行回调
/// @param queue 线程，默认主线程
- (void)kj_performOnLeisure:(dispatch_block_t)withBlock
                      queue:(nullable dispatch_queue_t)queue;

@end

NS_ASSUME_NONNULL_END
