//
//  NSDictionary+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/6.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (KJExtension)
/// 是否为空
@property (nonatomic, assign, readonly) BOOL isEmpty;
/// 转换为Josn字符串
@property (nonatomic, strong, readonly) NSString * jsonString;
/// 是否包含某个key
- (BOOL)kj_containsKey:(NSString *)key;
/// 字典键名排序，升序排列
- (NSArray<NSString *> *)kj_keysSorted;
/// 字典键名排序，降序排列
- (NSArray<NSString *> *)kj_keySortDescending;
/// 快速遍历字典
/// @param apply 遍历事件，返回yes即需要该值
/// @return 返回满足条件键
- (NSArray<NSString *> *)kj_applyDictionaryValue:(BOOL(^)(id value, BOOL * stop))apply;
/// 映射字典
- (NSDictionary *)kj_mapDictionary:(BOOL(^)(NSString * key, id value))map;
/// 合并字典
- (NSDictionary *)kj_mergeDictionary:(NSDictionary *)dictionary;
/// 字典选择器
- (NSDictionary *)kj_pickForKeys:(NSArray<NSString *> *)keys;
/// 字典移除器
- (NSDictionary *)kj_omitForKeys:(NSArray<NSString *> *)keys;

@end

NS_ASSUME_NONNULL_END
