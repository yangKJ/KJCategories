//
//  NSTimer+KJExtension.h
//  KJEmitterView
//
//  Created by 77。 on 2019/12/16.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (KJExtension)

/// Open an NSTimer object that can be executed repeatedly in the current thread
/// @param inerval interval time
/// @param repeats whether to repeat
/// @param complete event processing
+ (NSTimer *)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                       repeats:(BOOL)repeats
                                      complete:(void(^)(NSTimer * timer))complete;
/// Open an NSTimer object that can be executed repeatedly in the current thread
/// @param inerval interval time
/// @param repeats whether to repeat
/// @param complete event handling
/// @param mode RunLoop type
+ (NSTimer *)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval
                                       repeats:(BOOL)repeats
                                      complete:(void(^)(NSTimer * timer))complete
                                   runLoopMode:(NSRunLoopMode)mode;
/// Open a repeatable NSTimer object that needs to be added to the thread
/// @param inerval interval time
/// @param repeats whether to repeat
/// @param complete event processing
+ (NSTimer *)kj_timerWithTimeInterval:(NSTimeInterval)inerval
                              repeats:(BOOL)repeats
                             complete:(void(^)(NSTimer * timer))complete;
/// Execute immediately
- (void)kj_immediatelyTimer;

/// pause
- (void)kj_pauseTimer;

/// restart timer
- (void)kj_resumeTimer;

/// Delayed execution
/// @param interval delay
- (void)kj_resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

/// Release the timer
+ (void)kj_invalidateTimer:(NSTimer *)timer;

@end

NS_ASSUME_NONNULL_END
