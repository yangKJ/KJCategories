//
//  UIButton+KJIndicator.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJIndicator)

/// Whether the button is being submitted
@property (nonatomic, assign, readonly) bool submitting;
/// Interval between indicator and text, default 5px
@property (nonatomic, assign) CGFloat indicatorSpace;
/// Indicator color, default white
@property (nonatomic, assign) UIActivityIndicatorViewStyle indicatorType;

/// Start submitting, the indicator follows the text
/// @param title prompt text
- (void)kj_beginSubmitting:(NSString *)title;

/// End submission
- (void)kj_endSubmitting;

/// display indicator
- (void)kj_showIndicator;

/// Hide indicator
- (void)kj_hideIndicator;

@end

NS_ASSUME_NONNULL_END
