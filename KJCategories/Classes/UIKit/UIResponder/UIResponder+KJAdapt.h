//
//  UIResponder+KJAdapt.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/14.
//  https://github.com/YangKJ/KJCategories
//  简单的屏幕比例适配

//  在最初的地方AppDelegate里面或最初地方调用 [UIResponder kj_adaptModelType:KJAdaptTypeIPhone6];
//  举个例子适配`Rect`
//  在需要适配的地方 替换 CGRectMake 为 AdaptRectMake
//  view.frame = CGRectMake(0, 0, 10, 10);
//  view.frame = AdaptRectMake(0, 0, 10, 10);
//  即可完成简单的屏幕比例适配

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 适配类型 设计图类型
typedef NS_ENUM(NSInteger, KJAdaptType) {
    KJAdaptTypeIPhone4 = 0, /// 3.5英寸，320 x 480pt
    KJAdaptTypeIPhone5,     /// 4.0英寸，320 x 568pt
    KJAdaptTypeIPhone6,     /// 4.7英寸，375 x 667pt
    KJAdaptTypeIPhone6P,    /// 5.5英寸，414 x 736pt
    KJAdaptTypeIPhoneX,     /// 5.8英寸，375 x 812pt
    KJAdaptTypeIPhoneXR,    /// 6.1英寸，414 x 896pt
    KJAdaptTypeIPhoneXSMax, /// 6.5英寸，414 x 896pt
    KJAdaptTypeIPhone12,    /// 6.1英寸，390 x 844pt
    KJAdaptTypeIPhone12Mini,/// 5.4英寸，375 x 812pt
    KJAdaptTypeIPhone12ProMax,/// 6.7英寸，428 x 926pt
};
@protocol KJResponderAdaptProtocol <NSObject>

/// 设计图机型，只需要在最初的地方调用一次即可
+ (void)kj_adaptModelType:(KJAdaptType)type;

@end

@interface UIResponder (KJAdapt)<KJResponderAdaptProtocol>
/// 水平比例适配
CGFloat AdaptLevel(CGFloat level);
/// 竖直比例适配，取值为水平比例适配
CGFloat AdaptVertical(CGFloat vertical);
/// 适配CGpoint
CGPoint AdaptPointMake(CGFloat x, CGFloat y);
/// 适配CGSize
CGSize AdaptSizeMake(CGFloat width, CGFloat height);
/// 适配CGRect
CGRect AdaptRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height);
/// 适配UIEdgeInsets
UIEdgeInsets AdaptEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

#pragma mark - responder

/// 获取第一响应者
- (UIResponder *)kj_responderWithClass:(Class)clazz;
///
- (BOOL)kj_responderSendAction:(SEL)action Sender:(id)sender;

@end

NS_ASSUME_NONNULL_END
