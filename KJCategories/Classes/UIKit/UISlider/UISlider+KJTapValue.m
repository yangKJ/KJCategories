//
//  UISlider+KJTapValue.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/9/17.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "UISlider+KJTapValue.h"
#import <objc/runtime.h>

@implementation UISlider (KJTapValue)

/// 开启滑杆点击修改值
/// @param tap 是否开启手动点击
/// @param withBlock 修改值回调
- (void)kj_openTapChangeValue:(BOOL)tap withBlock:(void(^)(float value))withBlock{
    self.openTap = tap;
    self.withBlock = withBlock;
}

- (BOOL)openTap{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setOpenTap:(BOOL)openTap{
    objc_setAssociatedObject(self, @selector(openTap), [NSNumber numberWithBool:openTap], OBJC_ASSOCIATION_ASSIGN);
}
- (void(^)(float))withBlock{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setWithBlock:(void(^)(float))withBlock{
    objc_setAssociatedObject(self, @selector(withBlock), withBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (self.openTap == NO) return;
    CGRect rect = [self trackRectForBounds:self.bounds];
    float value = [self minimumValue] + ([[touches anyObject] locationInView: self].x - rect.origin.x - 4.0) * (([self maximumValue] - [self minimumValue]) / (rect.size.width - 8.0));
    [self setValue:value];
    self.withBlock ? self.withBlock(value) : nil;
}

@end
