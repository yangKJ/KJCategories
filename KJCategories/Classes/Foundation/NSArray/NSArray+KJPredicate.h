//
//  NSArray+KJPredicate.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/6.
//  https://github.com/YangKJ/KJCategories
//  谓词相关

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (KJPredicate)

/// 数组计算交集
- (NSArray *)kj_intersectionWithOtherArray:(NSArray *)otherArray;
/// 数组计算差集
- (NSArray *)kj_subtractionWithOtherArray:(NSArray *)otherArray;
/// 删除数组相同部分然后追加不同部分
- (NSArray *)kj_deleteEqualObjectAndMergeWithOtherArray:(NSArray *)otherArray;
/// 过滤数组，排除不需要部分
- (NSArray *)kj_filterArrayExclude:(BOOL(^)(id object))block;
/// 过滤数组，获取需要部分
- (NSArray *)kj_filterArrayNeed:(BOOL(^)(id object))block;
/// 除去目标元素
- (NSArray *)kj_deleteTargetArray:(NSArray *)temp;
/// 按照某一属性的升序降序排列
/// @param key 目标属性
/// @param ascending 是否升序排列
- (NSArray *)kj_sortDescriptorWithKey:(NSString *)key Ascending:(BOOL)ascending;
/// 按照某些属性的升序降序排列
- (NSArray *)kj_sortDescriptorWithKeys:(NSArray *)keys Ascendings:(NSArray *)ascendings;
/// 匹配元素
/// @param key 匹配条件，支持sql语法
/// @param value 匹配值
- (NSArray *)kj_takeOutDatasWithKey:(NSString *)key Value:(NSString *)value;
/// 字符串比较运算符
- (NSArray *)kj_takeOutDatasWithOperator:(NSString *)ope Key:(NSString *)key Value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
