//
//  UITextView+KJLimitCounter.h
//  CategoryDemo
//
//  Created by 77。 on 2018/7/12.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface UITextView (KJLimitCounter)

/// Limit the number of words
@property (nonatomic, assign) IBInspectable NSInteger limitCount;
/// Right margin of restricted area, default 10
@property (nonatomic, assign) IBInspectable CGFloat limitMargin;
/// Restricted area height, default 20
@property (nonatomic, assign) IBInspectable CGFloat limitHeight;
/// Statistics limit the number of words Label
@property (nonatomic, strong, readonly) UILabel *limitLabel;

@end

NS_ASSUME_NONNULL_END
