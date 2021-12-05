//
//  UIColor+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/31.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  颜色相关扩展

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define UIColorFromHEXA(hex,a)    [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f \
green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]
#define UIColorFromRGBA(r,g,b,a)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define UIColorHexFromRGB(hex)    UIColorFromHEXA(hex,1.0)
#define kRGBA(r,g,b,a)            [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kRGB(r,g,b)               kRGBA(r,g,b,1.0f)

@interface UIColor (KJExtension)
@property (nonatomic, assign, readonly) CGFloat red;
@property (nonatomic, assign, readonly) CGFloat green;
@property (nonatomic, assign, readonly) CGFloat blue;
@property (nonatomic, assign, readonly) CGFloat alpha;
@property (nonatomic, assign, readonly) CGFloat hue;/// 色相 -π ~ π
@property (nonatomic, assign, readonly) CGFloat saturation;/// 饱和度 0 ~ 1
@property (nonatomic, assign, readonly) CGFloat light;/// 亮度 0 ~ 1
/// 获取颜色对应的RGBA
- (void)kj_rgba:(CGFloat *)r :(CGFloat *)g :(CGFloat *)b :(CGFloat *)a;

/// 获取颜色对应的色相饱和度和透明度
- (void)kj_HSL:(CGFloat *)hue :(CGFloat *)saturation :(CGFloat *)light;

/// UIColor转16进制字符串
- (NSString *)kj_hexString;
/// UIColor转16进制字符串
+ (NSString *)hexStringFromColor:(UIColor *)color;
FOUNDATION_EXPORT NSString * kDoraemonBoxHexStringFromColor(UIColor *color);

/// 16进制字符串转UIColor
/// @param hexString 十六进制，`0x` 或 `#` 开头也均支持
+ (UIColor *)colorWithHexString:(NSString *)hexString;
FOUNDATION_EXPORT UIColor * kDoraemonBoxColorHexString(NSString *hexString);

/// 16进制字符串转UIColor
/// @param hexString 十六进制，`0x` 或 `#` 开头也均支持
/// @param alpha 透明度
+ (UIColor *)colorWithHexString:(NSString *)hexString alpha:(float)alpha;

/// 随机颜色
FOUNDATION_EXPORT UIColor * kDoraemonBoxRandomColor(void);

@end

NS_ASSUME_NONNULL_END
