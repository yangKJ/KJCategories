//
//  UIView+KJGestureBlock.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/6/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

/* 使用示例 */
// [self.view kj_AddTapGestureRecognizerBlock:^(UIView *view, UIGestureRecognizer *gesture) {
//     [view removeGestureRecognizer:gesture];
// }];

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KJGestureRecognizerBlock)(UIView * view, UIGestureRecognizer * gesture);
typedef NS_ENUM(NSUInteger, KJGestureType) {
    KJGestureTypeTap,       // 点击
    KJGestureTypeDouble,    // 双击
    KJGestureTypeLongPress, // 长按
    KJGestureTypeSwipe,     // 轻扫
    KJGestureTypePan,       // 移动
    KJGestureTypeRotate,    // 旋转
    KJGestureTypePinch,     // 缩放
};
@interface UIView (KJGestureBlock)
/// 单击手势
/// @param block 手势响应回调
/// @return 返回对应手势
- (UIGestureRecognizer *)kj_AddTapGestureRecognizerBlock:(KJGestureRecognizerBlock)block;
/// 手势处理
/// @param type 手势类型
/// @param block 手势响应回调
/// @return 返回对应手势
- (UIGestureRecognizer *)kj_AddGestureRecognizer:(KJGestureType)type block:(KJGestureRecognizerBlock)block;

@end

NS_ASSUME_NONNULL_END
