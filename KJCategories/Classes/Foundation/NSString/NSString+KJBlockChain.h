//
//  NSString+KJBlockChain.h
//  KJEmitterView
//
//  Created by 77。 on 2021/5/28.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  区块链使用

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJBlockChain)

/// 添加 `0x` 前缀
- (NSString *)kj_add0xPrefix;
/// 添加 `0X` 前缀
- (NSString *)kj_add0XPrefix;
/// 去除 `0x` 或者 `0X` 前缀
- (NSString *)kj_stripHexPrefix;

/// 是否为二进制
- (BOOL)kj_isBinary;
/// 是否为十进制
- (BOOL)kj_isDecimal;
/// 是否为十六进制
- (BOOL)kj_isHex;

/// 十六进制转十进制
- (NSString *)kj_hexToDecimal;
/// 十进制转十六进制
- (NSString *)kj_decimalToHex;

/// 十进制转二进制
- (NSString *)kj_decimalToBinary;
/// 二进制转十进制
- (NSString *)kj_binaryToDecimal;

/// 十六进制转二进制
- (NSString *)kj_hexToBinary;
/// 二进制转十六进制
- (NSString *)kj_binaryToHex;

/// 十六进制转`NSData`
- (NSData *)hexStringToHexData;
/// `NSData`转十六进制
extern NSString * kHexDataToHexString(NSData * data);

@end

NS_ASSUME_NONNULL_END
