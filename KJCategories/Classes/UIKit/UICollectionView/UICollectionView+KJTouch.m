//
//  UICollectionView+KJTouch.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/9/18.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "UICollectionView+KJTouch.h"
#import <objc/runtime.h>

@implementation UICollectionView (Touch)
- (bool)openExchange{
    return [objc_getAssociatedObject(self,@selector(openExchange)) boolValue];
}
- (void)setOpenExchange:(bool)openExchange{
    objc_setAssociatedObject(self,@selector(openExchange),[NSNumber numberWithBool:openExchange],OBJC_ASSOCIATION_ASSIGN);
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [UICollectionView kj_collectionViewSwizzleMethod:@selector(touchesBegan:withEvent:) Method:@selector(kj_touchesBegan:withEvent:)];
        [UICollectionView kj_collectionViewSwizzleMethod:@selector(touchesMoved:withEvent:) Method:@selector(kj_touchesMoved:withEvent:)];
        [UICollectionView kj_collectionViewSwizzleMethod:@selector(touchesEnded:withEvent:) Method:@selector(kj_touchesEnded:withEvent:)];
        [UICollectionView kj_collectionViewSwizzleMethod:@selector(touchesCancelled:withEvent:) Method:@selector(kj_touchesCancelled:withEvent:)];
    });
}
- (void(^)(KJMoveStateType state,CGPoint point))moveblock{
    return objc_getAssociatedObject(self, _cmd);
}
- (void)setMoveblock:(void(^)(KJMoveStateType state,CGPoint point))moveblock{
    objc_setAssociatedObject(self, @selector(moveblock), moveblock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (void)kj_touchesBegan:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event{
    if (self.openExchange && self.moveblock) {
        CGPoint point = [[touches anyObject] locationInView:self];
        self.moveblock(KJMoveStateTypeBegin,point);
    }
    [self kj_touchesBegan:touches withEvent:event];
}
- (void)kj_touchesMoved:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event{
    if (self.openExchange && self.moveblock) {
        CGPoint point = [[touches anyObject] locationInView:self];
        self.moveblock(KJMoveStateTypeMove,point);
    }
    [self kj_touchesMoved:touches withEvent:event];
}
- (void)kj_touchesEnded:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event{
    if (self.openExchange && self.moveblock) {
        CGPoint point = [[touches anyObject] locationInView:self];
        self.moveblock(KJMoveStateTypeEnd,point);
    }
    [self kj_touchesEnded:touches withEvent:event];
}
- (void)kj_touchesCancelled:(NSSet<UITouch*>*)touches withEvent:(UIEvent*)event{
    if (self.openExchange && self.moveblock) {
        CGPoint point = [[touches anyObject] locationInView:self];
        self.moveblock(KJMoveStateTypeCancelled,point);
    }
    [self kj_touchesEnded:touches withEvent:event];
}


#pragma mark - swizzling
+ (BOOL)kj_collectionViewSwizzleMethod:(SEL)origSel Method:(SEL)altSel{
    Method origMethod = class_getInstanceMethod(self, origSel);
    Method altMethod  = class_getInstanceMethod(self, altSel);
    if (!origMethod || !altMethod) return NO;
    class_addMethod(self, origSel, class_getMethodImplementation(self, origSel), method_getTypeEncoding(origMethod));
    class_addMethod(self, altSel, class_getMethodImplementation(self, altSel), method_getTypeEncoding(altMethod));
    method_exchangeImplementations(class_getInstanceMethod(self, origSel), class_getInstanceMethod(self, altSel));
    return YES;
}

@end
