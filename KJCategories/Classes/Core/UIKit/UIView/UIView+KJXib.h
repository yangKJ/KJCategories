//
//  UIView+KJXib.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KJXib)

//*********  Xib中显示属性 IBInspectable就可以可视化显示相关的属性  ***********
/// 图片属性，备注这个会覆盖掉UIImageView上面设置的image
@property(nonatomic,strong)IBInspectable UIImage *viewImage;
/// 圆角边框
@property(nonatomic,strong)IBInspectable UIColor *borderColor;
@property(nonatomic,assign)IBInspectable CGFloat borderWidth;
@property(nonatomic,assign)IBInspectable CGFloat cornerRadius;
/// 阴影，备注View默认颜色ClearColor时阴影不会生效
@property(nonatomic,strong) UIColor *shadowColor;//设置阴影颜色
@property(nonatomic,assign) CGFloat shadowRadius;//设置阴影的圆角
@property(nonatomic,assign) CGFloat shadowWidth;//设置阴影的宽度
@property(nonatomic,assign) CGFloat shadowOpacity;//设置阴影透明度
@property(nonatomic,assign) CGSize  shadowOffset;//设置阴影偏移量
/// 贝塞尔圆角，更快捷高效的圆角方式
@property(nonatomic,assign) CGFloat bezierRadius;

/// 设置贝塞尔颜色边框，更高效
/// @param radius 半径
/// @param borderWidth 边框尺寸
/// @param borderColor 边框颜色
- (void)bezierBorderWithRadius:(CGFloat)radius
                   borderWidth:(CGFloat)borderWidth
                   borderColor:(UIColor *)borderColor;

/// 设置阴影
/// @param color 阴影颜色
/// @param offset 阴影位移
/// @param radius 阴影半径
- (void)shadowColor:(UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius;

/// 设置指定角落圆角
/// @param rectCorner 指定角落
/// @param cornerRadius 圆角半径
- (void)cornerWithRectCorner:(UIRectCorner)rectCorner cornerRadius:(CGFloat)cornerRadius;

@end

NS_ASSUME_NONNULL_END
