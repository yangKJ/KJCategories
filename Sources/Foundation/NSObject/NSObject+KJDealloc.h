//
//  NSObject+KJDealloc.h
//  KJEmitterView
//
//  Created by 77。 on 2019/10/29.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJDealloc)

/// Called when the object is released
- (void)kj_objectDeallocBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
