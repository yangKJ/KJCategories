//
//  NSData+KJExtension.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/4/28.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KJExtension)

/// Deflate算法压缩
- (NSData *)kj_zipDeflate;

/// Inflater解压缩，与上面是一对
- (NSData *)kj_zipInflater;

@end

NS_ASSUME_NONNULL_END
