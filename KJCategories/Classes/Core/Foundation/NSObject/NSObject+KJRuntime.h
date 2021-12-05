//
//  NSObject+KJRuntime.h
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/15.
//  https://github.com/YangKJ/KJCategories
//  Runtime轻量级封装

#import <Foundation/Foundation.h>
#import <objc/runtime.h>
#import <objc/message.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (KJRuntime)

/// 获取该对象的所有属性
@property(nonatomic,strong,readonly)NSArray<NSString *> *propertyTemps;
/// 实例变量列表
@property(nonatomic,strong,readonly)NSArray<NSString *> *ivarTemps;
/// 方法列表
@property(nonatomic,strong,readonly)NSArray<NSString *> *methodTemps;
/// 遵循的协议列表
@property(nonatomic,strong,readonly)NSArray<NSString *> *protocolTemps;
/// 获取对象的所有属性，是否包含父类属性
@property(nonatomic,strong,readonly)NSArray<NSString *> *(^objectProperties)(BOOL containSuper);

/// 归档封装
- (void)kj_runtimeEncode:(NSCoder *)encoder;
/// 解档封装
- (void)kj_runtimeInitCoder:(NSCoder *)decoder;
/// NSCopying协议快捷设置
- (id)kj_setCopyingWithZone:(NSZone *)zone;
/// 拷贝属性
- (void)kj_copyingObject:(id)obj;

/// 拷贝指定类属性，NSCopying协议时使用
- (instancetype)kj_appointCopyPropertyClass:(Class)clazz Zone:(NSZone *)zone;
/// 拷贝全部属性（包括父类）
- (instancetype)kj_copyPropertyWithZone:(NSZone *)zone;

/// 交换实例方法，该方法需要放在 dispatch_once 当中执行
FOUNDATION_EXPORT void kRuntimeMethodSwizzling(Class clazz, SEL original, SEL swizzled);
/// 交换类方法
FOUNDATION_EXPORT void kRuntimeClassMethodSwizzling(Class clazz, SEL original, SEL swizzled);

/// 动态继承，慎用（一旦修改后面使用的都是该子类）
- (void)kj_dynamicInheritChildClass:(Class)clazz;
/// 获取对象类名
- (NSString *)kj_runtimeClassName;
/// 判断对象是否有该属性
- (void)kj_runtimeHaveProperty:(void(^)(NSString * property, BOOL * stop))traversal;

@end

NS_ASSUME_NONNULL_END
