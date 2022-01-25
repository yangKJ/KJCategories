//
//  NSDecimalNumber+KJExtension.m
//  KJEmitterView
//
//  Created by yangkejun on 2021/8/21.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@implementation NSDecimalNumber (KJExtension)

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // When the Hook string is empty, the operation processing causes the crash problem
        [self kj_exchangeClassMethodWithOriginal:@selector(decimalNumberWithString:)
                                        swizzled:@selector(kj_decimalNumberWithString:)];
        [self kj_exchangeClassMethodWithOriginal:@selector(decimalNumberWithString:locale:)
                                        swizzled:@selector(kj_decimalNumberWithString:locale:)];
    });
}

+ (NSDecimalNumber *)kj_decimalNumberWithString:(nullable NSString *)numberValue{
    if (numberValue == nil) {
        numberValue = @"0";
    } else if (![numberValue isKindOfClass:[NSString class]]) {
        numberValue = [NSString stringWithFormat:@"%@", numberValue];
    } else if ([numberValue isEqualToString:@""]) {
        numberValue = @"0";
    }
    return [NSDecimalNumber kj_decimalNumberWithString:numberValue];
}

+ (NSDecimalNumber *)kj_decimalNumberWithString:(nullable NSString *)numberValue locale:(nullable id)locale{
    if (numberValue == nil) {
        numberValue = @"0";
    } else if (![numberValue isKindOfClass:[NSString class]]) {
        numberValue = [NSString stringWithFormat:@"%@", numberValue];
    } else if ([numberValue isEqualToString:@""]) {
        numberValue = @"0";
    }
    return [NSDecimalNumber kj_decimalNumberWithString:numberValue locale:locale];
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
