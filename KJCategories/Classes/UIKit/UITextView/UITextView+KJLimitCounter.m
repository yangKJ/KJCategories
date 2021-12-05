//
//  UITextView+KJLimitCounter.m
//  CategoryDemo
//
//  Created by 杨科军 on 2018/7/12.
//  Copyright © 2018年 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "UITextView+KJLimitCounter.h"
#import <objc/runtime.h>

@implementation UITextView (KJLimitCounter)

#pragma mark - swizzled

- (void)limitSwizzled{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                       class_getInstanceMethod(self.class, @selector(kj_limit_layoutSubviews)));
        method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                       class_getInstanceMethod(self.class, @selector(kj_limit_dealloc)));
    });
}

- (void)kj_limit_dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    for (NSString *key in self.class.observingKeys) {
        @try {
            [self removeObserver:self forKeyPath:key];
        } @catch (NSException *exception) {
            // Do nothing
        }
    }
    [self kj_limit_dealloc];
}
- (void)kj_limit_layoutSubviews{
    [self kj_limit_layoutSubviews];
    if (self.limitCount) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        textContainerInset.bottom = self.limitHeight;
        self.contentInset = textContainerInset;
        CGFloat x = CGRectGetMinX(self.frame)+self.layer.borderWidth;
        CGFloat y = CGRectGetMaxY(self.frame)-self.contentInset.bottom-self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds)-self.layer.borderWidth*2;
        CGFloat height = self.limitHeight;
        self.limitLabel.frame = CGRectMake(x, y, width, height);
        if (![self.superview.subviews containsObject:self.limitLabel]) {
            [self.superview insertSubview:self.limitLabel aboveSubview:self];
        }
    }
}

#pragma mark - kvo

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context{
    if ([keyPath isEqualToString:@"layer.borderWidth"] || [keyPath isEqualToString:@"text"]) {
        [self updateLimitCount];
    } else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void)updateLimitCount{
    if (self.text.length > self.limitCount){
        if (self.markedTextRange) return;
        NSRange range = [self.text rangeOfComposedCharacterSequenceAtIndex:self.limitCount];
        self.text = [self.text substringToIndex:range.location];
    }
    NSString *showText = [NSString stringWithFormat:@"%lu/%ld",(unsigned long)self.text.length,(long)self.limitCount];
    self.limitLabel.text = showText;
    NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc] initWithString:showText];
    NSUInteger length = [showText length];
    NSMutableParagraphStyle *style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.tailIndent = -self.limitMargin;
    style.alignment = NSTextAlignmentRight;
    [attrString addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, length)];
    self.limitLabel.attributedText = attrString;
}

+ (NSArray *)observingKeys {
    return @[
        @"attributedText",
        @"bounds",
        @"font",
        @"frame",
        @"text",
        @"textAlignment",
        @"textContainerInset",
        @"textContainer.lineFragmentPadding",
        @"textContainer.exclusionPaths"
    ];
}

#pragma mark - associated

- (UILabel *)limitLabel{
    UILabel * label = objc_getAssociatedObject(self, @selector(limitLabel));
    if (label == nil) {
        label = [[UILabel alloc] init];
        label.backgroundColor = self.backgroundColor;
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:12];
        objc_setAssociatedObject(self, @selector(limitLabel), label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateLimitCount)
                                                     name:UITextViewTextDidChangeNotification
                                                   object:self];
        for (NSString *key in self.class.observingKeys) {
            [self addObserver:self forKeyPath:key options:NSKeyValueObservingOptionNew context:nil];
        }
    }
    return label;
}

- (NSInteger)limitCount{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}
- (void)setLimitCount:(NSInteger)limitCount{
    objc_setAssociatedObject(self, @selector(limitCount), @(limitCount), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self limitSwizzled];
    [self updateLimitCount];
}
- (CGFloat)limitMargin{
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return number == nil ? 10 : [number floatValue];
}
- (void)setLimitMargin:(CGFloat)limitMargin{
    objc_setAssociatedObject(self, @selector(limitMargin), @(limitMargin), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self limitSwizzled];
    [self updateLimitCount];
}
- (CGFloat)limitHeight{
    NSNumber * number = objc_getAssociatedObject(self, _cmd);
    return number == nil ? 20 : [number floatValue];
}
- (void)setLimitHeight:(CGFloat)limitHeight{
    objc_setAssociatedObject(self, @selector(limitHeight), @(limitHeight), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self limitSwizzled];
    [self updateLimitCount];
}

@end
