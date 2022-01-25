//
//  UIButton+KJIndicator.m
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  https://github.com/YangKJ/KJCategories

#import "UIButton+KJIndicator.h"
#import <objc/runtime.h>

@implementation UIButton (KJIndicator)

#pragma mark - 指示器
static NSString *kIndicatorLastTitle = nil;
- (void)kj_beginSubmitting:(NSString *)title{
    [self kj_endSubmitting];
    kSubmitting = true;
    kIndicatorLastTitle = self.titleLabel.text;
    self.enabled = NO;
    [self setTitle:@"" forState:UIControlStateNormal];
    
    self.indicatorType = self.indicatorType?:UIActivityIndicatorViewStyleWhite;
    self.indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.indicatorType];
    [self addSubview:self.indicatorView];
    
    self.indicatorSpace = self.indicatorSpace?:5;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    CGFloat sp = w / 2.;
    if (![title isEqualToString:@""]) {
        self.indicatorLabel = [[UILabel alloc] init];
        self.indicatorLabel.text = title;
        self.indicatorLabel.font = self.titleLabel.font;
        self.indicatorLabel.textColor = self.titleLabel.textColor;
        [self addSubview:self.indicatorLabel];
        
        CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT,0.0)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{NSFontAttributeName:self.titleLabel.font}
                                          context:nil].size;
        sp = ((w - self.indicatorSpace - size.width) * .5) ?: 0.0;
        self.indicatorLabel.frame = CGRectMake(sp + self.indicatorSpace + self.indicatorView.frame.size.width/2, 0, size.width, h);
    }
    
    self.indicatorView.center = CGPointMake(sp, h/2);
    [self.indicatorView startAnimating];
}

- (void)kj_endSubmitting {
    [self kj_hideIndicator];
    self.indicatorView = nil;
    self.indicatorLabel = nil;
}

- (void)kj_showIndicator {
    if (self.indicatorView && self.indicatorView.superview == nil) {
        [self addSubview:self.indicatorView];
        [self.indicatorView startAnimating];
    }
    if (self.indicatorLabel && self.indicatorLabel.superview == nil) {
        [self addSubview:self.indicatorLabel];
        [self setTitle:@"" forState:UIControlStateNormal];
    }
}

- (void)kj_hideIndicator {
    kSubmitting = false;
    self.enabled = YES;
    
    [self.indicatorView removeFromSuperview];
    [self.indicatorLabel removeFromSuperview];
    
    if (self.indicatorLabel) {
        [self setTitle:kIndicatorLastTitle forState:UIControlStateNormal];
    }
    if (self.indicatorView) {
        [self.indicatorView stopAnimating];
        [self setTitle:kIndicatorLastTitle forState:UIControlStateNormal];
    }
}

#pragma mark - associated
static bool kSubmitting = false;
- (bool)submitting{
    return kSubmitting;
}
- (CGFloat)indicatorSpace{
    return [objc_getAssociatedObject(self, @selector(indicatorSpace)) floatValue];
}
- (void)setIndicatorSpace:(CGFloat)indicatorSpace{
    objc_setAssociatedObject(self, @selector(indicatorSpace), @(indicatorSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIActivityIndicatorViewStyle)indicatorType{
    return (UIActivityIndicatorViewStyle)[objc_getAssociatedObject(self, @selector(indicatorType)) intValue];
}
- (void)setIndicatorType:(UIActivityIndicatorViewStyle)indicatorType{
    objc_setAssociatedObject(self, @selector(indicatorType), @(indicatorType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIActivityIndicatorView*)indicatorView{
    return objc_getAssociatedObject(self, @selector(indicatorView));
}
- (void)setIndicatorView:(UIActivityIndicatorView*)indicatorView{
    objc_setAssociatedObject(self, @selector(indicatorView), indicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UILabel *)indicatorLabel{
    return objc_getAssociatedObject(self, @selector(indicatorLabel));
}
- (void)setIndicatorLabel:(UILabel *)indicatorLabel{
    objc_setAssociatedObject(self, @selector(indicatorLabel), indicatorLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
