//
//  NSObject+KJDoraemonBox.h
//  KJEmitterView
//
//  Created by 77。 on 2019/10/29.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJDoraemonBox)

/// Send message processing
- (id)kj_sendSemaphoreWithKey:(NSString *)key
                      Message:(id)message
                    Parameter:(id _Nullable)parameter;
/// Receive message processing
- (void)kj_receivedSemaphoreBlock:(id _Nullable(^)(NSString * key, id message, id _Nullable parameter))block;

#pragma mark - routing framework
/// Register routing URL
+ (void)kj_routerRegisterWithURL:(NSURL *)URL
                           Block:(UIViewController * (^)(NSURL * URL, UIViewController * vc))block;

/// Remove routing URL
+ (void)kj_routerRemoveWithURL:(NSURL *)URL;

/// Execute jump processing
+ (void)kj_routerTransferWithURL:(NSURL *)URL
                          source:(UIViewController *)vc;
+ (void)kj_routerTransferWithURL:(NSURL *)URL
                          source:(UIViewController *)vc
                      completion:(void(^_Nullable)(UIViewController * vc))completion;
/// Analyze to obtain parameters
+ (NSDictionary *)kj_analysisParameterGetQuery:(NSURL *)URL;

#pragma mark - Secure data processing

/// Safe non-empty data conversion, currently supports arrays, dictionaries, digital objects, and strings
/// @return After processing the object, NSNull is converted to an empty string
- (id)kj_safeObject;

/// Special for laziness, automatically generate attribute code
- (void)kj_autoCreatePropertyCodeWithJson:(id)json;
/// Model conversion, support secondary and keyword substitution
+ (__kindof NSObject *)kj_modelTransformJson:(id)json;

@end

NS_ASSUME_NONNULL_END

/* 轻量级解耦工具使用规则 */
// 在View当中发送消息
// UIViewController *vc = [NSClassFromString(dic[@"VCName"]) new];
// [self kj_sendSemaphoreWithKey:kHomeViewKey Message:vc Parameter:dic];
//
// 在ViewController当中接收事件处理
// _weakself;
// [view kj_receivedSemaphoreBlock:^id _Nullable(NSString * _Nonnull key, id _Nonnull message, id _Nullable parameter) {
//     if ([key isEqualToString:kHomeViewKey]) {
//         ((UIViewController *)message).title = ((NSDictionary *)parameter)[@"describeName"];
//         [weakself.navigationController pushViewController:message animated:true];
//     }
//     return nil;
// }];
