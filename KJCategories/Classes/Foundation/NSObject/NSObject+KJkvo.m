//
//  NSObject+KJkvo.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/10/29.
//  https://github.com/YangKJ/KJCategories

#import "NSObject+KJkvo.h"
#import <objc/runtime.h>

@interface NSObject ()
/// 记录已经添加监听的keyPath与对应的block
@property (nonatomic,strong) NSMutableDictionary *observeDictionary;

@end

@implementation NSObject (KJkvo)

/// kvo监听，自动释放
/// @param keyPath 监听字段，暂不支持点语法
/// @param withBlock 变化响应
- (void)kj_kvokeyPath:(NSString *)keyPath result:(void(^)(id, id))withBlock{
    if (keyPath.length < 1 || [keyPath containsString:@"."]) return;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject kj_exchangeClassMethodWithOriginal:NSSelectorFromString(@"dealloc")
                                            swizzled:@selector(kj_kvo_dealloc)];
    });
    self.usekvo = YES;
    [self addObserver:self forKeyPath:keyPath
              options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew
              context:(__bridge_retained void *)(withBlock)];
    [self.observeDictionary setValue:withBlock forKey:keyPath];
}

- (void)kj_kvo_dealloc{
    if (self.usekvo == NO) {
        [self kj_kvo_dealloc];
        return;
    }
    if (self.observeDictionary) {
        for (NSString * keyPath in self.observeDictionary.allKeys) {
            [self removeObserver:self forKeyPath:keyPath];
        }
        self.observeDictionary = nil;
    }
    [self kj_kvo_dealloc];
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context{
    if (object == self) {
        void(^withBlock)(id, id) = (__bridge void(^)(id, id))context;
        if (withBlock) {
            withBlock(change[@"new"], change[@"old"]);
        }
    }
}

#pragma mark - associated

- (BOOL)usekvo{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}
- (void)setUsekvo:(BOOL)usekvo{
    objc_setAssociatedObject(self, @selector(usekvo), @(usekvo), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (NSMutableDictionary *)observeDictionary{
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (dict == nil) dict = [NSMutableDictionary dictionary];
    return dict;
}
- (void)setObserveDictionary:(NSMutableDictionary *)observeDictionary{
    objc_setAssociatedObject(self, @selector(observeDictionary), observeDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)kj_exchangeClassMethodWithOriginal:(SEL)original swizzled:(SEL)swizzled{
    Class clazz = [self class];
    Method originalMethod = class_getClassMethod(clazz, original);
    Method swizzledMethod = class_getClassMethod(clazz, swizzled);
    Class metaclass = objc_getMetaClass(NSStringFromClass(clazz).UTF8String);
    if (class_addMethod(metaclass, original, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(metaclass, swizzled, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@end
