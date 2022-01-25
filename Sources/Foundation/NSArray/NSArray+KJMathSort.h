//
//  NSArray+KJMathSort.h
//  KJEmitterView
//
//  Created by 77。 on 2019/11/6.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (KJMathSort)

/// Binary search, this method is suitable when the amount of data is large
- (NSInteger)kj_binarySearchTarget:(NSInteger)target;
/// Bubble Sort
- (NSArray *)kj_bubbleSort;
/// Insertion sort
- (NSArray *)kj_insertSort;
/// select sort
- (NSArray *)kj_selectionSort;

/// Generate a set of non-repeated random numbers
/// @param min minimum
/// @param max maximum
/// @param count Number of data
/// @return returns an array of random numbers
- (NSArray *)kj_noRepeatRandomArrayWithMinNum:(NSInteger)min maxNum:(NSInteger)max
                                        count:(NSInteger)count;

@end

NS_ASSUME_NONNULL_END
