//
//  NSString+KJMath.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  数学运算符

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJMath)
/// 是否为空
@property (nonatomic, assign, readonly) BOOL isEmpty;
/// 非空安全处理
@property (nonatomic, assign, readonly) NSString *safeString;

/// 比较大小
- (NSComparisonResult)kj_compare:(NSString *)string;
/// 加法运算
- (NSString *)kj_adding:(NSString *)string;
/// 减法运算
- (NSString *)kj_subtract:(NSString *)string;
/// 乘法运算量
- (NSString *)kj_multiply:(NSString *)string;
/// 除法运算
- (NSString *)kj_divide:(NSString *)string;
/// 指数运算
- (NSString *)kj_multiplyingByPowerOf10:(NSInteger)oxff;
/// 次方运算
- (NSString *)kj_raisingToPower:(NSInteger)oxff;

/// 转成小数
- (double)kj_calculateDoubleValue;

/// 保留整数部分，100.0130 => 100
- (NSString *)kj_retainInteger;

/// 去掉尾巴是 `0` 或者 `.` 的位数，
/// 10.000 => 10 或者 10.100 => 10.1
- (NSString *)kj_removeTailZero;

/// 保留几位小数，四舍五入保留两位则如下
/// 10.00001245 => 10.00  或者 120.026 => 120.03
extern NSString * kStringFractionDigits(NSDecimalNumber * number, NSUInteger digits);
+ (NSString *)kj_fractionDigits:(double)value digits:(NSUInteger)digits;

/// 保留小数，直接去掉小数多余部分
+ (NSString *)kj_retainDigits:(double)value digits:(int)digits;

/// 保留几位有效小数位数，保留两位则如下
/// 10.00001245 => 10.000012  或者 120.02 => 120.02 或者 10.000 => 10
extern NSString * kStringReservedValidDigit(NSDecimalNumber * value, NSInteger digit);
+ (NSString *)kj_reservedValidDigit:(double)value digit:(int)digit;

/// Double精度丢失修复
- (NSString *)kj_doublePrecisionRevise;
+ (NSString *)kj_doublePrecisionReviseWithDouble:(double)conversionValue;

@property (nonatomic, assign, readonly) BOOL isNumber;/// 是否为数字
@property (nonatomic, assign, readonly) BOOL isInt;/// 是否是整形
@property (nonatomic, assign, readonly) BOOL isFloat;/// 是否是浮点型

/// 大单位转小单位
/// [@"1.1" kj_parseToUInt64WithDecimals: 5] => @"110000"
- (NSString *)kj_parseToIntStringWithDecimals:(int)decimals;

/// 小数后面补齐`0`
/// [@"1.2" kj_decimalAddZeroToLength:5] => @"1.20000"
- (NSString *)kj_decimalAddZeroToLength:(int)length;

/// 小单位转大单位
/// [@"200" kj_formatToDecimalWithDecimals:5] => @"0.002"
/// [@"1.2" kj_decimalAddZeroToLength:5] => @"0.000012"
- (NSString *)kj_formatToDecimalWithDecimals:(int)decimals;

@end

NS_ASSUME_NONNULL_END
