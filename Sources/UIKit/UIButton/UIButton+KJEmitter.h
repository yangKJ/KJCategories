//
//  UIButton+KJEmitter.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJEmitter)

/// Whether to enable particle effects
@property (nonatomic, assign) BOOL openEmitter;
/// Particles, note that the name attribute should not be changed
@property (nonatomic, strong, readonly) CAEmitterCell * emitterCell;

/// Set particle effect
/// @param image particle image
/// @param open Whether to enable particle effects
- (void)kj_buttonSetEmitterImage:(UIImage * _Nullable)image OpenEmitter:(BOOL)open;

@end

NS_ASSUME_NONNULL_END
