//
//  NSObject+KJkvo.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/29.
//  https://github.com/YangKJ/KJCategories
//  kvo键值监听封装，自动释放

/* kvo键值监听封装使用规则 */
// [self.label kj_observeKey:@"text" ObserveResultBlock:^(id _Nonnull newValue, id _Nonnull oldValue) {
//     NSLog(@"%@",newValue);
// }];

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJkvo)

/// kvo监听属性，自动释放
/// 暂不支持点语法例如：button.titleLabel.font这种 `titleLabel.font`
/// @param keyPath 监听字段
/// @param withBlock 变化响应
- (void)kj_kvokeyPath:(NSString *)keyPath
               result:(void(^)(id newValue, id oldValue))withBlock;

@end

NS_ASSUME_NONNULL_END
