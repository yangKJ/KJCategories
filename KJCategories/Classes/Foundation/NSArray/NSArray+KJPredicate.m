//
//  NSArray+KJPredicate.m
//  KJEmitterView
//
//  Created by 77。 on 2019/11/6.
//  https://github.com/YangKJ/KJCategories

#import "NSArray+KJPredicate.h"

@implementation NSArray (KJPredicate)

/// 数组计算交集
- (NSArray *)kj_intersectionWithOtherArray:(NSArray *)otherArray{
    @autoreleasepool {
        if (self.count == 0 || otherArray.count == 0) return nil;
        NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF IN %@",self];
        NSArray * array = [otherArray filteredArrayUsingPredicate:predicate];
        return array;
    }
}
/// 数组计算差集
- (NSArray *)kj_subtractionWithOtherArray:(NSArray *)otherArray{
    @autoreleasepool {
        if (self == nil) return otherArray;
        if (otherArray == nil) return self;
        NSPredicate * predicate1 = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",self];
        NSArray * filter1 = [otherArray filteredArrayUsingPredicate:predicate1];
        NSPredicate * predicate2 = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",otherArray];
        NSArray * filter2 = [self filteredArrayUsingPredicate:predicate2];
        NSMutableArray * array = [NSMutableArray arrayWithArray:filter1];
        [array addObjectsFromArray:filter2];
        return array.mutableCopy;
    }
}
/// 删除数组相同部分然后追加不同部分
- (NSArray *)kj_deleteEqualObjectAndMergeWithOtherArray:(NSArray *)otherArray{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)",self];
    NSArray *filteredTemps = [otherArray filteredArrayUsingPredicate:predicate];
    NSMutableArray *newTemps = [NSMutableArray arrayWithArray:self];
    [newTemps addObjectsFromArray:filteredTemps];
    return newTemps;
}
/// 过滤数组，排除不需要部分
- (NSArray *)kj_filterArrayExclude:(BOOL(^)(id object))block{
    NSIndexSet *indexes = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return !block(obj);
    }];
    return [self objectsAtIndexes:indexes];
}
/// 过滤数组，获取需要部分
- (NSArray *)kj_filterArrayNeed:(BOOL(^)(id object))block{
    NSIndexSet *indexes = [self indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        return block(obj);
    }];
    return [self objectsAtIndexes:indexes];
}
//MARK: - NSPredicate 除去数组temps中包含的数组targetTemps元素
- (NSArray *)kj_deleteTargetArray:(NSArray *)temp{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"NOT (SELF IN %@)", temp];
    return [self filteredArrayUsingPredicate:predicate].mutableCopy;
}
//MARK: - 利用 NSSortDescriptor 对对象数组，按照某一属性的升序降序排列
- (NSArray *)kj_sortDescriptorWithKey:(NSString *)key Ascending:(BOOL)ascending{
    NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:key ascending:ascending];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    [array sortUsingDescriptors:@[des]];
    return array.mutableCopy;
}
//MARK: - 利用 NSSortDescriptor 对对象数组，按照某些属性的升序降序排列
- (NSArray *)kj_sortDescriptorWithKeys:(NSArray *)keys Ascendings:(NSArray *)ascendings{
    NSMutableArray *desTemp = [NSMutableArray array];
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        BOOL boo = [ascendings[i] integerValue] ? YES : NO;
        NSSortDescriptor *des = [NSSortDescriptor sortDescriptorWithKey:key ascending:boo];
        [desTemp addObject:des];
    }
    NSMutableArray *array = self.mutableCopy;
    [array sortUsingDescriptors:desTemp];
    desTemp = nil;
    return array.mutableCopy;
}
//MARK: - 利用 NSSortDescriptor 对对象数组，取出 key 中匹配 value 的元素
- (NSArray *)kj_takeOutDatasWithKey:(NSString *)key Value:(NSString *)value{
    NSString *string = [NSString stringWithFormat:@"%@ LIKE '%@'",key,value];
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:string]];
}
//MARK: - 字符串比较运算符 beginswith(以*开头)、endswith(以*结尾)、contains(包含)、like(匹配)、matches(正则)
//  beginswith(以*开头)、endswith(以*结尾)、contains(包含)、like(匹配)、matches(正则)，[c]不区分大小写 [d]不区分发音符号即没有重音符号 [cd] 既又
- (NSArray *)kj_takeOutDatasWithOperator:(NSString *)ope Key:(NSString *)key Value:(NSString *)value{
    NSString *string = [NSString stringWithFormat:@"%@ %@ '%@'",key,ope,value];
    return [self filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:string]];
}

//MARK: - ------------------------ Predicate谓词的简单使用 ------------------------
/*
 // self 表示数组元素/字符串本身
 // 比较运算符 =/==(等于)、>=/=>(大于等于)、<=/=<(小于等于)、>(大于)、<(小于)、!=/<>(不等于)
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"self = %@",[people_arr lastObject]];//比较数组元素相等
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"address = %@",[(People *)[people_arr lastObject] address]];//比较数组元素中某属性相等
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"age in {18,21}"];//比较数组元素中某属性值在这些值中
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"age between {18,21}"];//比较数组元素中某属性值大于等于左边的值，小于等于右边的值
 
 // 逻辑运算符 and/&&(与)、or/||(或)、not/!(非)
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"address = %@ && age between {19,22}", [(People *)[people_arr lastObject] address]];
 
 // 字符串比较运算符 beginswith(以*开头)、endswith(以*结尾)、contains(包含)、like(匹配)、matches(正则)
 // [c]不区分大小写 [d]不区分发音符号即没有重音符号 [cd]既 又
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name beginswith[cd] 'ja'"];
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"name matches '^[a-zA-Z]{4}$'"];
 
 //集合运算符 some/any:集合中任意一个元素满足条件、all:集合中所有元素都满足条件、none:集合中没有元素满足条件、in:集合中元素在另一个集合中
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"all employees.employeeId in {7,8,9}"];
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"self in %@",filter_arr];
 // $K：用于动态传入属性名、%@：用于动态设置属性值(字符串、数字、日期对象)、$(value)：可以动态改变
 //NSPredicate *pre = [NSPredicate predicateWithFormat:@"%K > $age",@"age"];
 //pre = [pre predicateWithSubstitutionVariables:@{@"age":@21}];
 // NSCompoundPredicate 相当于多个NSPredicate的组合
 //NSCompoundPredicate *compPre = [NSCompoundPredicate andPredicateWithSubpredicates:@[[NSPredicate predicateWithFormat:@"age > 19"],[NSPredicate predicateWithFormat:@"age < 21"]]];
 // 暂时没找到用法
 //NSComparisonPredicate *compPre = [NSComparisonPredicate predicateWithLeftExpression:[NSExpression expressionForKeyPath:@"name"] rightExpression:[NSExpression expressionForVariable:@"ja"] modifier:NSAnyPredicateModifier type:NSBeginsWithPredicateOperatorType options:NSNormalizedPredicateOption];
 //[people_arr filterUsingPredicate:compPre];

 */

@end
