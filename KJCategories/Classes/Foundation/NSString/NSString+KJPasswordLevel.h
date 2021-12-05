//
//  NSString+KJPasswordLevel.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/3.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  密码强度验证

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// 密码强度等级
typedef NS_ENUM(NSUInteger, KJPasswordLevel) {
    KJPasswordLevelEasy = 0,//简单
    KJPasswordLevelMidium,//中等
    KJPasswordLevelStrong,//强
    KJPasswordLevelVeryStrong,//非常强
    KJPasswordLevelExtremelyStrong,//超级强
};
@interface NSString (KJPasswordLevel)

/// 判断字符串中的每个字符是否相等
- (BOOL)kj_isCharEqual;

/// 密码强度等级
- (KJPasswordLevel)kj_passwordLevel;

#pragma mark - 汉字相关处理

/// 汉字转拼音
@property(nonatomic,strong,readonly)NSString *pinYin;
/// 随机汉字
extern NSString * kRandomChinese(NSInteger count);
/// 字母排序
extern NSArray * kDoraemonBoxAlphabetSort(NSArray<NSString *> * array);

/// 查找数据
/// @param array 数据源
/// @return 返回查到的数据下标，返回 `-1` 表示未查询到
- (NSInteger)kj_searchArray:(NSArray<NSString *> *)array;

@end

NS_ASSUME_NONNULL_END
