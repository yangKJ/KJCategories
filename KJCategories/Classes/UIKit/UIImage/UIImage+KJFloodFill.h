//
//  UIImage+FloodFill.h
//  KJEmitterView
//
//  Created by 杨科军 on 2018/12/1.
//  Copyright © 2018 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  基于扫描线的泛洪算法，获取填充同颜色区域后的图片
/* 泛洪算法通常有3种实现,四邻域，八邻域和基于扫描线
 * 了解更多泛洪算法可以查看下列链接：https://lodev.org/cgtutor/floodfill.html
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef struct KJPointNode{
    NSInteger value;
    NSInteger nextNodeOffset;
}KJPointNode;
/* 栈操作工具 */
@interface KJNodeQueue : NSObject<NSCopying>
- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;
/// 初始化
- (instancetype)initWithCapacity:(NSInteger)capacity
                      Increments:(NSInteger)increments
                      Multiplier:(NSInteger)multiplier;
/// 节点入栈
- (void)kj_pushNodeWithX:(NSInteger)x PushY:(NSInteger)y;
/// 节点出栈，返回是否出完
- (bool)kj_popNodeWithX:(NSInteger*)x PopY:(NSInteger*)y;

@end
@interface UIImage (KJFloodFill)

/// 基于扫描线的泛洪算法，获取填充同颜色区域后的图片
/// @param startPoint 开始坐标点
/// @param newColor 填充图片颜色
/// @param tolerance 判断相邻颜色相同的容差值
/// @param antialias 是否抗锯齿化
/// @return 返回填充后的图片
- (UIImage *)kj_FloodFillImageFromStartPoint:(CGPoint)startPoint
                                    NewColor:(UIColor *)newColor
                                   Tolerance:(CGFloat)tolerance
                                UseAntialias:(BOOL)antialias;

@end

NS_ASSUME_NONNULL_END
