//
//  NSString+KJEmoji.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/3.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  表情相关

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJEmoji)

/// 是否是表情
@property(nonatomic,assign,readonly)BOOL isEmoji;
/// 是否包含表情
@property(nonatomic,assign,readonly)BOOL isContainEmoji;

/// 删除Emoji
- (NSString *)kj_removedEmojiString;

@end

NS_ASSUME_NONNULL_END
