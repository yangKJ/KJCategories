//
//  NSTimer+KJSolve.h
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/12/25.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (KJSolve)

+ (NSTimer*)kj_scheduledTimerWithTimeInterval:(NSTimeInterval)inerval Repeats:(BOOL)repeats Block:(void(^)(NSTimer *timer))block;

@end

NS_ASSUME_NONNULL_END
