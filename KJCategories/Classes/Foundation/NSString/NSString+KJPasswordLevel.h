//
//  NSString+KJPasswordLevel.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/3.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
// Password strength level
typedef NS_ENUM(NSUInteger, KJPasswordLevel) {
    KJPasswordLevelEasy = 0,
    KJPasswordLevelMidium,
    KJPasswordLevelStrong,
    KJPasswordLevelVeryStrong,
    KJPasswordLevelExtremelyStrong,
};
@interface NSString (KJPasswordLevel)

/// Determine whether each character in the string is equal
- (BOOL)kj_isCharEqual;

/// Password strength level
- (KJPasswordLevel)kj_passwordLevel;

#pragma mark-Chinese character related processing

/// Convert Chinese characters to Pinyin
@property (nonatomic, strong, readonly) NSString *pinYin;
/// Random Chinese characters
extern NSString * kRandomChinese(NSInteger count);
/// Alphabetically
extern NSArray * kDoraemonBoxAlphabetSort(NSArray<NSString *> * array);

/// Find data
/// @param array data source
/// @return returns the index of the data found, and returns `-1` to indicate that it has not been found
- (NSInteger)kj_searchArray:(NSArray<NSString *> *)array;

@end

NS_ASSUME_NONNULL_END
