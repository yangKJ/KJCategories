//
//  NSObject+KJGCDBox.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/3/17.
//  https://github.com/YangKJ/KJCategories
//  GCD盒子封装，常驻线程封装

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJGCDBox)

/// 创建异步定时器，相比 NSTimer 和 CADisplayLink 更加精准（这两者都是基于runloop处理）
/// @param async 是否异步
/// @param task 事件处理
/// @param start 开始时间
/// @param interval 间隔时间
/// @param repeats 是否重复
/// @return 返回计时器
- (dispatch_source_t)kj_createGCDAsyncTimer:(BOOL)async
                                       task:(dispatch_block_t)task
                                      start:(NSTimeInterval)start
                                   interval:(NSTimeInterval)interval
                                    repeats:(BOOL)repeats;
/// 取消计时器
- (void)kj_gcdStopTimer:(dispatch_source_t)timer;

/// 暂停计时器
- (void)kj_gcdPauseTimer:(dispatch_source_t)timer;

/// 继续计时器
- (void)kj_gcdResumeTimer:(dispatch_source_t)timer;

/// 延时执行
/// @param task 事件处理
/// @param time 延迟时间
/// @param async 是否异步
- (void)kj_gcdAfterTask:(dispatch_block_t)task
                   time:(NSTimeInterval)time
                  asyne:(BOOL)async;
/// 异步快速迭代
/// @param task 事件处理
/// @param count 总迭代次数
- (void)kj_gcdApplyTask:(BOOL(^)(size_t index))task
                  count:(NSUInteger)count;

#pragma mark - GCD 线程处理
/// 创建队列
FOUNDATION_EXPORT dispatch_queue_t kGCD_queue(void);
/// 主线程
FOUNDATION_EXPORT void kGCD_main(dispatch_block_t block);
/// 子线程
FOUNDATION_EXPORT void kGCD_async(dispatch_block_t block);
/// 异步并行队列，携带可变参数（需要nil结尾）
FOUNDATION_EXPORT void kGCD_group_notify(dispatch_block_t notify, dispatch_block_t block,...);
/// 栅栏
FOUNDATION_EXPORT dispatch_queue_t kGCD_barrier(dispatch_block_t block, dispatch_block_t barrier);
/// 栅栏实现多读单写操作，barrier当中完成写操作，携带可变参数（需要nil结尾）
FOUNDATION_EXPORT void kGCD_barrier_read_write(dispatch_block_t barrier, dispatch_block_t block,...);
/// 一次性
FOUNDATION_EXPORT void kGCD_once(dispatch_block_t block);
/// 延时执行
FOUNDATION_EXPORT void kGCD_after(int64_t delayInSeconds, dispatch_block_t block);
/// 主线程当中延时执行
FOUNDATION_EXPORT void kGCD_after_main(int64_t delayInSeconds, dispatch_block_t block);
/// 快速迭代
FOUNDATION_EXPORT void kGCD_apply(int iterations, void(^block)(size_t idx));
/// 快速遍历数组
FOUNDATION_EXPORT void kGCD_apply_array(NSArray * temp, void(^block)(id obj, size_t index));

@end

#define _weakself __weak __typeof(self) weakself = self
#define _strongself __strong __typeof(weakself) strongself = weakself
#ifndef kWeakObject
#if DEBUG
#if __has_feature(objc_arc)
#define kWeakObject(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define kWeakObject(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define kWeakObject(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define kWeakObject(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

#ifndef kStrongObject
#if DEBUG
#if __has_feature(objc_arc)
#define kStrongObject(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define kStrongObject(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define kStrongObject(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define kStrongObject(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

NS_ASSUME_NONNULL_END
