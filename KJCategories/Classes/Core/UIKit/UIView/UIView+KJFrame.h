//
//  UIView+KJFrame.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  轻量级布局

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define kKeyWindow \
({UIWindow *window;\
if (@available(iOS 13.0, *)) {\
window = [UIApplication sharedApplication].windows.firstObject;\
} else {\
window = [UIApplication sharedApplication].keyWindow;\
}\
window;})
// 判断是否为iPhone X 系列
#define iPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 13.0, *)) {\
isPhoneX = [UIApplication sharedApplication].windows.firstObject.safeAreaInsets.bottom > 0.0;\
} else if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
// tabBar height
#define kTABBAR_HEIGHT (iPhoneX ? (49.f + 34.f) : 49.f)
// statusBar height
#define kSTATUSBAR_HEIGHT (iPhoneX ? 44.0f : 20.f)
// navigationBar height
#define kNAVIGATION_HEIGHT (44.f)
// (navigationBar + statusBar) height
#define kSTATUSBAR_NAVIGATION_HEIGHT (iPhoneX ? 88.0f : 64.f)
// tabar距底边高度
#define kBOTTOM_SPACE_HEIGHT (iPhoneX ? 34.0f : 0.0f)
// 屏幕尺寸
#define kScreenSize ([UIScreen mainScreen].bounds.size)
#define kScreenW    ([UIScreen mainScreen].bounds.size.width)
#define kScreenH    ([UIScreen mainScreen].bounds.size.height)
#define kScreenRect CGRectMake(0, 0, kScreenW, kScreenH)
// AutoSize
#define kAutoW(x)   (x * kScreenW / 375.0)
#define kAutoH(x)   (x * kScreenH / 667.0)
// 一个像素
#define kOnePixel   (1.0 / [UIScreen mainScreen].scale)

@interface UIView (KJFrame)
@property(nonatomic,assign)CGSize  size;// 大小
@property(nonatomic,assign)CGPoint origin;// 位置
@property(nonatomic,assign)CGFloat x;// x坐标
@property(nonatomic,assign)CGFloat y;// y坐标
@property(nonatomic,assign)CGFloat width;// 宽度
@property(nonatomic,assign)CGFloat height;// 高度
@property(nonatomic,assign)CGFloat centerX;// 中心点x
@property(nonatomic,assign)CGFloat centerY;// 中心点y
@property(nonatomic,assign)CGFloat left;// 左边距离
@property(nonatomic,assign)CGFloat right;// 右边距离
@property(nonatomic,assign)CGFloat top;// 顶部距离
@property(nonatomic,assign)CGFloat bottom;// 底部距离
@property(nonatomic,assign,readonly)CGFloat maxX;// x + width
@property(nonatomic,assign,readonly)CGFloat maxY;// y + height
@property(nonatomic,assign,readonly)CGFloat subviewMaxX;// 获取子视图的最高X
@property(nonatomic,assign,readonly)CGFloat subviewMaxY;// 获取子视图的最高Y
@property(nonatomic,assign,readonly)CGFloat masonryX;// 自动布局x
@property(nonatomic,assign,readonly)CGFloat masonryY;// 自动布局y
@property(nonatomic,assign,readonly)CGFloat masonryWidth;// 自动布局宽度
@property(nonatomic,assign,readonly)CGFloat masonryHeight;// 自动布局高度
@property(nonatomic,strong,readonly)UIViewController *viewController;// 当前控制器
@property(nonatomic,assign,readonly)BOOL showKeyWindow;// 是否显示在主窗口
/// 顶部控制器
@property(nonatomic,strong,class,readonly)UIViewController *topViewController;

/// 将视图中心置于其父视图，支持旋转方向后处理
- (void)kj_centerToSuperview;
/// 距父视图右边距离
- (void)kj_rightToSuperview:(CGFloat)right;
/// 距父视图下边距离
- (void)kj_bottomToSuperview:(CGFloat)bottom;

/// 隐藏/显示所有子视图
- (void)kj_hideSubviews:(BOOL)hide operation:(BOOL(^)(UIView *subview))operation;
/// 寻找子视图
- (UIView *)kj_findSubviewRecursively:(BOOL(^)(UIView *subview, BOOL * stop))recurse;
/// 移除所有子视图
- (void)kj_removeAllSubviews;
/// 更新尺寸，使用autolayout布局时需要刷新约束才能获取到真实的frame
- (void)kj_updateFrame;

@end

NS_ASSUME_NONNULL_END
