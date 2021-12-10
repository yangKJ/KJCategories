//
//  UIResponder+KJAdapt.h
//  KJEmitterView
//
//  Created by 77。 on 2019/10/14.
//  https://github.com/YangKJ/KJCategories

// In the first place AppDelegate or call [UIResponder kj_adaptModelType:KJAdaptTypeIPhone6];
// For example, adapt `Rect`
// Replace CGRectMake with AdaptRectMake where you need to adapt
// view.frame = CGRectMake(0, 0, 10, 10);
// view.frame = AdaptRectMake(0, 0, 10, 10);
// A simple screen ratio adaptation can be completed

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, KJAdaptType) {
    KJAdaptTypeIPhone4 = 0, /// 3.5 inches, 320 x 480pt
    KJAdaptTypeIPhone5,     /// 4.0 inches, 320 x 568pt
    KJAdaptTypeIPhone6,     /// 4.7 inches, 375 x 667pt
    KJAdaptTypeIPhone6P,    /// 5.5 inches, 414 x 736pt
    KJAdaptTypeIPhoneX,     /// 5.8 inches, 375 x 812pt
    KJAdaptTypeIPhoneXR,    /// 6.1 inches, 414 x 896pt
    KJAdaptTypeIPhoneXSMax, /// 6.5 inches, 414 x 896pt
    KJAdaptTypeIPhone12,    /// 6.1 inches, 390 x 844pt
    KJAdaptTypeIPhone12Mini,/// 5.4 inches, 375 x 812pt
    KJAdaptTypeIPhone12ProMax, /// 6.7 inches, 428 x 926pt
};
@protocol KJResponderAdaptProtocol <NSObject>

/// Design drawing model, you only need to call it once in the initial place
+ (void)kj_adaptModelType:(KJAdaptType)type;

@end

@interface UIResponder (KJAdapt)<KJResponderAdaptProtocol>
/// Horizontal ratio adaptation
CGFloat AdaptLevel(CGFloat level);
/// Vertical ratio adaptation, the value is horizontal ratio adaptation
CGFloat AdaptVertical(CGFloat vertical);
/// Adapt to CGpoint
CGPoint AdaptPointMake(CGFloat x, CGFloat y);
/// Adapt CGSize
CGSize AdaptSizeMake(CGFloat width, CGFloat height);
/// Adapt to CGRect
CGRect AdaptRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height);
/// Adapt to UIEdgeInsets
UIEdgeInsets AdaptEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right);

#pragma mark - responder

/// Get the first responder
- (UIResponder *)kj_responderWithClass:(Class)clazz;

///
- (BOOL)kj_responderSendAction:(SEL)action Sender:(id)sender;

@end

NS_ASSUME_NONNULL_END
