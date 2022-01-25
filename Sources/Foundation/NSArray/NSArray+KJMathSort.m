//
//  NSArray+KJMathSort.m
//  KJEmitterView
//
//  Created by 77。 on 2019/11/6.
//  https://github.com/YangKJ/KJCategories

#import "NSArray+KJMathSort.h"

@implementation NSArray (KJMathSort)

//MARK: - ---  二分查找
/* 当数据量很大适宜采用该方法 采用二分法查找时，数据需是排好序的
 基本思想：假设数据是按升序排序的，对于给定值x，从序列的中间位置开始比较，如果当前位置值等于x，则查找成功
 若x小于当前位置值，则在数列的前半段 中查找；若x大于当前位置值则在数列的后半段中继续查找，直到找到为止
 */
- (NSInteger)kj_binarySearchTarget:(NSInteger)target{
    if (self == nil) return -1;
    NSInteger start = 0;
    NSInteger end = self.count - 1;
    NSInteger mind = 0;
    while (start < end - 1){
        mind = start + (end - start)/2;
        if ([self[mind] integerValue] > target){
            end = mind;
        } else {
            start = mind;
        }
    }
    if ([self[start] integerValue] == target){
        return start;
    }
    if ([self[end] integerValue] == target){
        return end;
    }
    return -1;
}
//MARK: - --- 冒泡排序
/*
 1. 首先将所有待排序的数字放入工作列表中
 2. 从列表的第一个数字到倒数第二个数字，逐个检查：若某一位上的数字大于他的下一位，则将它与它的下一位交换
 3. 重复2号步骤(倒数的数字加1。例如：第一次到倒数第二个数字，第二次到倒数第三个数字，依此类推...)，直至再也不能交换
 */
- (NSArray *)kj_bubbleSort{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    NSInteger count = [array count];
    for (int i = 0; i < count - 1; ++i){
        for (int j = 0; j < count - i - 1; ++j){
            if (array[j] > array[j+1]){
                id temp = array[j];
                array[j] = array[j+1];
                array[j+1] = temp;
            }
        }
    }
    return array.mutableCopy;
}

//MARK: - --- 插入排序
/*
 1. 从第一个元素开始，认为该元素已经是排好序的
 2. 取下一个元素，在已经排好序的元素序列中从后向前扫描
 3. 如果已经排好序的序列中元素大于新元素，则将该元素往右移动一个位置
 4. 重复步骤3，直到已排好序的元素小于或等于新元素
 5. 在当前位置插入新元素
 6. 重复步骤2
 */
- (NSArray *)kj_insertSort{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    int j;
    for (int i = 1; i < [array count]; ++i){
        id temp = array[i];
        for (j = i; j > 0 && temp < array[j-1]; --j){
            array[j] = array[j-1];
        }
        array[j] = temp;
    }
    return array.mutableCopy;
}

//MARK: - ---  选择排序
/*
 1. 设数组内存放了n个待排数字，数组下标从1开始，到n结束
 2. i=1
 3. 从数组的第i个元素开始到第n个元素，逐一比较寻找最小的元素
 4. 将上一步找到的最小元素和第i位元素交换
 5. 如果i=n－1算法结束，否则回到第3步
 */
- (NSArray *)kj_selectionSort{
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    NSInteger count = [array count];
    for (int i = 0; i < count; ++i){
        int min = i;
        for (int j = i+1; j < count; ++j){
            if (array[min] > array[j]) min = j;
        }
        if (min != i){
            id temp = array[min];
            array[min] = array[i];
            array[i] = temp;
        }
    }
    return array.mutableCopy;
}

/// 生成一组不重复的随机数
- (NSArray *)kj_noRepeatRandomArrayWithMinNum:(NSInteger)min maxNum:(NSInteger)max count:(NSInteger)count{
    NSMutableSet *set = [NSMutableSet setWithCapacity:count];
    while (set.count < count) {
        NSInteger value = arc4random() % (max-min+1) + min;
        [set addObject:[NSNumber numberWithInteger:value]];
    }
    return set.allObjects;
}

@end
