//
//  UIView+KJAnimation.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/18.
//  https://github.com/YangKJ/KJCategories
//  简单动画效果链式封装

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KJAnimationManager;
@interface UIView (KJAnimation)
/// 隐式动画
- (void)kj_animationImplicitDuration:(CFTimeInterval)time animations:(void(^)(void))animations;

/// 动画组
- (CAAnimationGroup *)kj_animationMoreAnimations:(NSArray<CABasicAnimation *> *)animations;
/// 旋转动画效果
- (CABasicAnimation *)kj_animationRotateClockwise:(BOOL)clockwise
                                   makeParameter:(void(^)(KJAnimationManager *make))parameter;
/// 移动动画效果
- (CABasicAnimation *)kj_animationMovePoint:(CGPoint)point
                             makeParameter:(void(^)(KJAnimationManager *make))parameter;
/// 缩放动画效果
- (CABasicAnimation *)kj_animationZoomMultiple:(CGFloat)multiple
                                makeParameter:(void(^)(KJAnimationManager *make))parameter;
/// 渐隐动画效果
- (CABasicAnimation *)kj_animationOpacity:(CGFloat)opacity
                           makeParameter:(void(^)(KJAnimationManager *make))parameter;

@end

@interface KJAnimationManager : NSObject
#pragma mark - 公共部分
/// 重复次数，默认一直重复
@property(nonatomic,copy,readonly)KJAnimationManager *(^kRepeatCount)(NSInteger);
/// 重复时间
@property(nonatomic,copy,readonly)KJAnimationManager *(^kRepeatDuration)(CGFloat);
/// 持续时间，默认5秒
@property(nonatomic,copy,readonly)KJAnimationManager *(^kDuration)(CGFloat);
/// 是否执行逆动画，默认NO
@property(nonatomic,copy,readonly)KJAnimationManager *(^kAutoreverses)(BOOL);

#pragma mark - 旋转部分
/// 旋转速度，1：先慢后慢，2：先慢后快，3：先快后慢，其他：匀速
@property(nonatomic,copy,readonly)KJAnimationManager *(^kEaseInEaseOut)(NSInteger);
/// 翻转轴，0：z轴，1：x轴，2：y轴
@property(nonatomic,copy,readonly)KJAnimationManager *(^kTransformRotation)(NSInteger);

#pragma mark - 缩放部分
/// 开始时的倍率，默认为1
@property(nonatomic,copy,readonly)KJAnimationManager *(^kBeginMultiple)(CGFloat);

#pragma mark - 渐隐部分
/// 结束时的隐藏系数，默认为1
@property(nonatomic,copy,readonly)KJAnimationManager *(^kEndOpacity)(CGFloat);

@end

NS_ASSUME_NONNULL_END
