//
//  NSString+KJBlockChain.h
//  KJEmitterView
//
//  Created by 77。 on 2021/5/28.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJBlockChain)

/// Add `0x` prefix
- (NSString *)kj_add0xPrefix;
/// Add `0X` prefix
- (NSString *)kj_add0XPrefix;
/// Remove `0x` or `0X` prefix
- (NSString *)kj_stripHexPrefix;

/// Is it binary
- (BOOL)kj_isBinary;
/// Is it decimal?
- (BOOL)kj_isDecimal;
/// Is it hexadecimal
- (BOOL)kj_isHex;

/// Hexadecimal to decimal
- (NSString *)kj_hexToDecimal;
/// Decimal to hexadecimal
- (NSString *)kj_decimalToHex;

/// Decimal to binary
- (NSString *)kj_decimalToBinary;
/// Binary to decimal
- (NSString *)kj_binaryToDecimal;

/// Hexadecimal to binary
- (NSString *)kj_hexToBinary;
/// Binary to hexadecimal
- (NSString *)kj_binaryToHex;

/// Hexadecimal to `NSData`
- (NSData *)hexStringToHexData;
/// `NSData` to hexadecimal
extern NSString * kHexDataToHexString(NSData * data);

@end

NS_ASSUME_NONNULL_END
