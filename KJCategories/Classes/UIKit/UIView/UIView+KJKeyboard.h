//
//  UIView+KJKeyboard.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/6.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KJKeyboard)

/// Automatically adjust the position of the control according to the pop-up and retraction of the keyboard to prevent the keyboard from blocking the input box
/// Usage example: [self.textField kj_automaticFollowKeyboard:self.view]
/// @param mainView The main view to be moved
- (void)kj_automaticFollowKeyboard:(UIView *)mainView;

/// Add a gesture to retract the keyboard
- (void)kj_addHideKeyboardGesture;

/// Release the notification of the monitor keyboard
- (void)kj_releaseKeyboardNotification;

@end

NS_ASSUME_NONNULL_END
