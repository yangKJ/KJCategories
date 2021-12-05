//
//  NSArray+KJMathSort.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/6.
//  https://github.com/YangKJ/KJCategories
//  排序算法

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (KJMathSort)

/// 二分查找，当数据量很大适宜采用该方法
- (NSInteger)kj_binarySearchTarget:(NSInteger)target;
/// 冒泡排序
- (NSArray *)kj_bubbleSort;
/// 插入排序
- (NSArray *)kj_insertSort;
/// 选择排序
- (NSArray *)kj_selectionSort;

/// 生成一组不重复的随机数
/// @param min 最小值
/// @param max 最大值
/// @param count 数据个数
/// @return 返回随机数数组
- (NSArray *)kj_noRepeatRandomArrayWithMinNum:(NSInteger)min maxNum:(NSInteger)max
                                        count:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
