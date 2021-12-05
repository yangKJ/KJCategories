//
//  UITextView+KJLimitCounter.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  限制处理

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface UITextView (KJLimitCounter)
/// 限制字数
@property(nonatomic,assign)IBInspectable NSInteger limitCount;
/// 限制区域右边距，默认10
@property(nonatomic,assign)IBInspectable CGFloat limitMargin;
/// 限制区域高度，默认20
@property(nonatomic,assign)IBInspectable CGFloat limitHeight;
/// 统计限制字数Label
@property(nonatomic,strong,readonly) UILabel *limitLabel;

@end

NS_ASSUME_NONNULL_END
