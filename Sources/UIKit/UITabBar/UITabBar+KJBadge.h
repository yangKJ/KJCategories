//
//  UITabBar+KJBadge.h
//  KJEmitterView
//
//  Created by 77。 on 2019/11/5.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol UITabBarBadgeProtocol <NSObject>

/// Delegate settings, only need to be called once in the initial place
/// @param count the number of TabBar
+ (void)kj_tabBarCount:(NSInteger)count;

@end

@interface UITabBar (KJBadge) <UITabBarBadgeProtocol>

/// Show the little red dot
- (void)kj_showRedBadgeOnItemIndex:(NSInteger)index;

/// hide the little red dot
- (void)kj_hideRedBadgeOnItemIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
