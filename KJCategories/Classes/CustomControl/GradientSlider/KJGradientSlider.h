//
//  KJGradientSlider.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/8/24.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  渐变色滑块

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KJGradientSlider : UISlider

/// 颜色数组，默认白色
@property(nonatomic,strong) NSArray<UIColor *> *colors;
/// 每个颜色对应的位置信息
@property(nonatomic,strong) NSArray<NSNumber *> *locations;
/// 颜色的高度，默认2.5px
@property(nonatomic,assign) CGFloat colorHeight;
/// 边框宽度，默认0px
@property(nonatomic,assign) CGFloat borderWidth;
/// 边框颜色，默认黑色
@property(nonatomic,strong) UIColor *borderColor;
/// 当前进度，用于外界kvo
@property(nonatomic,assign,readonly) CGFloat progress;

/// 重新设置UI
- (void)updateUI;

/// 移动中
/// @param timeSpan 响应时间间隔，控制滑动过程中非常频繁调用问题
/// @param withBlock 移动中回调
- (void)movingWithTimeSpan:(CGFloat)timeSpan withBlock:(void(^)(CGFloat value))withBlock;

/// 移动结束
- (void)moveEndBlock:(void(^)(CGFloat value))withBlock;

@end

NS_ASSUME_NONNULL_END
