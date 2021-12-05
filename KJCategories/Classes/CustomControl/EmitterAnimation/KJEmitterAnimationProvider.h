//
//  KJEmitterAnimationProvider.h
//  KJCategories
//
//  Created by 杨科军 on 2019/8/27.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KJEmitterImagePixel;
@interface KJEmitterAnimationProvider : NSObject

/// 每行每列显示的最大粒子数目，设置零代表每个像素点为粒子
@property (nonatomic, assign) NSInteger maxPixels;
/// 粒子出生位置，默认`CGPointZero`
@property (nonatomic, assign) CGPoint pixelBeginPoint;
/// 像素粒子随机范围
@property (nonatomic, assign) CGFloat pixelRandomRange;
/// 改变粒子的颜色，默认像素点颜色
@property (nonatomic, strong, nullable) UIColor *pixelColor;
/// 忽略黑色粒子，默认为NO
@property (nonatomic, assign) BOOL blockIgnored;
/// 忽略白色粒子，默认为NO
@property (nonatomic, assign) BOOL whiteIgnored;
/// 粒子下落速度，默认`0.5`
/// 该值越大下落的越快，动画持续时间就越短
@property (nonatomic, assign) CGFloat dropSpeed;

/// 将图片拆分为像素粒子
- (NSArray<KJEmitterImagePixel *> *)resolutionImagePixels:(UIImage *)image;

/// 异步拆分像素粒子
- (void)asyncResolutionPixelImage:(UIImage *)image
                        withBlock:(void(^)(NSArray<KJEmitterImagePixel *> *pixels))withBlock;

@end

/// 内部参数
@interface KJEmitterImagePixel : NSObject

@property (nonatomic, assign) CGFloat red;
@property (nonatomic, assign) CGFloat green;
@property (nonatomic, assign) CGFloat blue;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGFloat randomPointRange;
@property (nonatomic, assign) CGFloat delayTime;
@property (nonatomic, assign) CGFloat delayDuration;

@end


NS_ASSUME_NONNULL_END
