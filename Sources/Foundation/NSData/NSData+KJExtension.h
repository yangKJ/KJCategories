//
//  NSData+KJExtension.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/4/28.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KJExtension)

/// Deflate algorithm compression
- (NSData *)kj_zipDeflate;

/// Inflater decompresses, it is a pair with the above
- (NSData *)kj_zipInflater;

@end

NS_ASSUME_NONNULL_END
