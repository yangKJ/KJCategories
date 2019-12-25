//
//  NSTimer+KJSolve.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/12/25.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "NSTimer+KJSolve.h"

@implementation NSTimer (KJSolve)
/// 解决计时器循环引用
+ (NSTimer *)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval Repeats:(BOOL)repeats Block:(void(^)(NSTimer *timer))block{
    return [NSTimer scheduledTimerWithTimeInterval:inerval target:self selector:@selector(blcokInvoke:) userInfo:[block copy] repeats:repeats];
}
+ (void)blcokInvoke:(NSTimer*)timer {
    void (^block)(NSTimer *timer) = timer.userInfo;
    if (block) block(timer);
}
@end
