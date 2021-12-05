//
//  NSString+KJRegex.h
//  KJEmitterView
//
//  Created by 77。 on 2021/8/18.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  正则匹配测试网址：https://c.runoob.com/front-end/854

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJRegex)

/// 是否包含该数据
/// @param regex 匹配元素
- (BOOL)kj_matchWithRegex:(NSString *)regex;

/// 正则匹配
/// @param regex 匹配元素
- (NSString *)kj_partStringWithRegex:(NSString *)regex;

/// 正则匹配多条数据
/// @param regex 匹配元素
- (NSArray<NSString *> *)kj_checkStringArrayWithRegex:(NSString *)regex;

@end

NS_ASSUME_NONNULL_END
