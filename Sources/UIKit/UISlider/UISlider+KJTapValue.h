//
//  UISlider+KJTapValue.h
//  KJEmitterView
//
//  Created by 77。 on 2019/9/17.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISlider (KJTapValue)

/// Open the slider and click to modify the value
/// @param tap Whether to enable manual tap
/// @param withBlock modify value callback
- (void)kj_openTapChangeValue:(BOOL)tap withBlock:(void(^)(float value))withBlock;

@end

NS_ASSUME_NONNULL_END
