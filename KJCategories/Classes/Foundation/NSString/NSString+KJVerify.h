//
//  NSString+KJVerify.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/8/10.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJVerify)

/// Is it a pure letter
@property (nonatomic, assign, readonly) BOOL isPureLetter;
/// Is it a capital letter
@property (nonatomic, assign, readonly) BOOL isCapitalLetter;
/// Is it a lowercase letter
@property (nonatomic, assign, readonly) BOOL isLowercaseLetter;
/// Is it a pure Chinese character
@property (nonatomic, assign, readonly) BOOL isChineseCharacter;
/// Does it contain letters
@property (nonatomic, assign, readonly) BOOL isContainLetter;
/// Whether it contains only letters and numbers
@property (nonatomic, assign, readonly) BOOL isLetterAndNumber;
/// Does it start with a letter
@property (nonatomic, assign, readonly) BOOL isLettersBegin;
/// Whether to start with a Chinese character
@property (nonatomic, assign, readonly) BOOL isChineseBegin;

/// Filter spaces
- (NSString *)kj_filterSpace;

/// Filter special characters
/// @param character filter character
- (NSString *)kj_removeSpecialCharacter:(NSString * _Nullable)character;

/// Verify whether there are special characters in the string
- (BOOL)kj_validateHaveSpecialCharacter;

/// Verify mobile phone number
- (BOOL)kj_validateMobileNumber;

/// Verify email format
- (BOOL)kj_validateEmail;

/// Verify ID
- (BOOL)kj_validateIDCardNumber;

/// Verify bank card
- (BOOL)kj_validateBankCardNumber;

/// Verify IP address
- (BOOL)kj_validateIPAddress;

@end

NS_ASSUME_NONNULL_END
