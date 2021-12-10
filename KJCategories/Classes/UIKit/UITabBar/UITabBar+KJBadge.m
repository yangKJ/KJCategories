//
//  UITabBar+KJBadge.m
//  KJEmitterView
//
//  Created by 77。 on 2019/11/5.
//  https://github.com/YangKJ/KJCategories

#import "UITabBar+KJBadge.h"
#import <objc/runtime.h>

@implementation UITabBar (KJBadge)
+ (NSInteger)tabBarCount{
    return [objc_getAssociatedObject(self, @selector(tabBarCount)) intValue];
}
+ (void)setTabBarCount:(NSInteger)tabBarCount{
    objc_setAssociatedObject(self, @selector(tabBarCount), @(tabBarCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
/// 当前的TabBar个数
+ (void)kj_tabBarCount:(NSInteger)count{
    self.tabBarCount = count;
}
- (void)kj_showRedBadgeOnItemIndex:(NSInteger)index{
    [self kj_hideRedBadgeOnItemIndex:index];
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.backgroundColor = [UIColor redColor];
    float percentX = (index+0.6) / UITabBar.tabBarCount?:4;
    CGFloat x = ceilf(percentX * self.frame.size.width);
    CGFloat y = ceilf(0.1 * self.frame.size.height);
    badgeView.frame = CGRectMake(x, y, 13, 13);
    badgeView.layer.cornerRadius = badgeView.frame.size.width/2.;
    [self addSubview:badgeView];
}

- (void)kj_hideRedBadgeOnItemIndex:(NSInteger)index{
    UIView *view = [self viewWithTag:888 + index];
    [view removeFromSuperview];
}

@end
