//
//  UIImage+KJMask.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  图片水印

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJImageWaterType) {
    KJImageWaterTypeTopLeft = 0, /// 左上
    KJImageWaterTypeTopRight,    /// 右上
    KJImageWaterTypeBottomLeft,  /// 左下
    KJImageWaterTypeBottomRight, /// 右下
    KJImageWaterTypeCenter,      /// 正中
};
@interface UIImage (KJMask)

/// 文字水印
/// @param text 文本内容
/// @param direction 水印位置
/// @param color 文本颜色
/// @param font 文本字体
/// @param margin 显示位置
/// @return 返回添加水印的图片
- (UIImage *)kj_waterText:(NSString *)text
                direction:(KJImageWaterType)direction
                textColor:(UIColor *)color
                     font:(UIFont *)font
                   margin:(CGPoint)margin;
/// 图片水印
/// @param image 水印图片
/// @param direction 水印位置
/// @param size 水印尺寸
/// @param margin 水印位置
/// @return 返回添加水印的图片
- (UIImage *)kj_waterImage:(UIImage *)image
                 direction:(KJImageWaterType)direction
                 waterSize:(CGSize)size
                    margin:(CGPoint)margin;
/// 图片添加水印
/// @param mark 水印图片
/// @param rect 水印位置
/// @return 返回添加水印的图片
- (UIImage *)kj_waterMark:(UIImage *)mark InRect:(CGRect)rect;

/// 蒙版图片处理
/// @param maskImage 蒙版图片
- (UIImage *)kj_maskImage:(UIImage *)maskImage;

@end

NS_ASSUME_NONNULL_END
