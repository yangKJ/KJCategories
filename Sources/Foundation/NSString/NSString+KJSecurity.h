//
//  NSString+KJSecurity.h
//  KJEmitterView
//
//  Created by 77。 on 2021/1/5.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJSecurity)

/// Generate key
+ (NSString *)kj_createKey;
/// Generate token
+ (NSString *)kj_createToken;

#pragma mark - RSA asymmetric encryption algorithm
/// Public key encryption
- (NSString * (^)(NSString *))kj_rsaEncryptPublicKey;
/// Private key decryption
- (NSString * (^)(NSString *))kj_rsaDecryptPrivateKey;

/// Private key encryption-signature
- (NSString * (^)(NSString *))kj_rsaEncryptPrivateKey;
/// Public key decryption-verification
- (NSString * (^)(NSString *))kj_rsaDecryptPublicKey;

#pragma mark - ECC ellipse asymmetric encryption algorithm
/// Private key encryption-ECDSA signature
- (NSString * (^)(NSString *))kj_ECDSAEncryptPrivateKey;
/// Public key decryption-ECDSA verification
- (NSString * (^)(NSString *))kj_ECDSADecryptPublicKey;

#pragma mark - AES symmetric encryption algorithm
/// Encryption
- (NSString * (^)(NSString *))kj_aesEncryptKey;
/// Decrypt
- (NSString * (^)(NSString *))kj_aesDecryptKey;

#pragma mark - base64
/// Base64 encoding
- (NSString *)kj_base64EncodedString;
/// Base64 decoding
- (NSString *)kj_base64DecodingString;
/// URL-safe Base64 encoding
- (NSString *)kj_base64URLSafeEncodedString;
/// URL-safe Base64 decoding
- (NSString *)kj_base64URLSafeDecodingString;



#pragma mark ---------------- NSData ----------------
#pragma mark - RSA plate
+ (NSData *)kj_rsadecryptData:(NSData *)data privateKey:(NSString *)key;
+ (NSData *)kj_rsadecryptData:(NSData *)data publicKey:(NSString *)key;
+ (NSData *)kj_rsaencryptData:(NSData *)data publicKey:(NSString *)key;
+ (NSData *)kj_rsaencryptData:(NSData *)data privateKey:(NSString *)key;

#pragma mark - AES section
+ (NSData *)kj_aes128Data:(NSData *)data
                operation:(CCOperation)operation
                      key:(NSString *)key;

#pragma mark - Base64 plate
+ (NSString *)kj_base64EncodedStringWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
