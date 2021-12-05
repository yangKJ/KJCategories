//
//  UIBezierPath+KJText.h
//  KJCategories
//
//  Created by abas on 2021/11/21.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (KJText)

/// 获取文字贝塞尔路径
/// @param text 文本内容
/// @param font 文本字体
/// @return 返回文字贝塞尔路径
+ (UIBezierPath *)kj_bezierPathWithText:(NSString *)text font:(UIFont *)font;

@end

NS_ASSUME_NONNULL_END
