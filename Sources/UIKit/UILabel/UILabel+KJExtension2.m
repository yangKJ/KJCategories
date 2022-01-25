//
//  UILabel+KJExtension2.m
//  KJEmitterView
//
//  Created by 77。 on 2021/10/28.
//  https://github.com/YangKJ/KJCategories

#import "UILabel+KJExtension2.h"
#import <objc/runtime.h>

@implementation UILabel (KJExtension2)

- (KJLabelTextAlignmentType)customTextAlignment{
    return (KJLabelTextAlignmentType)[objc_getAssociatedObject(self, @selector(customTextAlignment)) integerValue];
}
- (void)setCustomTextAlignment:(KJLabelTextAlignmentType)customTextAlignment{
    objc_setAssociatedObject(self, @selector(customTextAlignment), @(customTextAlignment), OBJC_ASSOCIATION_ASSIGN);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self.class, @selector(drawTextInRect:)),
                                       class_getInstanceMethod(self.class, @selector(kj_drawTextInRect:)));
    });
    switch (customTextAlignment) {
        case KJLabelTextAlignmentTypeRight:
        case KJLabelTextAlignmentTypeRightTop:
        case KJLabelTextAlignmentTypeRightBottom:
            self.textAlignment = NSTextAlignmentRight;
            break;
        case KJLabelTextAlignmentTypeLeft:
        case KJLabelTextAlignmentTypeLeftTop:
        case KJLabelTextAlignmentTypeLeftBottom:
            self.textAlignment = NSTextAlignmentLeft;
            break;
        case KJLabelTextAlignmentTypeCenter:
        case KJLabelTextAlignmentTypeTopCenter:
        case KJLabelTextAlignmentTypeBottomCenter:
            self.textAlignment = NSTextAlignmentCenter;
            break;
        default:
            break;
    }
}
- (void)kj_drawTextInRect:(CGRect)rect{
    switch (self.customTextAlignment) {
        case KJLabelTextAlignmentTypeRight:
        case KJLabelTextAlignmentTypeLeft:
        case KJLabelTextAlignmentTypeCenter:
            [self kj_drawTextInRect:rect];
            break;
        case KJLabelTextAlignmentTypeBottomCenter:
        case KJLabelTextAlignmentTypeLeftBottom:
        case KJLabelTextAlignmentTypeRightBottom:{
            CGRect textRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
            textRect.origin = CGPointMake(textRect.origin.x, -CGRectGetMaxY(textRect)+rect.size.height);
            [self kj_drawTextInRect:textRect];
        } break;
        default:{
            CGRect textRect = [self textRectForBounds:rect limitedToNumberOfLines:self.numberOfLines];
            [self kj_drawTextInRect:textRect];
        } break;
    }
}

#pragma mark - 长按复制功能
- (BOOL)copyable{
    return [objc_getAssociatedObject(self, @selector(copyable)) boolValue];
}
- (void)setCopyable:(BOOL)copyable{
    objc_setAssociatedObject(self, @selector(copyable), @(copyable), OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}
/// 移除拷贝长按手势
- (void)kj_removeCopyLongPressGestureRecognizer{
    [self removeGestureRecognizer:self.copyGesture];
}
- (void)attachTapHandler{
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:self.copyGesture];
}
- (void)handleTap:(UIGestureRecognizer*)recognizer{
    [self becomeFirstResponder];
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:NSLocalizedString(@"复制", nil) action:@selector(kj_copyText)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}
// 复制时执行的方法
- (void)kj_copyText{
    UIPasteboard *board = [UIPasteboard generalPasteboard];
    if (objc_getAssociatedObject(self, @"expectedText")) {
        board.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        if (self.text) {
            board.string = self.text;
        } else {
            board.string = self.attributedText.string;
        }
    }
}
- (BOOL)canBecomeFirstResponder{
    return [objc_getAssociatedObject(self, @selector(copyable)) boolValue];
}
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    return (action == @selector(kj_copyText));
}
#pragma mark - lazzing
- (UILongPressGestureRecognizer*)copyGesture{
    UILongPressGestureRecognizer *gesture = objc_getAssociatedObject(self, @selector(copyGesture));
    if (gesture == nil) {
        gesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        objc_setAssociatedObject(self, @selector(copyGesture), gesture, OBJC_ASSOCIATION_RETAIN);
    }
    return gesture;
}

@end
