//
//  NSString+KJRegex.h
//  KJEmitterView
//
//  Created by 77。 on 2021/8/18.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// Regular match test URL:https://c.runoob.com/front-end/854
@interface NSString (KJRegex)

/// Whether to include the data
/// @param regex matching element
- (BOOL)kj_matchWithRegex:(NSString *)regex;

/// Regular matching
/// @param regex matching element
- (NSString *)kj_partStringWithRegex:(NSString *)regex;

/// Regular matching of multiple data
/// @param regex matching element
- (NSArray<NSString *> *)kj_checkStringArrayWithRegex:(NSString *)regex;

@end

NS_ASSUME_NONNULL_END
