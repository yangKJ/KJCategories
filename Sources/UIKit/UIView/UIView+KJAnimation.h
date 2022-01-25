//
//  UIView+KJAnimation.h
//  KJEmitterView
//
//  Created by 77。 on 2019/12/18.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class KJAnimationManager;

/// Simple animation effect chain packaging
@interface UIView (KJAnimation)

/// Animation group
- (CAAnimationGroup *)kj_animationMoreAnimations:(NSArray<CABasicAnimation *> *)animations;

/// Rotation animation effect
- (CABasicAnimation *)kj_animationRotateClockwise:(BOOL)clockwise
                                   makeParameter:(void(^)(KJAnimationManager *make))parameter;

/// Moving animation effect
- (CABasicAnimation *)kj_animationMovePoint:(CGPoint)point
                             makeParameter:(void(^)(KJAnimationManager *make))parameter;

/// Zoom animation effect
- (CABasicAnimation *)kj_animationZoomMultiple:(CGFloat)multiple
                                makeParameter:(void(^)(KJAnimationManager *make))parameter;

/// Fading animation effect
- (CABasicAnimation *)kj_animationOpacity:(CGFloat)opacity
                           makeParameter:(void(^)(KJAnimationManager *make))parameter;

@end

@interface KJAnimationManager : NSObject

#pragma mark - public part
/// The number of repetitions, the default has been repeated
@property (nonatomic, copy, readonly) KJAnimationManager *(^kRepeatCount)(NSInteger);
/// Repeat time
@property (nonatomic, copy, readonly) KJAnimationManager *(^kRepeatDuration)(CGFloat);
/// Duration, 5 seconds by default
@property (nonatomic, copy, readonly) KJAnimationManager *(^kDuration)(CGFloat);
/// Whether to perform inverse animation, default NO
@property (nonatomic, copy, readonly) KJAnimationManager *(^kAutoreverses)(BOOL);

#pragma mark - Rotating part
/// Rotation speed,
/// 1: first slow and then slow,
/// 2: first slow and then fast,
/// 3: first fast and then slow,
/// others: uniform speed
@property (nonatomic, copy, readonly) KJAnimationManager *(^kEaseInEaseOut)(NSInteger);
/// Flip axis, 0: z axis, 1: x axis, 2: y axis
@property (nonatomic, copy, readonly) KJAnimationManager *(^kTransformRotation)(NSInteger);

#pragma mark - zoom part
/// The magnification at the beginning, the default is 1
@property (nonatomic, copy, readonly) KJAnimationManager *(^kBeginMultiple)(CGFloat);

#pragma mark - fade part
/// The hiding coefficient at the end, the default is 1
@property (nonatomic, copy, readonly) KJAnimationManager *(^kEndOpacity)(CGFloat);

@end

NS_ASSUME_NONNULL_END
