//
//  NSObject+KJDealloc.m
//  KJEmitterView
//
//  Created by 77。 on 2019/10/29.
//  https://github.com/YangKJ/KJCategories

#import "NSObject+KJDealloc.h"
#import <objc/runtime.h>

@interface KJDeallocManager : NSObject

@property (nonatomic, copy, readwrite) void(^withBlock)(void);

@end

@implementation KJDeallocManager

- (void)dealloc {
    if (self.withBlock) {
        self.withBlock();
    }
}

@end

@implementation NSObject (KJDealloc)

/// 对象释放时刻调用
static char kDeallocListKey;
- (void)kj_objectDeallocBlock:(void(^)(void))block{
    @synchronized (self) {
        NSMutableArray *list = objc_getAssociatedObject(self, &kDeallocListKey);
        if (list == nil) {
            list = [NSMutableArray array];
            objc_setAssociatedObject(self, &kDeallocListKey, list, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        KJDeallocManager * manager = [[KJDeallocManager alloc] init];
        manager.withBlock = block;
        [list addObject:manager];
    }
}

@end
