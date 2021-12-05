//
//  NSString+KJSecurity.m
//  KJEmitterView
//
//  Created by 杨科军 on 2021/1/5.
//  https://github.com/YangKJ/KJCategories

#import "NSString+KJSecurity.h"

@implementation NSString (KJSecurity)

/// 生成key
+ (NSString *)kj_createKey{
    NSUInteger size = 16;
    char data[size];
    for (int x=0;x<size;x++) {
        int randomint = arc4random_uniform(2);
        if (randomint == 0) {
            data[x] = (char)('a' + (arc4random_uniform(26)));
        } else {
            data[x] = (char)('0' + (arc4random_uniform(9)));
        }
    }
    return [[NSString alloc] initWithBytes:data length:size encoding:NSUTF8StringEncoding];
}
/// 生成token
+ (NSString *)kj_createToken{
    return [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

#pragma mark - rsa
- (NSString *(^)(NSString *))kj_rsaEncryptPublicKey{
    return ^(NSString * publicKey) {
        NSData *data = [NSString kj_rsaencryptData:[self dataUsingEncoding:NSUTF8StringEncoding] publicKey:publicKey];
        data = [data base64EncodedDataWithOptions:0];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    };
}
- (NSString *(^)(NSString *))kj_rsaDecryptPublicKey{
    return ^(NSString * publicKey) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
        data = [NSString kj_rsadecryptData:data publicKey:publicKey];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    };
}
- (NSString *(^)(NSString *))kj_rsaEncryptPrivateKey{
    return ^(NSString * privateKey) {
        NSData *data = [NSString kj_rsaencryptData:[self dataUsingEncoding:NSUTF8StringEncoding] privateKey:privateKey];
        data = [data base64EncodedDataWithOptions:0];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    };
}
- (NSString *(^)(NSString *))kj_rsaDecryptPrivateKey{
    return ^(NSString * privateKey) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
        data = [NSString kj_rsadecryptData:data privateKey:privateKey];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    };
}

#pragma mark - ecc
- (NSString *(^)(NSString *))kj_ECDSAEncryptPrivateKey{
    return ^(NSString * privateKey) {
        
        //根据keychain的属性查找ECC私钥，并获取私钥引用。
//        NSDictionary *params = @{(id)kSecClass: (id)kSecClassKey,
//                                 (id)kSecAttrKeyType: (id)kSecAttrKeyTypeECSECPrimeRandom,
//                                 (id)kSecAttrKeySizeInBits: @256,
//                                 (id)kSecAttrLabel: @"my-se-key",
//                                 (id)kSecReturnRef: @YES,
//                                 (id)kSecUseOperationPrompt: @"Authenticate to sign data"
//        };
//        id privateKey = CFBridgingRelease(SecKeyCreateRandomKey((__bridge CFDictionaryRef)parameters, (void *)&gen_error));
//
//        SecKeyRef privateKey;
//        OSStatus status = SecItemCopyMatching((__bridge CFDictionaryRef)params, (CFTypeRef *)&privateKey);
//
//        NSError *error;
//        NSData *dataToSign = [self dataUsingEncoding:NSUTF8StringEncoding];
//        NSData *signature = CFBridgingRelease(SecKeyCreateSignature(privateKey, kSecKeyAlgorithmECDSASignatureMessageX962SHA256, (CFDataRef)dataToSign, (void *)&error));
        
        NSData *data = [NSString kj_rsaencryptData:[self dataUsingEncoding:NSUTF8StringEncoding] privateKey:privateKey];
        data = [data base64EncodedDataWithOptions:0];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    };
}
- (NSString *(^)(NSString *))kj_ECDSADecryptPublicKey{
    return ^(NSString * privateKey) {
        
//        id publicKey = CFBridgingRelease(SecKeyCopyPublicKey((SecKeyRef)privateKey));
//
//        Boolean verified = SecKeyVerifySignature((SecKeyRef)publicKey,
//                                                 kSecKeyAlgorithmECDSASignatureMessageX962SHA256,
//                                                 (CFDataRef)dataToSign,
//                                                 (CFDataRef)signature,
//                                                 (void *)&error);
        
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters];
        data = [NSString kj_rsadecryptData:data privateKey:privateKey];
        return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    };
}

#pragma mark - aes
/// 加密
- (NSString *(^)(NSString *))kj_aesEncryptKey{
    return ^(NSString * key) {
        NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSData *aesData = [NSString kj_aes128Data:data operation:kCCEncrypt key:key];
        return [aesData base64EncodedStringWithOptions:(NSDataBase64Encoding64CharacterLineLength)];
    };
}
/// 解密
- (NSString *(^)(NSString *))kj_aesDecryptKey{
    return ^(NSString * key) {
        NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
        return [[NSString alloc] initWithData:[NSString kj_aes128Data:data operation:kCCDecrypt key:key] encoding:NSUTF8StringEncoding];
    };
}
#pragma mark - base64
- (NSString *)kj_base64EncodedString{
    NSData *date = [self dataUsingEncoding:NSUTF8StringEncoding];
    return [NSString kj_base64EncodedStringWithData:date];
}
- (NSString *)kj_base64DecodingString{
    NSData *data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}
/// URL安全的Base64编码
- (NSString *)kj_base64URLSafeEncodedString{
    //编码
    NSString *encodeUrlString = [self kj_base64EncodedString];
    // '-' -> '+'
    // '_' -> '/'
    // 不足4倍长度，补'='
    NSMutableString * base64String = [[NSMutableString alloc]initWithString:encodeUrlString];
    base64String = (NSMutableString*)[base64String stringByReplacingOccurrencesOfString:@"-" withString:@"+"];
    base64String = (NSMutableString*)[base64String stringByReplacingOccurrencesOfString:@"_" withString:@"/"];
    NSInteger mod4 = base64String.length % 4;
    if (mod4 > 0) [base64String appendString:[@"====" substringToIndex:(4-mod4)]];
    return base64String.mutableCopy;
}
/// URL安全的Base64解码
- (NSString *)kj_base64URLSafeDecodingString{
    NSData * data = [[NSData alloc]initWithBase64EncodedString:self options:0];
    NSString * base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    // '+' -> '-'
    // '/' -> '_'
    // '=' -> ''
    NSMutableString * safeBase64String = [[NSMutableString alloc]initWithString:base64String];
    safeBase64String = (NSMutableString*)[safeBase64String stringByReplacingOccurrencesOfString:@"+" withString:@"-"];
    safeBase64String = (NSMutableString*)[safeBase64String stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
    safeBase64String = (NSMutableString*)[safeBase64String stringByReplacingOccurrencesOfString:@"=" withString:@""];
    return safeBase64String;
}





#pragma mark -------- NSData
#pragma mark - RSA板块
static NSData * base64_decode(NSString * string){
    return [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
}
+ (NSData *)kj_rsadecryptData:(NSData *)data privateKey:(NSString *)key{
    if(!data || !key) return nil;
    SecKeyRef keyRef = [self addPrivateKey:key];
    if(!keyRef) return nil;
    return [self decryptData:data withKeyRef:keyRef];
}
+ (NSData *)kj_rsadecryptData:(NSData *)data publicKey:(NSString *)key{
    if(!data || !key) return nil;
    SecKeyRef keyRef = [self addPublicKey:key];
    if(!keyRef) return nil;
    return [self decryptData:data withKeyRef:keyRef];
}
+ (NSData *)kj_rsaencryptData:(NSData *)data publicKey:(NSString *)key{
    if(!data || !key) return nil;
    SecKeyRef keyRef = [self addPublicKey:key];
    if(!keyRef) return nil;
    return [self encryptData:data withKeyRef:keyRef isSign:NO];
}
+ (NSData *)kj_rsaencryptData:(NSData *)data privateKey:(NSString *)key{
    if(!data || !key) return nil;
    SecKeyRef keyRef = [self addPrivateKey:key];
    if(!keyRef) return nil;
    return [self encryptData:data withKeyRef:keyRef isSign:YES];
}

+ (NSData *)stripPublicKeyHeader:(NSData *)d_key{
    if (d_key == nil) return(nil);
    unsigned long len = [d_key length];
    if (!len) return(nil);
    unsigned char *c_key = (unsigned char*)[d_key bytes];
    unsigned int idx = 0;
    if (c_key[idx++] != 0x30) return(nil);
    if (c_key[idx] > 0x80) {
        idx += c_key[idx] - 0x80 + 1;
    } else {
        idx++;
    }
    static unsigned char seqiod[] = { 0x30, 0x0d, 0x06, 0x09, 0x2a, 0x86, 0x48, 0x86, 0xf7, 0x0d, 0x01, 0x01, 0x01, 0x05, 0x00 };
    if (memcmp(&c_key[idx], seqiod, 15)) return(nil);
    idx += 15;
    if (c_key[idx++] != 0x03) return(nil);
    if (c_key[idx] > 0x80) {
        idx += c_key[idx] - 0x80 + 1;
    } else {
        idx++;
    }
    if (c_key[idx++] != '\0') return(nil);
    return ([NSData dataWithBytes:&c_key[idx] length:len - idx]);
}

+ (NSData *)stripPrivateKeyHeader:(NSData *)d_key{
    if (d_key == nil) return(nil);
    unsigned long len = [d_key length];
    if (!len) return(nil);
    unsigned char*c_key = (unsigned char*)[d_key bytes];
    unsigned int  idx = 22;
    if (0x04 != c_key[idx++]) return nil;
    unsigned int c_len = c_key[idx++];
    int det = c_len & 0x80;
    if (!det) {
        c_len = c_len & 0x7f;
    } else {
        int byteCount = c_len & 0x7f;
        if (byteCount + idx > len) return nil;
        unsigned int accum = 0;
        unsigned char*ptr = &c_key[idx];
        idx += byteCount;
        while (byteCount) {
            accum = (accum << 8) +*ptr;
            ptr++;
            byteCount--;
        }
        c_len = accum;
    }
    return [d_key subdataWithRange:NSMakeRange(idx, c_len)];
}
+ (SecKeyRef)addPublicKey:(NSString *)key{
    NSRange spos = [key rangeOfString:@"-----BEGIN PUBLIC KEY-----"];
    NSRange epos = [key rangeOfString:@"-----END PUBLIC KEY-----"];
    if (spos.location != NSNotFound && epos.location != NSNotFound) {
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];
    NSData *data = base64_decode(key);
    data = [self stripPublicKeyHeader:data];
    if(!data) return nil;
    NSString *tag = @"RSAUtil_PubKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];
    
    NSMutableDictionary*publicKey = [[NSMutableDictionary alloc] init];
    [publicKey setObject:(__bridge id)kSecClassKey forKey:(__bridge id)kSecClass];
    [publicKey setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [publicKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)publicKey);
    
    [publicKey setObject:data forKey:(__bridge id)kSecValueData];
    [publicKey setObject:(__bridge id)kSecAttrKeyClassPublic forKey:(__bridge id)kSecAttrKeyClass];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnPersistentRef];
    
    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)publicKey, &persistKey);
    if (persistKey != nil) CFRelease(persistKey);
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }

    [publicKey removeObjectForKey:(__bridge id)kSecValueData];
    [publicKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [publicKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [publicKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)publicKey, (CFTypeRef*)&keyRef);
    if(status != noErr) return nil;
    return keyRef;
}

+ (SecKeyRef)addPrivateKey:(NSString *)key{
    NSRange spos,epos;
    spos = [key rangeOfString:@"-----BEGIN RSA PRIVATE KEY-----"];
    if(spos.length > 0){
        epos = [key rangeOfString:@"-----END RSA PRIVATE KEY-----"];
    } else {
        spos = [key rangeOfString:@"-----BEGIN PRIVATE KEY-----"];
        epos = [key rangeOfString:@"-----END PRIVATE KEY-----"];
    }
    if(spos.location != NSNotFound && epos.location != NSNotFound){
        NSUInteger s = spos.location + spos.length;
        NSUInteger e = epos.location;
        NSRange range = NSMakeRange(s, e-s);
        key = [key substringWithRange:range];
    }
    key = [key stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    key = [key stringByReplacingOccurrencesOfString:@" "  withString:@""];

    NSData *data = base64_decode(key);
    data = [self stripPrivateKeyHeader:data];
    if(!data) return nil;
    
    NSString *tag = @"RSAUtil_PrivKey";
    NSData *d_tag = [NSData dataWithBytes:[tag UTF8String] length:[tag length]];

    NSMutableDictionary*privateKey = [[NSMutableDictionary alloc] init];
    [privateKey setObject:(__bridge id) kSecClassKey forKey:(__bridge id)kSecClass];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [privateKey setObject:d_tag forKey:(__bridge id)kSecAttrApplicationTag];
    SecItemDelete((__bridge CFDictionaryRef)privateKey);

    [privateKey setObject:data forKey:(__bridge id)kSecValueData];
    [privateKey setObject:(__bridge id)kSecAttrKeyClassPrivate forKey:(__bridge id)kSecAttrKeyClass];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnPersistentRef];

    CFTypeRef persistKey = nil;
    OSStatus status = SecItemAdd((__bridge CFDictionaryRef)privateKey, &persistKey);
    if (persistKey != nil) CFRelease(persistKey);
    if ((status != noErr) && (status != errSecDuplicateItem)) {
        return nil;
    }

    [privateKey removeObjectForKey:(__bridge id)kSecValueData];
    [privateKey removeObjectForKey:(__bridge id)kSecReturnPersistentRef];
    [privateKey setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecReturnRef];
    [privateKey setObject:(__bridge id) kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    SecKeyRef keyRef = nil;
    status = SecItemCopyMatching((__bridge CFDictionaryRef)privateKey, (CFTypeRef*)&keyRef);
    if(status != noErr) return nil;
    return keyRef;
}

+ (NSData *)encryptData:(NSData *)data withKeyRef:(SecKeyRef)keyRef isSign:(BOOL)isSign {
    const uint8_t *srcbuf = (const uint8_t*)[data bytes];
    size_t srclen = (size_t)data.length;
    size_t block_size = SecKeyGetBlockSize(keyRef)* sizeof(uint8_t);
    void*outbuf = malloc(block_size);
    size_t src_block_size = block_size - 11;
    NSMutableData*ret = [[NSMutableData alloc] init];
    for (int idx = 0; idx < srclen; idx += src_block_size) {
        size_t data_len = srclen - idx;
        if (data_len > src_block_size) data_len = src_block_size;
        size_t outlen = block_size;
        OSStatus status = noErr;
        if (isSign) {
            status = SecKeyRawSign(keyRef, kSecPaddingPKCS1, srcbuf + idx, data_len, outbuf, &outlen);
        } else {
            status = SecKeyEncrypt(keyRef, kSecPaddingPKCS1, srcbuf + idx, data_len, outbuf, &outlen);
        }
        if (status != 0) {
            ret = nil;
            break;
        } else {
            [ret appendBytes:outbuf length:outlen];
        }
    }
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

+ (NSData *)decryptData:(NSData *)data withKeyRef:(SecKeyRef)keyRef{
    const uint8_t*srcbuf = (const uint8_t*)[data bytes];
    size_t srclen = (size_t)data.length;
    size_t block_size = SecKeyGetBlockSize(keyRef)* sizeof(uint8_t);
    UInt8*outbuf = malloc(block_size);
    size_t src_block_size = block_size;
    NSMutableData*ret = [[NSMutableData alloc] init];
    for(int idx=0; idx<srclen; idx+=src_block_size){
        size_t data_len = srclen - idx;
        if (data_len > src_block_size) data_len = src_block_size;
        size_t outlen = block_size;
        OSStatus status = noErr;
        status = SecKeyDecrypt(keyRef, kSecPaddingNone, srcbuf + idx, data_len, outbuf, &outlen);
        if (status != 0) {
            ret = nil;
            break;
        } else {
            int idxFirstZero = -1;
            int idxNextZero = (int)outlen;
            for (int i = 0; i < outlen; i++) {
                if ( outbuf[i] == 0 ) {
                    if (idxFirstZero < 0) {
                        idxFirstZero = i;
                    } else {
                        idxNextZero = i;
                        break;
                    }
                }
            }
            [ret appendBytes:&outbuf[idxFirstZero+1] length:idxNextZero-idxFirstZero-1];
        }
    }
    free(outbuf);
    CFRelease(keyRef);
    return ret;
}

#pragma mark - AES板块
+ (NSData *)kj_aes128Data:(NSData *)data operation:(CCOperation)operation key:(NSString *)key{
    char keyPtr[kCCKeySizeAES128 + 1];//kCCKeySizeAES128是加密位数 可以替换成256位的
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    size_t bufferSize = [data length] + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptorStatus = CCCrypt(operation,
                                            kCCAlgorithmAES,
                                            kCCOptionPKCS7Padding | kCCOptionECBMode,
                                            keyPtr,
                                            kCCKeySizeAES128,
                                            NULL,
                                            [data bytes],
                                            [data length],
                                            buffer, bufferSize,
                                            &numBytesEncrypted);
    if (cryptorStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    if (buffer) free(buffer);
    return nil;
}

#pragma mark - Base64板块
/// base64编码处理
static const char base64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
+ (NSString *)kj_base64EncodedStringWithData:(NSData *)data{
    NSUInteger length = data.length;
    if (length == 0) return @"";
    
    NSUInteger out_length = ((length + 2) / 3) * 4;
    uint8_t *output = malloc(((out_length + 2) / 3) * 4);
    if (output == NULL) return nil;
    
    const char *input = data.bytes;
    NSInteger i, value;
    for (i = 0; i < length; i += 3) {
        value = 0;
        for (NSInteger j = i; j < i + 3; j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] = base64EncodingTable[(value >> 18) & 0x3F];
        output[index + 1] = base64EncodingTable[(value >> 12) & 0x3F];
        output[index + 2] = ((i + 1) < length) ? base64EncodingTable[(value >> 6) & 0x3F] : '=';
        output[index + 3] = ((i + 2) < length) ? base64EncodingTable[(value >> 0) & 0x3F] : '=';
    }
    
    NSString *base64 = [[NSString alloc] initWithBytes:output length:out_length encoding:NSASCIIStringEncoding];
    free(output);
    return base64;
}

@end
