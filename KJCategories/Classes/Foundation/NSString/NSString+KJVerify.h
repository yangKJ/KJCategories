//
//  NSString+KJVerify.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/8/10.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  验证处理

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJVerify)

/// 是否为纯字母
@property (nonatomic, assign, readonly) BOOL isPureLetter;
/// 是否为大写字母
@property (nonatomic, assign, readonly) BOOL isCapitalLetter;
/// 是否为小写字母
@property (nonatomic, assign, readonly) BOOL isLowercaseLetter;
/// 是否为纯汉字
@property (nonatomic, assign, readonly) BOOL isChineseCharacter;
/// 是否包含字母
@property (nonatomic, assign, readonly) BOOL isContainLetter;
/// 是否仅包含字母和数字
@property (nonatomic, assign, readonly) BOOL isLetterAndNumber;
/// 是否以字母开头
@property (nonatomic, assign, readonly) BOOL isLettersBegin;
/// 是否以汉字开头
@property (nonatomic, assign, readonly) BOOL isChineseBegin;

/// 过滤空格
- (NSString *)kj_filterSpace;

/// 过滤特殊字符
/// @param character 过滤字符
- (NSString *)kj_removeSpecialCharacter:(NSString * _Nullable)character;

/// 验证字符串中是否有特殊字符
- (BOOL)kj_validateHaveSpecialCharacter;

/// 验证手机号码
- (BOOL)kj_validateMobileNumber;

/// 验证邮箱格式
- (BOOL)kj_validateEmail;

/// 验证身份证
- (BOOL)kj_validateIDCardNumber;

/// 验证银行卡
- (BOOL)kj_validateBankCardNumber;

/// 验证IP地址
- (BOOL)kj_validateIPAddress;

@end

NS_ASSUME_NONNULL_END
