//
//  KJEmitterAnimation.m
//  KJCategories
//
//  Created by 杨科军 on 2019/8/27.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "KJEmitterAnimation.h"

@interface KJEmitterAnimation ()

@property (nonatomic, strong) KJEmitterAnimationProvider *provider;
@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) CGFloat animationTime;
@property (nonatomic, strong) NSArray<KJEmitterImagePixel *> *pixelArray;
@property (nonatomic, assign) CGFloat imagewidth, imageHeight;
@property (nonatomic, copy, readwrite) void(^complete)(void);

@end

@implementation KJEmitterAnimation

/// 初始化
/// @param provider 请求参数
/// @param image 粒子动画源图
/// @param complete 动画完成回调
+ (instancetype)createWithProvider:(KJEmitterAnimationProvider *)provider
                      emitterImage:(UIImage *)image
                          complete:(nullable void(^)(void))complete{
    KJEmitterAnimation * animation = [[KJEmitterAnimation alloc] init];
    animation.provider = provider;
    [provider asyncResolutionPixelImage:image withBlock:^(NSArray<KJEmitterImagePixel *> * pixels) {
        animation.pixelArray = pixels;
    }];
    animation.complete = complete;
    animation.imagewidth = CGImageGetWidth(image.CGImage);
    animation.imageHeight = CGImageGetHeight(image.CGImage);
    [animation restart];
    return animation;
}

/// 重置
- (void)restart{
    [self reset];
    if (self.displayLink) { }
}

- (void)reset {
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
        self.animationTime = 0;
    }
}

- (void)emitteraAnimation{
    [self setNeedsDisplay];
    self.animationTime += self.provider.dropSpeed;
}

/// 绘制粒子动画效果
- (void)drawInContext:(CGContextRef)ctx{
    if (self.pixelArray.count == 0) {
        return;
    }
    NSInteger count = 0;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    for (KJEmitterImagePixel * pixel in self.pixelArray) {
        if (pixel.delayTime > _animationTime) continue;
        CGFloat time = _animationTime - pixel.delayTime;
        /// 到达目的地的粒子原地等待还没到达的粒子
        if (time >= pixel.delayDuration) {
            time = pixel.delayDuration;
            count++;
        }
        CGFloat x = [self easeInOutQuad:time
                                  begin:self.provider.pixelBeginPoint.x
                                    end:pixel.point.x + width/2 - _imagewidth/2
                               duration:pixel.delayDuration];
        CGFloat y = [self easeInOutQuad:time
                                  begin:self.provider.pixelBeginPoint.y
                                    end:pixel.point.y + height/2 - _imageHeight/2
                               duration:pixel.delayDuration];
        CGContextAddEllipseInRect(ctx, CGRectMake(x , y , 1, 1));
        CGContextSetRGBFillColor(ctx, pixel.red, pixel.green, pixel.blue, pixel.alpha);
        CGContextFillPath(ctx);
    }
    if (count == self.pixelArray.count) {
        [self reset];
        self.complete ? self.complete() : nil;
    }
}

/// 粒子需要时间
/// @param time 动画执行到当前帧所进过的时间
/// @param begin 起始位置
/// @param end 结束位置
/// @param duration 持续时间
- (CGFloat)easeInOutQuad:(CGFloat)time begin:(CGFloat)begin end:(CGFloat)end duration:(CGFloat)duration{
    CGFloat coverDistance = end - begin;
    time /= duration / 2;
    if (time < 1) {
        return coverDistance / 2 * pow(time, 2) + begin;
    }
    time --;
    return -coverDistance / 2 * (time * (time - 2) - 1) + begin;
}

#pragma mark - lazy

- (CADisplayLink *)displayLink{
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(emitteraAnimation)];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}

@end
