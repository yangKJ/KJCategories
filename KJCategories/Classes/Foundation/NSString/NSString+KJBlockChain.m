//
//  NSString+KJBlockChain.m
//  KJEmitterView
//
//  Created by 77。 on 2021/5/28.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "NSString+KJBlockChain.h"

@implementation NSString (KJBlockChain)

- (NSString *)kj_add0xPrefix {
    if ([self hasPrefix:@"0x"]) {
        return self;
    }
    return [@"0x" stringByAppendingString:self];
}

- (NSString *)kj_add0XPrefix {
    if ([self hasPrefix:@"0x"]) {
        return self;
    }
    return [@"0X" stringByAppendingString:self];
}

- (NSString *)kj_stripHexPrefix {
    if ([self hasPrefix:@"0x"] || [self hasPrefix:@"0X"]) {
        NSString *text = [self substringFromIndex:2];
        return text.kj_stripHexPrefix;
    }
    return self;
}

- (BOOL)kj_isBinary{
    NSString *regex = @"[0-1]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:self]) {
        return NO;
    }
    return YES;
}
- (BOOL)kj_isDecimal{
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:self]) {
        return NO;
    }
    return YES;
}
- (BOOL)kj_isHex{
    NSString *regex = @"[0-9A-Fa-f]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![pred evaluateWithObject:self]) {
        return NO;
    }
    return YES;
}

/// 十六进制转十进制
- (NSString *)kj_hexToDecimal{
    if (self.kj_stripHexPrefix.kj_isHex == NO) return self;
    unsigned long res = strtoul(self.kj_stripHexPrefix.UTF8String, 0, 16);
    return [NSString stringWithFormat:@"%ld", res];
}
/// 十进制转十六进制
- (NSString *)kj_decimalToHex{
    if (self.kj_isDecimal == NO) return self;
    NSInteger decimal = [self integerValue];
    NSString *hex = @"";
    NSString *letter;
    NSInteger number;
    for (int i = 0; i < 9; i++) {
        number = decimal % 16;
        decimal = decimal / 16;
        switch (number) {
            case 10: letter = @"A"; break;
            case 11: letter = @"B"; break;
            case 12: letter = @"C"; break;
            case 13: letter = @"D"; break;
            case 14: letter = @"E"; break;
            case 15: letter = @"F"; break;
            default: letter = [NSString stringWithFormat:@"%ld", (long)number];
        }
        hex = [letter stringByAppendingString:hex];
        if (decimal == 0) break;
    }
    return hex;
}

/// 十进制转二进制
- (NSString *)kj_decimalToBinary{
    if (self.kj_isDecimal == NO) return self;
    NSInteger decimal = [self integerValue];
    NSString *binary = @"";
    while (decimal) {
        binary = [[NSString stringWithFormat:@"%ld", (long)(decimal % 2)] stringByAppendingString:binary];
        if (decimal / 2 < 1) {
            break;
        }
        decimal = decimal / 2 ;
    }
    if (binary.length % 4 != 0) {
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    return binary;
}
/// 二进制转十进制
- (NSString *)kj_binaryToDecimal{
    if (self.kj_isBinary == NO) return self;
    NSInteger decimal = 0;
    for (int i = 0; i < self.length; i++) {
        NSString *number = [self substringWithRange:NSMakeRange(self.length - i - 1, 1)];
        if ([number isEqualToString:@"1"]) {
            decimal += pow(2, i);
        }
    }
    return [NSString stringWithFormat:@"%ld", (long)decimal];
}

/// 十六进制转二进制
- (NSString *)kj_hexToBinary{
    if (self.kj_stripHexPrefix.kj_isHex == NO) return self;
    NSMutableDictionary *hexDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [hexDic setObject:@"0000" forKey:@"0"];
    [hexDic setObject:@"0001" forKey:@"1"];
    [hexDic setObject:@"0010" forKey:@"2"];
    [hexDic setObject:@"0011" forKey:@"3"];
    [hexDic setObject:@"0100" forKey:@"4"];
    [hexDic setObject:@"0101" forKey:@"5"];
    [hexDic setObject:@"0110" forKey:@"6"];
    [hexDic setObject:@"0111" forKey:@"7"];
    [hexDic setObject:@"1000" forKey:@"8"];
    [hexDic setObject:@"1001" forKey:@"9"];
    [hexDic setObject:@"1010" forKey:@"A"];
    [hexDic setObject:@"1011" forKey:@"B"];
    [hexDic setObject:@"1100" forKey:@"C"];
    [hexDic setObject:@"1101" forKey:@"D"];
    [hexDic setObject:@"1110" forKey:@"E"];
    [hexDic setObject:@"1111" forKey:@"F"];
    NSString * binary = @"";
    NSString * hex = self.kj_stripHexPrefix;
    for (int i = 0; i < [hex length]; i++) {
        NSString *key = [hex substringWithRange:NSMakeRange(i, 1)];
        NSString *value = [hexDic objectForKey:key.uppercaseString];
        if (value) {
            binary = [binary stringByAppendingString:value];
        }
    }
    return binary;
}
/// 二进制转十六进制
- (NSString *)kj_binaryToHex{
    if (self.kj_isBinary == NO) return self;
    NSMutableDictionary *binaryDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [binaryDic setObject:@"0" forKey:@"0000"];
    [binaryDic setObject:@"1" forKey:@"0001"];
    [binaryDic setObject:@"2" forKey:@"0010"];
    [binaryDic setObject:@"3" forKey:@"0011"];
    [binaryDic setObject:@"4" forKey:@"0100"];
    [binaryDic setObject:@"5" forKey:@"0101"];
    [binaryDic setObject:@"6" forKey:@"0110"];
    [binaryDic setObject:@"7" forKey:@"0111"];
    [binaryDic setObject:@"8" forKey:@"1000"];
    [binaryDic setObject:@"9" forKey:@"1001"];
    [binaryDic setObject:@"A" forKey:@"1010"];
    [binaryDic setObject:@"B" forKey:@"1011"];
    [binaryDic setObject:@"C" forKey:@"1100"];
    [binaryDic setObject:@"D" forKey:@"1101"];
    [binaryDic setObject:@"E" forKey:@"1110"];
    [binaryDic setObject:@"F" forKey:@"1111"];
    NSString *binary = self;
    if (binary.length % 4 != 0) {
        NSMutableString *mStr = [[NSMutableString alloc]init];;
        for (int i = 0; i < 4 - binary.length % 4; i++) {
            [mStr appendString:@"0"];
        }
        binary = [mStr stringByAppendingString:binary];
    }
    NSString *hex = @"";
    for (int i = 0; i < binary.length; i += 4) {
        NSString *key = [binary substringWithRange:NSMakeRange(i, 4)];
        NSString *value = [binaryDic objectForKey:key];
        if (value) {
            hex = [hex stringByAppendingString:value];
        }
    }
    return hex;
}

/// 十六进制转`NSData`
- (NSData *)hexStringToHexData{
    if (self.kj_stripHexPrefix.kj_isHex == NO) return nil;
    NSString * hex = self.kj_stripHexPrefix;
    if (!hex || [hex length] <= 0) {
        return [NSData data];
    }
    NSMutableData *hexData = [NSMutableData data];
    NSRange range;
    if ([hex length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [hex length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [hex substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}

/// `NSData`转十六进制
NSString * kHexDataToHexString(NSData * data){
    if (!data || [data length] == 0) {
        return @"";
    }
    NSMutableString *hex = [[NSMutableString alloc] initWithCapacity:[data length]];
    [data enumerateByteRangesUsingBlock:^(const void *bytes, NSRange byteRange, BOOL *stop) {
        unsigned char *dataBytes = (unsigned char *)bytes;
        for (NSInteger i = 0; i < byteRange.length; i++) {
            NSString *hexStr = [NSString stringWithFormat:@"%x", (dataBytes[i]) & 0xff];
            if ([hexStr length] == 2) {
                [hex appendString:hexStr];
            } else {
                [hex appendFormat:@"0%@", hexStr];
            }
        }
    }];
    return hex.mutableCopy;
}

@end
