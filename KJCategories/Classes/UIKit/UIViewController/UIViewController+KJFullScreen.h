//
//  UIViewController+KJFullScreen.h
//  Winpower
//
//  Created by 杨科军 on 2019/10/10.
//  Copyright © 2019 cq. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  充满全屏处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (KJFullScreen) <UINavigationControllerDelegate>

/// 是否开启侧滑返回手势
- (void)kj_openPopGesture:(BOOL)open;

/// 系统自带分享
/// @param items 分享数据
/// @param complete 分享完成回调处理
/// @return 返回分享控制器
- (UIActivityViewController *)kj_shareActivityWithItems:(NSArray *)items
                                               complete:(nullable void(^)(BOOL success))complete;

@end

NS_ASSUME_NONNULL_END
