//
//  NSObject+KJDoraemonBox.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/29.
//  https://github.com/YangKJ/KJCategories
//  哆啦A梦百宝箱

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJDoraemonBox)

#pragma mark - 轻量级解耦工具（信号方式）
/// 发送消息处理
- (id)kj_sendSemaphoreWithKey:(NSString *)key
                      Message:(id)message
                    Parameter:(id _Nullable)parameter;
/// 接收消息处理
- (void)kj_receivedSemaphoreBlock:(id _Nullable(^)(NSString * key, id message, id _Nullable parameter))block;

#pragma mark - 路由框架（基于URL实现控制器转场）
/// 注册路由URL
+ (void)kj_routerRegisterWithURL:(NSURL *)URL
                           Block:(UIViewController * (^)(NSURL * URL, UIViewController * vc))block;
/// 移除路由URL
+ (void)kj_routerRemoveWithURL:(NSURL *)URL;
/// 执行跳转处理
+ (void)kj_routerTransferWithURL:(NSURL *)URL
                          source:(UIViewController *)vc;
+ (void)kj_routerTransferWithURL:(NSURL *)URL
                          source:(UIViewController *)vc
                      completion:(void(^_Nullable)(UIViewController * vc))completion;
/// 解析获取参数
+ (NSDictionary *)kj_analysisParameterGetQuery:(NSURL *)URL;

#pragma mark - 安全数据处理

/// 安全非空数据转换，目前支持数组、字典、数字对象、字符串
/// @return 处理之后的对象，NSNull转换为空字符串
- (id)kj_safeObject;

/// 偷懒专用，自动生成属性代码
- (void)kj_autoCreatePropertyCodeWithJson:(id)json;
/// 模型转换，支持二级和关键字替换
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
