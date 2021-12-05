//
//  UIImageView+KJDoraemonBox.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/17.
//  https://github.com/yangKJ/KJEmitterView
//  文字头像，首字母缩略头像

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, KJImageBlurType) {
    KJImageBlurTypeGaussian,// 高斯模糊，radius：0 - 100
    KJImageBlurTypevImage,// Accelerate模糊，radius：0 - 1
    KJImageBlurTypeBlurEffect,// 毛玻璃，radius：ExtraLight<10，Light<20，Dark>20
    KJImageBlurTypeMask, // 蒙版
};
@class UIImageViewLettersInfo;
@interface UIImageView (KJDoraemonBox)
/// 显示文字图片
/// @param text 文本
/// @param block 设置缩略头像配置参数
- (void)kj_imageViewWithText:(NSString *)text LettersInfo:(void(^)(UIImageViewLettersInfo *info))block;

/// 浏览头像，点击全屏展示
- (void)kj_headerImageShowScreen;
/// 浏览头像，背景颜色
- (void)kj_headerImageShowScreenWithBackground:(UIColor *)color;

/// 模糊处理
/// @param type 模糊类型
/// @param image 模糊图片
/// @param radius 模糊半径
- (void)kj_blurImageViewWithBlurType:(KJImageBlurType)type
                               image:(UIImage *)image
                              radius:(CGFloat)radius;

@end

/// 缩略头像配置参数
@interface UIImageViewLettersInfo : NSObject
/// 图片颜色，默认随机色
@property(nonatomic,strong)UIColor *color;
/// 是否切圆，默认yes
@property(nonatomic,assign)BOOL circle;
/// 是否取第一个，默认yes
@property(nonatomic,assign)BOOL frist;
/// 是否将汉字转拼音，默认NO
@property(nonatomic,assign)BOOL pinyin;
/// 是否将拼音转为大写，默认yes
@property(nonatomic,assign)BOOL uppercase;
/// 以该符号分割显示第一个，默认空格
@property(nonatomic,strong)NSString *partition;
/// 是否分割，默认NO
@property(nonatomic,assign)BOOL isPartition;
/// 文字信息
@property(nonatomic,strong)NSDictionary *attributes;

@end

NS_ASSUME_NONNULL_END
