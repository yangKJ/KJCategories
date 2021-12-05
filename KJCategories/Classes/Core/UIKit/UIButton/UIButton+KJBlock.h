//
//  UIButton+KJBlock.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/4/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  点击事件ButtonBlock

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^KJButtonBlock)(UIButton * kButton);
IB_DESIGNABLE
@interface UIButton (KJBlock)

/// 添加点击事件，默认UIControlEventTouchUpInside
- (void)kj_addAction:(void(^)(UIButton * kButton))block;
/// 添加事件，不支持多枚举形式
- (void)kj_addAction:(KJButtonBlock)block forControlEvents:(UIControlEvents)controlEvents;

/// 点击事件间隔，设置非零取消间隔
@property (nonatomic, assign) IBInspectable CGFloat timeInterval;

#pragma mark - 扩大点击域

/// 扩大统一点击域，支持Xib快捷设置
@property (nonatomic, assign) IBInspectable CGFloat enlargeClick;
/// 设置按钮额外热区
@property (nonatomic, assign) UIEdgeInsets touchAreaInsets;
/// 扩大点击域
@property (nonatomic, copy, readonly) void(^kEnlargeEdge)(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

@end

NS_ASSUME_NONNULL_END
