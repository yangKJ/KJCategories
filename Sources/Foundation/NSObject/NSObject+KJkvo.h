//
//  NSObject+KJkvo.h
//  KJEmitterView
//
//  Created by 77。 on 2019/10/29.
//  https://github.com/YangKJ/KJCategories

/* Kvo key-value monitoring package usage rules */
// [self.label kj_observeKey:@"text" ObserveResultBlock:^(id _Nonnull newValue, id _Nonnull oldValue) {
//     NSLog(@"%@",newValue);
// }];

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJkvo)

/// kvo monitor properties, automatically release
/// Point syntax is not supported for the time being, for example: button.titleLabel.font such as `titleLabel.font`
/// @param keyPath listening field
/// @param withBlock change response
- (void)kj_kvokeyPath:(NSString *)keyPath
               result:(void(^)(id newValue, id oldValue))withBlock;

@end

NS_ASSUME_NONNULL_END
