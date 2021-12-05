//
//  NSString+KJSecurity.h
//  KJEmitterView
//
//  Created by 杨科军 on 2021/1/5.
//  https://github.com/YangKJ/KJCategories
//  加密解密工具
//  用法示例：NSString *encryptString = @"原始数据".kj_rsaEncryptPublicKey(@"key");

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJSecurity)

/// 生成key
+ (NSString *)kj_createKey;
/// 生成token
+ (NSString *)kj_createToken;

#pragma mark - RSA 非对称加密算法
/// 公钥加密
- (NSString * (^)(NSString *))kj_rsaEncryptPublicKey;
/// 私钥解密
- (NSString * (^)(NSString *))kj_rsaDecryptPrivateKey;

/// 私钥加密 - 签名
- (NSString * (^)(NSString *))kj_rsaEncryptPrivateKey;
/// 公钥解密 - 验签
- (NSString * (^)(NSString *))kj_rsaDecryptPublicKey;

#pragma mark - ECC 椭圆非对称加密算法
/// 私钥加密 - ECDSA签名
- (NSString * (^)(NSString *))kj_ECDSAEncryptPrivateKey;
/// 公钥解密 - ECDSA验签
- (NSString * (^)(NSString *))kj_ECDSADecryptPublicKey;

/// ECIES加密

/// ECIES解密


#pragma mark - AES 对称加密算法
/// 加密
- (NSString * (^)(NSString *))kj_aesEncryptKey;
/// 解密
- (NSString * (^)(NSString *))kj_aesDecryptKey;

#pragma mark - base64
/// Base64编码
- (NSString *)kj_base64EncodedString;
/// Base64解码
- (NSString *)kj_base64DecodingString;
/// URL安全的Base64编码
- (NSString *)kj_base64URLSafeEncodedString;
/// URL安全的Base64解码
- (NSString *)kj_base64URLSafeDecodingString;



#pragma mark ---------------- NSData ----------------
#pragma mark - RSA板块
+ (NSData *)kj_rsadecryptData:(NSData *)data privateKey:(NSString *)key;
+ (NSData *)kj_rsadecryptData:(NSData *)data publicKey:(NSString *)key;
+ (NSData *)kj_rsaencryptData:(NSData *)data publicKey:(NSString *)key;
+ (NSData *)kj_rsaencryptData:(NSData *)data privateKey:(NSString *)key;

#pragma mark - AES板块
+ (NSData *)kj_aes128Data:(NSData *)data
                operation:(CCOperation)operation
                      key:(NSString *)key;

#pragma mark - Base64板块
+ (NSString *)kj_base64EncodedStringWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
