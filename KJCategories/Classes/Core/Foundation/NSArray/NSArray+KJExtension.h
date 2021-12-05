//
//  NSArray+KJExtension.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/6.
//  https://github.com/YangKJ/KJCategories
//  数组高级用法

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (KJExtension)
/// 是否为空
@property (nonatomic, assign, readonly) BOOL isEmpty;
/// 移动对象元素位置
/// @param index 移动下标
/// @param toIndex 移动位置
- (NSArray *)kj_moveIndex:(NSInteger)index toIndex:(NSInteger)toIndex;
/// 移动元素
/// @param object 移动元素，需要唯一否则会出问题
/// @param toIndex 移动位置
- (NSArray *)kj_moveObject:(id)object toIndex:(NSInteger)toIndex;
/// 交换位置
/// @param index 交换元素
/// @param toIndex 交换位置
- (NSArray *)kj_exchangeIndex:(NSInteger)index toIndex:(NSInteger)toIndex;
/// 倒序排列
- (NSArray *)kj_reverseArray;
/// 筛选数据
- (id)kj_detectArray:(BOOL(^)(id object, int index))block;
/// 多维数组筛选数据
- (id)kj_detectManyDimensionArray:(BOOL(^)(id object, BOOL * stop))recurse;
/// 归纳对比选择
/// @param object 需要对比的数据
/// @param comparison 对比回调
/// @return 返回经过对比之后的数据
- (id)kj_reduceObject:(id)object comparison:(id(^)(id obj1, id obj2))comparison;
/// 查找数据，返回-1表示未查询到
- (NSInteger)kj_searchObject:(id)object;
/// 映射，取出某种数据
- (NSArray *)kj_mapArray:(id(^)(id object))map;
/// 映射，是否倒序
/// @param map 映射回调
/// @param reverse 是否倒序
- (NSArray *)kj_mapArray:(id(^)(id object))map reverse:(BOOL)reverse;
/// 映射和过滤数据
/// @param map 映射和过滤事件，返回映射数据，返回nil代表过滤该数据
/// @param repetition 是否需要去重
- (NSArray *)kj_mapArray:(id _Nullable(^)(id object))map repetition:(BOOL)repetition;
/// 包含数据
- (BOOL)kj_containsObject:(BOOL(^)(id object, NSUInteger index))contains;
/// 是否包含数据
/// @param index 指定位置，返回该数据对应位置
/// @param contains 回调事件，返回yes代表包含该数据
/// @return 返回是否包含该数据
- (BOOL)kj_containsFromIndex:(inout NSInteger * _Nonnull)index contains:(BOOL(^)(id object))contains;
/// 替换数组指定元素，
/// @param object 替换元素
/// @param operation 回调事件，返回yes代表替换该数据，stop控制是否替换全部
/// @return 返回替换之后的数组
- (NSArray *)kj_replaceObject:(id)object operation:(BOOL(^)(id object, NSUInteger index, BOOL * stop))operation;
/// 插入数据到目的位置
/// @param object 需要插入的元素
/// @param aim 回调事件，返回yes代表插入该数据
/// @return 返回插入之后的数组
- (NSArray *)kj_insertObject:(id)object aim:(BOOL(^)(id object, int index))aim;
/// 判断两个数组包含元素是否一致
- (BOOL)kj_isEqualOtherArray:(NSArray *)otherArray;
/// 随机打乱数组
- (NSArray *)kj_disorganizeArray;
/// 删除数组当中的相同元素，类似NSSet功能
- (NSArray *)kj_deleteArrayEquelObject;
/// 随机数组当中一条数据
- (nullable id)kj_randomObject;
/// 数组剔除器
/// @param array 需要剔除的数据
- (NSArray *)kj_pickArray:(NSArray *)array;

@end

NS_ASSUME_NONNULL_END
