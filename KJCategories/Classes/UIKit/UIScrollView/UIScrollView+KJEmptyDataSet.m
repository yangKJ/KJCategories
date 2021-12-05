//
//  UIScrollView+KJEmptyDataSet.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/18.
//  https://github.com/YangKJ/KJCategories

#import "UIScrollView+KJEmptyDataSet.h"
#import <objc/runtime.h>

#if __has_include(<DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>)

@implementation UIScrollView (KJEmptyDataSet)

- (BOOL)loading{
    return [objc_getAssociatedObject(self,@selector(loading)) boolValue];
}
- (void)setLoading:(BOOL)loading{
    if (self.loading == loading) return;
    objc_setAssociatedObject(self, @selector(loading), [NSNumber numberWithBool:loading], OBJC_ASSOCIATION_ASSIGN);
    self.emptyDataSetSource = self;
    self.emptyDataSetDelegate = self;
    if ([self isKindOfClass:[UITableView class]]) {
        ((UITableView*)self).tableFooterView = [UIView new];/// 解决没有数据也显示Cell
    }
}
- (CGFloat)verticalOffset{
    return [objc_getAssociatedObject(self, @selector(verticalOffset)) floatValue];
}
- (void)setVerticalOffset:(CGFloat)verticalOffset{
    objc_setAssociatedObject(self, @selector(verticalOffset), @(verticalOffset), OBJC_ASSOCIATION_ASSIGN);
}
- (NSString *)loadedImageName{
    NSString *name = objc_getAssociatedObject(self, @selector(loadedImageName));
    if ([name isEqualToString:@""] || name == nil) {
        name = @"KJKit.bundle/scroll_empty_data";
    }
    return name;
}
- (void)setLoadedImageName:(NSString *)loadedImageName{
    objc_setAssociatedObject(self, @selector(loadedImageName), loadedImageName, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSAttributedString*)descriptionText{
    NSAttributedString *string = objc_getAssociatedObject(self, @selector(descriptionText));
    if (string == nil) {
        NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
        paragraph.lineBreakMode = NSLineBreakByWordWrapping;
        paragraph.alignment = NSTextAlignmentCenter;
        NSDictionary *attributes = @{
            NSFontAttributeName:[UIFont systemFontOfSize:14.0f],
            NSForegroundColorAttributeName:[UIColor lightGrayColor],
            NSParagraphStyleAttributeName:paragraph
        };
        string = [[NSAttributedString alloc] initWithString:@"没有数据,您可以尝试重新获取" attributes:attributes];
    }
    return string;
}
- (void)setDescriptionText:(NSAttributedString*)descriptionText{
    objc_setAssociatedObject(self, @selector(descriptionText), descriptionText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSAttributedString * _Nullable (^)(UIControlState))kLoadedButton{
    NSAttributedString * _Nullable (^block)(UIControlState) = objc_getAssociatedObject(self, _cmd);
    if (block == nil) {
        block = ^NSAttributedString * _Nullable (UIControlState state) {
            return [[NSAttributedString alloc] initWithString:@"再次刷新" attributes:nil];
        };
    }
    return block;
}
- (void)setKLoadedButton:(NSAttributedString * _Nullable (^)(UIControlState))kLoadedButton{
    objc_setAssociatedObject(self, @selector(kLoadedButton), kLoadedButton, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (UIView * _Nullable (^)(void))kLoadingContentView{
    UIView * _Nullable (^block)(void) = objc_getAssociatedObject(self, @selector(kLoadingContentView));
    if (block == nil) {
        __weak __typeof(self) weakself = self;
        block = ^UIView * _Nullable{
            UIActivityIndicatorView *activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [activityView startAnimating];
            activityView.backgroundColor = weakself.backgroundColor;
            return activityView;
        };
    }
    return block;
}
- (void)setKLoadingContentView:(UIView * _Nullable (^)(void))kLoadingContentView{
    objc_setAssociatedObject(self, @selector(kLoadingContentView), kLoadingContentView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (bool (^)(UIButton *))kLoadedButtonClick{
    return objc_getAssociatedObject(self, @selector(kLoadedButtonClick));
}
- (void)setKLoadedButtonClick:(bool (^)(UIButton *))kLoadedButtonClick{
    objc_setAssociatedObject(self, @selector(kLoadedButtonClick), kLoadedButtonClick, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void(^)(void))kLoadedOtherViewClick{
    return objc_getAssociatedObject(self, @selector(kLoadedOtherViewClick));
}
- (void)setKLoadedOtherViewClick:(void(^)(void))kLoadedOtherViewClick{
    objc_setAssociatedObject(self, @selector(kLoadedOtherViewClick), kLoadedOtherViewClick, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - DZNEmptyDataSetSource

- (UIView *)customViewForEmptyDataSet:(UIScrollView*)scrollView{
    if (self.loading) {
        if (self.kLoadingContentView) return self.kLoadingContentView();
    }
    return nil;
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView*)scrollView{
    if (self.loading) {
        if (self.kLoadingContentView) return self.kLoadingContentView().backgroundColor;
    }
    return nil;
}
- (UIImage *)imageForEmptyDataSet:(UIScrollView*)scrollView{
    if (self.loading) {
        return nil;
    } else {
        return [UIImage imageNamed:self.loadedImageName];
    }
}
- (NSAttributedString*)descriptionForEmptyDataSet:(UIScrollView*)scrollView{
    if (self.loading) {
        return nil;
    } else {
        return self.descriptionText;
    }
}
- (NSAttributedString*)buttonTitleForEmptyDataSet:(UIScrollView*)scrollView forState:(UIControlState)state{
    if (self.loading == NO) {
        if (self.kLoadedButton) return self.kLoadedButton(state);
    }
    return nil;
}
- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView*)scrollView{
    return self.verticalOffset;
}

#pragma mark - DZNEmptyDataSetDelegate

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView*)scrollView{
    return !self.loading;
}
- (void)emptyDataSet:(UIScrollView*)scrollView didTapButton:(UIButton *)button{
    if (self.kLoadedButtonClick && self.kLoadedButtonClick(button)) {
        [self reloadEmptyDataSet];
    }
}
- (void)emptyDataSet:(UIScrollView*)scrollView didTapView:(UIView *)view{
    if (self.kLoadedOtherViewClick) {
        self.kLoadedOtherViewClick();
        [self reloadEmptyDataSet];
    }
}

@end

#endif
