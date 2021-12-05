//
//  NSString+KJExtension.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/4.
//  https://github.com/YangKJ/KJCategories

#import "NSString+KJExtension.h"

@implementation NSString (KJExtension)

/// 转换为URL
- (NSURL *)URL{ return [NSURL URLWithString:self];}
/// 获取图片
- (UIImage *)image{ return [UIImage imageNamed:self];}
/// 图片控制器
- (UIImageView *)imageView{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:self]];
}
/// 文本控件
- (UILabel *)textLabel{
    UILabel * label = [[UILabel alloc] init];
    label.text = self;
    return label;
}
/// 取出HTML
- (NSString *)HTMLString{
    if (self == nil) return nil;
    NSString * html = self;
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while ([scanner isAtEnd] == NO) {
        [scanner scanUpToString:@"<" intoString:nil];
        [scanner scanUpToString:@">" intoString:&text];
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text]
                                               withString:@""];
    }
    return html;
}
/// 生成竖直文字
- (NSString *)verticalText{
    NSMutableString * text = [[NSMutableString alloc] initWithString:self];
    NSInteger count = text.length;
    for (int i = 1; i < count; i ++) {
        [text insertString:@"\n" atIndex:i * 2 - 1];
    }
    return text.mutableCopy;
}

#pragma mark - Json相关
/// 是否为JSONString
- (BOOL)isJSONString{
    if (self.length < 2) return NO;
    if (!([self hasPrefix:@"{"] || [self hasPrefix:@"["])) return NO;
    // {:123  }:125  [: 91  ]:93
    return [self characterAtIndex:self.length-1] - [self characterAtIndex:0] == 2;
}
/// Josn字符串转字典
- (NSDictionary *)JSONDictionary{
    if (self == nil || self.isJSONString == NO) return nil;
    NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if(error) return nil;
    return dic;
}
/// 字典转Json字符串
NSString * kDictionaryToJson(NSDictionary *dict){
    NSString *jsonString = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    if (jsonData) jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}
/// 数组转Json字符串
NSString * kArrayToJson(NSArray *array){
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return jsonTemp;
}

@end
