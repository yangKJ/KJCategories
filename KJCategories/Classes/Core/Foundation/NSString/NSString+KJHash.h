//
//  NSString+KJHash.h
//  KJEmitterView
//
//  Created by 77。 on 2021/5/28.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJHash)
/// 判断是否为SHA512加密的字符串
@property (nonatomic, assign, readonly) BOOL verifySHA512;

/// 哈希加密
- (NSString *)SHA512String;

- (NSString *)SHA256String;

- (NSString *)MD5String;

/// base64解码
- (nullable NSString *)Base64DecodeString;
/// base64编码
- (nullable NSString *)Base64EncodeString;

/// AES256加密
/// @param key 密钥
- (NSString *)AES256EncryptWithKey:(NSString *)key;
+ (nullable NSData *)AES256EncryptData:(NSData *)data key:(NSString *)key;

/// AES256解密
/// @param key 密钥
- (NSString *)AES256DecryptWithKey:(NSString *)key;
+ (nullable NSData *)AES256DecryptData:(NSData *)data key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
