//
//  NSString+KJEmoji.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/3.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJEmoji)

/// Is it an emoticon
@property (nonatomic, assign, readonly) BOOL isEmoji;
/// Whether to include emoticons
@property (nonatomic, assign, readonly) BOOL isContainEmoji;

/// Delete Emoji
- (NSString *)kj_removedEmojiString;

@end

NS_ASSUME_NONNULL_END
