//
//  NSArray+KJPredicate.h
//  KJEmitterView
//
//  Created by 77。 on 2019/11/6.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (KJPredicate)

/// Array calculation intersection
- (NSArray *)kj_intersectionWithOtherArray:(NSArray *)otherArray;

/// Array calculation difference
- (NSArray *)kj_subtractionWithOtherArray:(NSArray *)otherArray;

/// Delete the same part of the array and append different parts
- (NSArray *)kj_deleteEqualObjectAndMergeWithOtherArray:(NSArray *)otherArray;

/// Filter the array, exclude unnecessary parts
- (NSArray *)kj_filterArrayExclude:(BOOL(^)(id object))block;

/// Filter the array, get the required part
- (NSArray *)kj_filterArrayNeed:(BOOL(^)(id object))block;

/// Remove the target element
- (NSArray *)kj_deleteTargetArray:(NSArray *)temp;

/// Sort in ascending and descending order of a certain attribute
/// @param key target attribute
/// @param ascending Whether to sort in ascending order
- (NSArray *)kj_sortDescriptorWithKey:(NSString *)key Ascending:(BOOL)ascending;

/// Sort in ascending and descending order of certain attributes
- (NSArray *)kj_sortDescriptorWithKeys:(NSArray *)keys Ascendings:(NSArray *)ascendings;

/// Matching element
/// @param key match condition, support sql syntax
/// @param value matching value
- (NSArray *)kj_takeOutDatasWithKey:(NSString *)key Value:(NSString *)value;

/// String comparison operator
- (NSArray *)kj_takeOutDatasWithOperator:(NSString *)ope Key:(NSString *)key Value:(NSString *)value;

@end

NS_ASSUME_NONNULL_END
