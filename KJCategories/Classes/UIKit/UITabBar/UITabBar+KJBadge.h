//
//  UITabBar+KJBadge.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/5.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UITabBarBadgeProtocol <NSObject>

/// 委托设置，只需要在最初的地方调用一次即可
/// @param count TabBar个数
+ (void)kj_tabBarCount:(NSInteger)count;

@end

@interface UITabBar (KJBadge) <UITabBarBadgeProtocol>

/// 显示小红点
- (void)kj_showRedBadgeOnItemIndex:(NSInteger)index;
/// 隐藏小红点
- (void)kj_hideRedBadgeOnItemIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
