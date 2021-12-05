//
//  UITextView+KJPlaceHolder.h
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
IB_DESIGNABLE
@interface UITextView (KJPlaceHolder)
/// 占位符文字
@property(nonatomic,strong)IBInspectable NSString *placeHolder;
/// 占位符Label
@property(nonatomic,strong,readonly)UILabel *placeHolderLabel;

@end

NS_ASSUME_NONNULL_END
