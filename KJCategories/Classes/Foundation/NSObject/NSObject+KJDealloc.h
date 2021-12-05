//
//  NSObject+KJDealloc.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/29.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJDealloc)

/// 对象释放时刻调用
- (void)kj_objectDeallocBlock:(void(^)(void))block;

@end

NS_ASSUME_NONNULL_END
