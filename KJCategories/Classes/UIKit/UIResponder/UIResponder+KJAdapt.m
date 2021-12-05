//
//  UIResponder+KJAdapt.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/14.
//  https://github.com/YangKJ/KJCategories

#import "UIResponder+KJAdapt.h"
#import <objc/runtime.h>

@implementation UIResponder (KJAdapt)

+ (KJAdaptType)adaptType{
    return (KJAdaptType)[objc_getAssociatedObject(self, @selector(adaptType)) intValue];
}
+ (void)setAdaptType:(KJAdaptType)adaptType{
    objc_setAssociatedObject(self, @selector(adaptType), @(adaptType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
+ (void)kj_adaptModelType:(KJAdaptType)type{
    self.adaptType = type;
}
CGFloat AdaptLevel(CGFloat level){
    if (level == 0) return 0.0;
    CGFloat width = [[UIScreen mainScreen] bounds].size.width;
    switch (UIResponder.adaptType) {
        case KJAdaptTypeIPhone4:width = 320;break;
        case KJAdaptTypeIPhone5:width = 320;break;
        case KJAdaptTypeIPhone6:width = 375;break;
        case KJAdaptTypeIPhone6P:width = 414;break;
        case KJAdaptTypeIPhoneX:width = 375;break;
        case KJAdaptTypeIPhoneXR:width = 414;break;
        case KJAdaptTypeIPhoneXSMax:width = 414;break;
        case KJAdaptTypeIPhone12:width = 390;break;
        case KJAdaptTypeIPhone12Mini:width = 375;break;
        case KJAdaptTypeIPhone12ProMax:width = 428;break;
        default:break;
    }
    return level * ([[UIScreen mainScreen] bounds].size.width / width);
}
CGFloat AdaptVertical(CGFloat vertical){
    return AdaptLevel(vertical);
}
CGPoint AdaptPointMake(CGFloat x, CGFloat y){
    return CGPointMake(AdaptLevel(x), AdaptVertical(y));
}
CGSize AdaptSizeMake(CGFloat width, CGFloat height){
    return CGSizeMake(AdaptLevel(width), AdaptVertical(height));
}
CGRect AdaptRectMake(CGFloat x, CGFloat y, CGFloat width, CGFloat height){
    return CGRectMake(AdaptLevel(x),
                      AdaptVertical(y),
                      AdaptLevel(width),
                      AdaptVertical(height));
}
UIEdgeInsets AdaptEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right){
    return UIEdgeInsetsMake(AdaptVertical(top),
                            AdaptLevel(left),
                            AdaptVertical(bottom),
                            AdaptLevel(right));
}

#pragma mark - responder
- (UIResponder *)kj_responderWithClass:(Class)clazz{
    UIResponder *responder = self;
    while ((responder = [responder nextResponder])) {
        if ([responder isKindOfClass:clazz]) {
            return responder;
        }
    }
    return nil;
}

- (BOOL)kj_responderSendAction:(SEL)action Sender:(id)sender{
    id target = sender;
    while (target && ![target canPerformAction:action withSender:sender]) {
        target = [target nextResponder];
    }
    if (target == nil) return NO;
    return [[UIApplication sharedApplication] sendAction:action to:target from:sender forEvent:nil];
}

@end
