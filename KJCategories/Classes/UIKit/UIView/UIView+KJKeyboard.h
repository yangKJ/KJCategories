//
//  UIView+KJKeyboard.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/6.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  键盘监听

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KJKeyboard)

/// 根据键盘的弹出与收回，自动调整控件位置，防止键盘遮挡输入框
/// 使用示例：[self.textField kj_automaticFollowKeyboard:self.view]
/// @param mainView 要移动的主视图
- (void)kj_automaticFollowKeyboard:(UIView *)mainView;

/// 添加收起键盘的手势
- (void)kj_addHideKeyboardGesture;

/// 释放监听键盘的通知
- (void)kj_releaseKeyboardNotification;

@end

NS_ASSUME_NONNULL_END
