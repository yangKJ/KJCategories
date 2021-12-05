//
//  NSString+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/4.
//  https://github.com/YangKJ/KJCategories
//  字符串扩展属性

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJExtension)
/// 转换为URL
@property (nonatomic, strong, readonly) NSURL *URL;
/// 获取图片
@property (nonatomic, strong, readonly) UIImage *image;
/// 图片控制器
@property (nonatomic, strong, readonly) UIImageView *imageView;
/// 文本控件
@property (nonatomic, strong, readonly) UILabel *textLabel;
/// 取出HTML
@property (nonatomic, strong, readonly) NSString *HTMLString;
/// 生成竖直文字
@property (nonatomic, strong, readonly) NSString *verticalText;
/// 是否为JSONString
@property (nonatomic, assign, readonly) BOOL isJSONString;
/// Josn字符串转字典
@property (nonatomic, strong, readonly) NSDictionary *JSONDictionary;
/// 字典转Json字符串
extern NSString * kDictionaryToJson(NSDictionary * dict);
/// 数组转Json字符串
extern NSString * kArrayToJson(NSArray * array);

@end

NS_ASSUME_NONNULL_END
