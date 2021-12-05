//
//  UIViewController+KJExtension.h
//  KJEmitterView
//
//  Created by 77。 on 2021/5/28.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KJExtension)

/// 跳转回指定控制器
/// @param clazz 指定控制器类名
/// @param complete 成功回调出该控制器
/// @return 返回是否跳转成功
- (BOOL)kj_popTargetViewController:(Class)clazz complete:(void(^)(UIViewController * vc))complete;

/// 切换根视图控制器
- (void)kj_changeRootViewController:(void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
