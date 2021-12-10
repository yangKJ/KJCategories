//
//  UIView+KJKeyboard.m
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/6.
//  https://github.com/YangKJ/KJCategories

#import "UIView+KJKeyboard.h"
#import <objc/runtime.h>

@implementation UIView (KJKeyboard)

- (void)kj_automaticFollowKeyboard:(UIView *)mainView{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kj_showKeyboard:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(kj_hideKeyboard:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    self.mainView = mainView;
    self.mainViewFrame = mainView.frame;
}

- (void)kj_addHideKeyboardGesture{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(kj_keyboardHide)];
    gesture.numberOfTapsRequired = 1;
    gesture.cancelsTouchesInView = NO;
    [self addGestureRecognizer:gesture];
}
- (void)kj_keyboardHide{
    [self endEditing:YES];
}

- (void)kj_releaseKeyboardNotification{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - notification

- (void)kj_showKeyboard:(NSNotification *)notification{
    if (self.isFirstResponder == YES) {
        //键盘出现后的位置
        CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        //键盘弹起时的动画效果
        UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
        //键盘动画时长
        NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
        CGFloat bottom = [self.superview convertPoint:self.frame.origin toView:self.mainView].y + self.frame.size.height;
        CGFloat extraHeight = [self kj_hasSystemNavigationBarExtraHeight];
        if ((bottom+extraHeight) > keyboardFrame.origin.y) {
            [UIView animateWithDuration:duration delay:0 options:option animations:^{
                CGRect frame = self.mainView.frame;
                frame.origin.y = - (bottom - keyboardFrame.origin.y);
                self.mainView.frame = frame;
            } completion:^(BOOL finished) {
                [self layoutIfNeeded];
            }];
        }
    }
}

- (void)kj_hideKeyboard:(NSNotification *)notification{
    UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] intValue];
    NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration delay:0 options:option animations:^{
        CGFloat extraHeight = [self kj_hasSystemNavigationBarExtraHeight];
        CGRect frame = self.mainView.frame;
        frame.origin.y = self.mainViewFrame.origin.y + extraHeight;
        self.mainView.frame = frame;
    } completion:^(BOOL finished) {
        [self layoutIfNeeded];
    }];
}

//计算键盘弹出时的额外高度
- (CGFloat)kj_hasSystemNavigationBarExtraHeight {
    if ([self kj_keyboardViewController].navigationController != nil) {
        return 0.0;//相对于零点开始
    }
    UINavigationBar *navigationBar = [self kj_keyboardViewController].navigationController.navigationBar;
    // 相对于导航栏高度开始的 如果设置了导航栏的translucent = YES，添加子视图的坐标原点相对屏幕坐标是(0,0).
    // 如果设置了translucent = NO，添加子视图的坐标原点相对屏幕坐标就是(0, navViewHeight)
    if (navigationBar.hidden == NO && navigationBar.translucent == NO) {
        // 判断是否隐藏的电池条
        if ([UIApplication sharedApplication].statusBarHidden == NO) {
            return [[UIApplication sharedApplication] statusBarFrame].size.height + navigationBar.frame.size.height;
        } else {
            return navigationBar.frame.size.height;
        }
    }
    return 0.0;
}

- (UIViewController *)kj_keyboardViewController{
    for (UIView *next = self; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

#pragma mark - associated

- (UIView *)mainView{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setMainView:(UIView *)mainView{
    objc_setAssociatedObject(self, @selector(mainView), mainView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGRect)mainViewFrame{
    id obj = objc_getAssociatedObject(self, _cmd);
    return [obj CGRectValue];
}
- (void)setMainViewFrame:(CGRect)mainViewFrame{
    objc_setAssociatedObject(self, @selector(mainViewFrame), [NSValue valueWithCGRect:mainViewFrame], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
