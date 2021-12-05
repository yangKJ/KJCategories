//
//  UITextView+KJHyperlink.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/12/4.
//  Copyright © 2019 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "UITextView+KJHyperlink.h"
#import <objc/runtime.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"

@interface UITextView ()<UITextViewDelegate>

@property(nonatomic,copy,readwrite) KJTextViewURLHyperlinkBlock withBlock;
@property(nonatomic,copy) NSArray *URLTemps;

@end

@implementation UITextView (KJHyperlink)

/// 识别超链接
- (NSArray *)kj_clickTextViewURLCustom:(URLCustom)custom withBlock:(KJTextViewURLHyperlinkBlock)withBlock{
    self.withBlock = withBlock;
    self.delegate = self;
    self.editable = NO;
    UIColor *color = custom.color?:UIColor.blueColor;
    UIFont  *font = custom.font?:self.font;
    NSString *str = self.text;
    NSArray *array = getURLWithText(str);
    NSMutableArray *temp = [NSMutableArray array];
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:str];
    [abs beginEditing];
    self.linkTextAttributes = @{}; /// 解决设置NSLinkAttributeName字体颜色无效的处理
    [abs addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0,str.length)];
    for (int i = 0; i < array.count; i++) {
        NSValue *customValue = array[i];
        struct kURLBody value;
        [customValue getValue:&value];
        [temp addObject:[NSString stringWithCString:value.charURLString encoding:NSUTF8StringEncoding]];
        [abs addAttribute:NSLinkAttributeName value:[NSString stringWithFormat:@"%d",i] range:value.range];
        [abs addAttribute:NSForegroundColorAttributeName value:color range:value.range];
        [abs addAttribute:NSFontAttributeName value:font range:value.range];
    }
    self.URLTemps = temp.copy;
    array = temp = nil;
    self.attributedText = abs;
    return self.URLTemps;
}
/// 定义网址结构体类型
struct kURLBody{char *charURLString; NSRange range;};
/// IOS 正则表达式匹配文本中URL位置并获取URL所在位置
static inline NSArray * getURLWithText(NSString *string) {
    NSError *error;
    NSString *regulaStr = @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regulaStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *array = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
    NSMutableArray *temp = [NSMutableArray array];
    for (NSTextCheckingResult *match in array) {
        NSString *substring = [string substringWithRange:match.range];
        struct kURLBody URL = {(char *)[substring UTF8String], match.range};
        NSValue *value = [NSValue value:&URL withObjCType:@encode(struct kURLBody)];
        [temp addObject:value];
    }
    return temp.copy;
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView*)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if (self.withBlock) {
        NSInteger i = [URL.absoluteString integerValue];
        self.withBlock(self.URLTemps[i]);
    }
    return YES;
}

#pragma mark - Associated

- (KJTextViewURLHyperlinkBlock)withBlock{
    return objc_getAssociatedObject(self, @selector(withBlock));
}
- (void)setWithBlock:(KJTextViewURLHyperlinkBlock)withBlock{
    objc_setAssociatedObject(self, @selector(withBlock), withBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSArray *)URLTemps{
    return objc_getAssociatedObject(self, @selector(URLTemps));
}
- (void)setURLTemps:(NSArray *)URLTemps{
    objc_setAssociatedObject(self, @selector(URLTemps), URLTemps, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

#pragma clang diagnostic pop
