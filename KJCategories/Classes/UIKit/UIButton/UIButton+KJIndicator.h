//
//  UIButton+KJIndicator.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  指示器(系统自带菊花)

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (KJIndicator)

/// 按钮是否正在提交中
@property(nonatomic,assign,readonly)bool submitting;
/// 指示器和文字间隔，默认5px
@property(nonatomic,assign)CGFloat indicatorSpace;
/// 指示器颜色，默认白色
@property(nonatomic,assign)UIActivityIndicatorViewStyle indicatorType;

/// 开始提交，指示器跟随文字
/// @param title 提示文字
- (void)kj_beginSubmitting:(NSString *)title;

/// 结束提交
- (void)kj_endSubmitting;

/// 显示指示器
- (void)kj_showIndicator;

/// 隐藏指示器
- (void)kj_hideIndicator;

@end

NS_ASSUME_NONNULL_END
