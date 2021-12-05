//
//  UISlider+KJTapValue.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/9/17.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  滑杆点击改值

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UISlider (KJTapValue)

/// 开启滑杆点击修改值
/// @param tap 是否开启手动点击
/// @param withBlock 修改值回调
- (void)kj_openTapChangeValue:(BOOL)tap withBlock:(void(^)(float value))withBlock;

@end

NS_ASSUME_NONNULL_END
