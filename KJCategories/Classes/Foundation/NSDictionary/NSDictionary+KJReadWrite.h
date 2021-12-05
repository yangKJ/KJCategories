//
//  NSDictionary+KJReadWrite.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/6.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (KJReadWrite)

/// 读取本地Plist文件
+ (NSDictionary *)plistWithName:(NSString *)name;

#pragma mark - NSDictionary
- (unsigned long long)unsignedLongLongForKey:(NSString *)key;
- (unsigned long)unsignedLongForKey:(NSString *)key;
- (unsigned int)unsignedIntForKey:(NSString *)key;
- (unsigned short)unsignedShortForKey:(NSString *)key;
- (int)intForKey:(NSString *)key;
- (BOOL)boolForKey:(NSString *)key;
- (unsigned char)unsignedCharForKey:(NSString *)key;
- (char)charForKey:(NSString *)key;
- (float)floatForKey:(NSString *)key;
- (NSDate *)dateForKey:(NSString *)key;
- (NSArray *)arrayForKey:(NSString *)key;

#pragma mark - NSMutableDictionary
- (void)setUnsignedLongLong:(unsigned long long)value forKey:(id)aKey;
- (void)setUnsignedLong:(unsigned long)value forKey:(id)aKey;
- (void)setUnsignedInt:(unsigned int)value forKey:(id)aKey;
- (void)setInt:(int)value forKey:(id)aKey;
- (void)setBool:(BOOL)value forKey:(id)aKey;
- (void)setUnsignedShort:(unsigned short)value forKey:(id)aKey;
- (void)setDateWithTimeIntervalSince1970:(unsigned long)value forKey:(id)aKey;
- (void)setUnsignedChar:(unsigned char)value forKey:(id)aKey;
- (void)setChar:(char)value forKey:(id)aKey;
- (void)setFloat:(float)value forKey:(id)aKey;
- (void)setNSStringWithUTF8String:(const char*)value forKey:(id)aKey;
- (void)setDate:(NSDate *)value forKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
