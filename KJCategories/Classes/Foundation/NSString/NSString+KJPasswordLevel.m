//
//  NSString+KJPasswordLevel.m
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/3.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "NSString+KJPasswordLevel.h"

@implementation NSString (KJPasswordLevel)

#pragma mark - 密码强度判断
/// 密码强度等级
- (KJPasswordLevel)kj_passwordLevel{
    NSInteger level = [self kj_checkPasswordStrength];
    switch (level) {
        case 0:
        case 1:
        case 2:
        case 3:
            return KJPasswordLevelEasy;
        case 4:
        case 5:
        case 6:
            return KJPasswordLevelMidium;
        case 7:
        case 8:
        case 9:
            return KJPasswordLevelStrong;
        case 10:
        case 11:
        case 12:
            return KJPasswordLevelVeryStrong;
        default:
            return KJPasswordLevelExtremelyStrong;
    }
}
/// 检查密码强度
- (NSInteger)kj_checkPasswordStrength{
    if ([self kj_isNull] || [self kj_isCharEqual]) {
        return 0;
    }
    // 数字类型
    static int NUM = 1;
    // 小写字母
    static int SMALL_LETTER = 2;
    // 大写字母
    static int CAPITAL_LETTER = 3;
    // 其他字符
    static int OTHER_CHAR = 4;
    //按不同类型计算密码
    NSInteger(^kLetter)(NSString *, NSInteger) = ^NSInteger(NSString *password, NSInteger type){
        //检查字符的类型，包括数字、大写字母、小写字母等字符
        NSInteger(^checkCharacterType)(NSString *) = ^NSInteger(NSString *character){
            int asciiCode = [character characterAtIndex:0];
            if (asciiCode >= 48 && asciiCode <= 57) {
                return NUM;
            }
            if (asciiCode >= 65 && asciiCode <= 90) {
                return CAPITAL_LETTER;
            }
            if (asciiCode >= 97 && asciiCode <= 122) {
                return SMALL_LETTER;
            }
            return OTHER_CHAR;
        };
        int count = 0;
        if (password != nil && password.length) {
            for (NSUInteger i = 0; i < password.length; i ++) {
                NSString *character = [password substringWithRange:NSMakeRange(i, 1)];
                if (checkCharacterType(character) == type) {
                    count ++;
                }
            }
        }
        return count;
    };
    NSInteger len = self.length;
    __block NSInteger level = 0;
    if (kLetter(self, NUM) > 0) {
        level++;
    }
    if (kLetter(self, SMALL_LETTER) > 0) {
        level++;
    }
    if (len > 4 && kLetter(self, CAPITAL_LETTER) > 0) {
        level++;
    }
    if (len > 6 && kLetter(self, OTHER_CHAR) > 0) {
        level++;
    }
    if ((len > 4 && kLetter(self, NUM) > 0 && kLetter(self, SMALL_LETTER) > 0) ||
        (kLetter(self, NUM) > 0 && kLetter(self, CAPITAL_LETTER) > 0) ||
        (kLetter(self, NUM) > 0 && kLetter(self, OTHER_CHAR) > 0) ||
        (kLetter(self, SMALL_LETTER) > 0 && kLetter(self, CAPITAL_LETTER) > 0) ||
        (kLetter(self, SMALL_LETTER) > 0 && kLetter(self, OTHER_CHAR) > 0) ||
        (kLetter(self, CAPITAL_LETTER) > 0 && kLetter(self, OTHER_CHAR) > 0)) {
        level++;
    }
    
    if ((len > 6 && kLetter(self, NUM) > 0 && kLetter(self, SMALL_LETTER) > 0 && kLetter(self, CAPITAL_LETTER) > 0) ||
        (kLetter(self, NUM) > 0 && kLetter(self, SMALL_LETTER) > 0 && kLetter(self, OTHER_CHAR) > 0) ||
        (kLetter(self, NUM) > 0 && kLetter(self, CAPITAL_LETTER) > 0 && kLetter(self, OTHER_CHAR) > 0) ||
        (kLetter(self, SMALL_LETTER) > 0 && kLetter(self, CAPITAL_LETTER) > 0 && kLetter(self, OTHER_CHAR) > 0)) {
        level++;
    }
    
    if (len > 8 &&
        kLetter(self, NUM) > 0 &&
        kLetter(self, SMALL_LETTER) > 0 &&
        kLetter(self, CAPITAL_LETTER) > 0 &&
        kLetter(self, OTHER_CHAR) > 0) {
        level++;
    }
    
    if ((len > 6 && kLetter(self, NUM) >= 3 && kLetter(self, SMALL_LETTER) >= 3) ||
        (kLetter(self, NUM) >= 3 && kLetter(self, CAPITAL_LETTER) >= 3) ||
        (kLetter(self, NUM) >= 3 && kLetter(self, OTHER_CHAR) >= 2) ||
        (kLetter(self, SMALL_LETTER) >= 3 && kLetter(self, CAPITAL_LETTER) >= 3) ||
        (kLetter(self, SMALL_LETTER) >= 3 && kLetter(self, OTHER_CHAR) >= 2) ||
        (kLetter(self, CAPITAL_LETTER) >= 3 && kLetter(self, OTHER_CHAR) >= 2)) {
        level++;
    }
    
    if ((len > 8 && kLetter(self, NUM) >= 2 && kLetter(self, SMALL_LETTER) >= 2 && kLetter(self, CAPITAL_LETTER) >= 2) ||
        (kLetter(self, NUM) >= 2 && kLetter(self, SMALL_LETTER) >= 2 && kLetter(self, OTHER_CHAR) >= 2) ||
        (kLetter(self, NUM) >= 2 && kLetter(self, CAPITAL_LETTER) >= 2 && kLetter(self, OTHER_CHAR) >= 2) ||
        (kLetter(self, SMALL_LETTER) >= 2 && kLetter(self, CAPITAL_LETTER) >= 2 && kLetter(self, OTHER_CHAR) >= 2)) {
        level++;
    }
    
    if (len > 10 &&
        kLetter(self, NUM) >= 2 &&
        kLetter(self, SMALL_LETTER) >= 2 &&
        kLetter(self, CAPITAL_LETTER) >= 2 &&
        kLetter(self, OTHER_CHAR) >= 2) {
        level++;
    }
    
    if (kLetter(self, OTHER_CHAR) >= 3) {
        level++;
    }
    if (kLetter(self, OTHER_CHAR) >= 6) {
        level++;
    }
    
    if (len > 12) {
        level++;
        if (len >= 16) level++;
    }
    
    // decrease points
    if ([@"abcdefghijklmnopqrstuvwxyz" containsString:self] ||
        [@"ABCDEFGHIJKLMNOPQRSTUVWXYZ" containsString:self]) {
        level--;
    }
    if ([@"qwertyuiop" containsString:self] ||
        [@"asdfghjkl" containsString:self] ||
        [@"zxcvbnm" containsString:self]) {
        level--;
    }
    if (([self kj_isNumeric] && [@"01234567890" containsString:self]) ||
        [@"09876543210" containsString:self]) {
        level--;
    }
    if (kLetter(self, NUM) == len ||
        kLetter(self, SMALL_LETTER) == len ||
        kLetter(self, CAPITAL_LETTER) == len) {
        level--;
    }
    
    if (len % 2 == 0) { // aaabbb
        NSString *part1 = [self substringWithRange:NSMakeRange(0, len / 2)];
        NSString *part2 = [self substringFromIndex:len / 2];
        if ([part1 isEqualToString:part2]) {
            level--;
        }
        if ([part1 kj_isCharEqual] && [part2 kj_isCharEqual]) {
            level--;
        }
    }
    if (len % 3 == 0) { // ababab
        NSString *part1 = [self substringWithRange:NSMakeRange(0, len / 3)];
        NSString *part2 = [self substringWithRange:NSMakeRange(len / 3, len / 3)];
        NSString *part3 = [self substringFromIndex:len / 3];
        if ([part1 isEqualToString:part2] && [part2 isEqualToString:part3]) {
            level--;
        }
    }
    if ([self kj_isNumeric] && len >= 6) { // 19881010 or 881010
        NSInteger year = 0;
        if (len == 8 || len == 6) {
            year = [self substringToIndex:self.length - 4].integerValue;
        }
        NSInteger size = len - 4;
        NSInteger month = [self substringWithRange:NSMakeRange(size, 2)].integerValue;
        NSInteger day = [self substringWithRange:NSMakeRange(size + 2, 2)].integerValue;
        if ((year >= 1950 && year < 2050) && (month >= 1 && month <= 12) && (day >= 1 && day <= 31)) {
            level--;
        }
    }
    // 常用简易密码字典
    NSArray<NSString *> *commonUsers = @[@"password", @"abc123", @"iloveyou", @"adobe123", @"123123",
                                         @"sunshine", @"1314520", @"a1b2c3", @"123qwe", @"aaa111", @"qweasd", @"admin", @"passwd"];
    [commonUsers enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:self] || [obj containsString:self]) {
            level --;
            *stop = YES;
        }
    }];
    if (len <= 6) {
        level--;
        if (len <= 4) {
            level--;
            if (len <= 3) {
                level = 0;
            }
        }
    }
    if (level < 0) {
        level = 0;
    }
    return level;
}

- (BOOL)kj_isCharEqual{
    if (self.length == 0) return YES;
    NSString *character = [self substringWithRange:NSMakeRange(0, 1)];
    NSString *string = [self stringByReplacingOccurrencesOfString:character withString:@""];
    return !string.length;
}

- (BOOL)kj_isNull{
    if (self == nil || self == NULL || self.length == 0 || [self isEqual:NSNull.null]) {
        return YES;
    }
    return NO;
}

- (BOOL)kj_isNumeric{
    if (self.length == 0) return NO;
    NSString * const numeric = @"^[0-9]*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", numeric];
    return [predicate evaluateWithObject:self];
}

#pragma mark - 汉字相关处理

/// 汉字转拼音
- (NSString *)pinYin{
    NSMutableString *string = [self mutableCopy];
    CFStringTransform((CFMutableStringRef)string, NULL, kCFStringTransformMandarinLatin, NO);//先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)string, NULL, kCFStringTransformStripDiacritics, NO);//再转换为不带声调的拼音
    return string;
}
/// 随机汉字
NSString * kRandomChinese(NSInteger count){
    NSMutableString *randomString = [NSMutableString stringWithString:@""];
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    for (NSInteger i = 0; i < count; i++) {
        NSInteger randomH = 0xA1 + arc4random() % (0xFE - 0xA1+1);
        NSInteger randomL = 0xB0 + arc4random() % (0xF7 - 0xB0+1);
        NSInteger number = (randomH<<8) + randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *string = [[NSString alloc]initWithData:data encoding:encoding];
        [randomString appendString:string];
    }
    return randomString.mutableCopy;
}
/// 查找数据
/// @param array 数据源
/// @return 返回查到的数据下标，返回`-1`表示未查询到
- (NSInteger)kj_searchArray:(NSArray<NSString *> *)array{
    unsigned index = (unsigned)CFArrayBSearchValues((CFArrayRef)array,
                                                    CFRangeMake(0, array.count),
                                                    (CFStringRef)self,
                                                    (CFComparatorFunction)CFStringCompare,
                                                    NULL);
    if (index < array.count && [self isEqualToString:array[index]]){
        return index;
    } else {
        return -1;
    }
}
/// 字母排序
NSArray<NSString*> * kDoraemonBoxAlphabetSort(NSArray<NSString*> * array){
    return [array sortedArrayUsingSelector:@selector(compare:)];
}

@end
