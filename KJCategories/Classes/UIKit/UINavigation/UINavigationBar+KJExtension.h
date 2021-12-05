//
//  UINavigationBar+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  导航栏管理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (KJExtension)
/// 设置导航栏背景色
@property (nonatomic, strong) UIColor *navgationBackground;
/// 设置图片背景导航栏
@property (nonatomic, strong) UIImage *navgationImage;
/// 设置自定义的返回按钮
@property (nonatomic, strong) NSString *navgationCustomBackImageName;
/// 系统导航栏分割线
@property (nonatomic, strong, readonly) UIImageView *navgationBarBottomLine;

/// 设置导航条标题颜色和字号
@property (nonatomic, copy, readonly) UINavigationBar * (^kChangeNavigationBarTitle)(UIColor *, UIFont *);
/// 设置导航条标题颜色和字号，兼容Swift方便使用
/// @param color 导航条标题颜色
/// @param font 导航条标题字号
- (instancetype)setNavigationBarTitleColor:(UIColor *)color font:(UIFont *)font ;
/// 隐藏导航条底部下划线
- (UINavigationBar *)kj_hiddenNavigationBarBottomLine;
/// 默认恢复成系统的颜色和下划线
- (void)kj_resetNavigationBarSystem;

//************************  自定义导航栏相关  ************************
/// 更改导航栏
/// @param image 导航栏图片
/// @param color 导航栏背景色
- (instancetype)kj_customNavgationBackImage:(UIImage *_Nullable)image
                                 background:(UIColor *_Nullable)color;
/// 更改透明度
- (instancetype)kj_customNavgationAlpha:(CGFloat)alpha;
/// 导航栏背景高度，备注：这里并没有改导航栏高度，只是改了自定义背景高度
- (instancetype)kj_customNavgationHeight:(CGFloat)height;
/// 隐藏底线
- (instancetype)kj_customNavgationHiddenBottomLine:(BOOL)hidden;
/// 更改自定义底部线条颜色
//- (instancetype)kj_customNavgationChangeBottomLineColor:(UIColor *)color;
/// 还原回系统导航栏
- (void)kj_customNavigationRestoreSystemNavigation;

@end

NS_ASSUME_NONNULL_END
