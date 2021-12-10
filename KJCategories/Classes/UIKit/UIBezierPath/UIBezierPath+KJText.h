//
//  UIBezierPath+KJText.h
//  KJCategories
//
//  Created by yangkejun on 2021/11/21.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (KJText)

/// Get the text Bezier path
/// @param text text content
/// @param font text font
/// @return returns the text Bezier path
+ (UIBezierPath *)kj_bezierPathWithText:(NSString *)text font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
