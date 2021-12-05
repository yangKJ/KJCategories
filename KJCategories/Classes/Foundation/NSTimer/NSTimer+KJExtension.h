//
//  NSTimer+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/16.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (KJExtension)

/// 开启一个当前线程内可重复执行的NSTimer对象
/// @param inerval 间隔时间
/// @param repeats 是否重复
/// @param complete 事件处理
+ (NSTimer *)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                       repeats:(BOOL)repeats
                                      complete:(void(^)(NSTimer * timer))complete;
/// 开启一个当前线程内可重复执行的NSTimer对象
/// @param inerval 间隔时间
/// @param repeats 是否重复
/// @param complete 事件处理
/// @param mode RunLoop类型
+ (NSTimer *)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                       repeats:(BOOL)repeats
                                      complete:(void(^)(NSTimer * timer))complete
                                   runLoopMode:(NSRunLoopMode)mode;
/// 开启一个需添加到线程的可重复执行的NSTimer对象
/// @param inerval 间隔时间
/// @param repeats 是否重复
/// @param complete 事件处理
+ (NSTimer *)kj_timerWithTimeInterval:(NSTimeInterval)inerval
                              repeats:(BOOL)repeats
                             complete:(void(^)(NSTimer * timer))complete;
/// 立刻执行
- (void)kj_immediatelyTimer;

/// 暂停
- (void)kj_pauseTimer;

/// 重启计时器
- (void)kj_resumeTimer;

/// 延时执行
/// @param interval 延时
- (void)kj_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

/// 释放计时器
+ (void)kj_invalidateTimer:(NSTimer *)timer;

@end

NS_ASSUME_NONNULL_END
