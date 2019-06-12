//
//  KJBannerViewFlowLayout.m
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/28.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBannerViewFlowLayout.h"

@implementation KJBannerViewFlowLayout
/// 重写方法
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    /*
     1.返回rect中的所有的元素的布局属性
     2.返回的是包含UICollectionViewLayoutAttributes的NSArray
     3.UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息
    */
    // 1.获取cell对应的attributes对象
    NSArray* arrayAttrs = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    if(!self.isZoom) return arrayAttrs;

    // 2.计算整体的中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    
    // 3.修改一下attributes对象
    for (UICollectionViewLayoutAttributes *attr in arrayAttrs) {
        // 3.1 计算每个cell的中心点距离
        CGFloat distance = ABS(attr.center.x - centerX);
        // 3.2 距离越大，缩放比越小，距离越小，缩放比越大
        CGFloat factor = 0.001;
        CGFloat scale = 1.0 / (1 + distance * factor);
        attr.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return arrayAttrs;
}

/*!
 *  多次调用 只要滑出范围就会 调用
 *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
 *  一旦重新刷新 布局，就会重新调用
 *  1.layoutAttributesForElementsInRect：方法
 *  2.preparelayout方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
