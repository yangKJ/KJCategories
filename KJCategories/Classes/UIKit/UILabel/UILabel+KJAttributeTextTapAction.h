//
//  UILabel+KJAttributeTextTapAction.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/6.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  富文本点击事件

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KJLabelTapBlock)(UILabel * label, NSString * string, NSRange range, NSInteger index);
@interface UILabel (KJAttributeTextTapAction)

/// 是否开启点击，默认yes
@property (nonatomic, assign) BOOL openTap;
/// 点击高亮颜色，默认红色
@property (nonatomic, strong) UIColor * tapHighlightColor;
/// 是否扩大点击范围，默认yes
@property (nonatomic, assign) BOOL enlargeTapArea;

/// 给文本添加点击事件
/// @param strings 需要添加的字符串数组
/// @param withBlock 点击事件回调
- (void)kj_addAttributeTapActionWithStrings:(NSArray<NSString *> *)strings
                                  withBlock:(KJLabelTapBlock)withBlock;

/// 根据range给文本添加点击事件
/// @param ranges 需要添加的Range字符串数组
/// @param withBlock 点击事件回调
- (void)kj_addAttributeTapActionWithRanges:(NSArray<NSString *> *)ranges
                                 withBlock:(KJLabelTapBlock)withBlock;

/// 移除点击事件
- (void)kj_removeAttributeTapActions;

@end

// 备注说明：
/*
 1.必须设置字体属性
 NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:nil];
 UIFont *font = [UIFont systemFontOfSize:<#size description#>];
 [attributeString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
 label.attributedText = attributedString;
 
 2.关于文字排版的正确设置方式，设置`label.textAlignment = NSTextAlignmentCenter`会导致点击失效
 正确的设置方法如下：
 NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:nil];
 NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
 style.alignment = NSTextAlignmentCenter;
 [attributedString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, text.length)];
 label.attributedText = attributedString;
 
 */

NS_ASSUME_NONNULL_END
