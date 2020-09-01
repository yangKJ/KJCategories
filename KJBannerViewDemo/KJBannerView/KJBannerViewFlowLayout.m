//
//  KJBannerViewFlowLayout.m
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/28.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBannerViewFlowLayout.h"

@implementation KJBannerViewFlowLayout
/** 多次调用 只要滑出范围就会 调用
 *  当CollectionView的显示范围发生改变的时候，是否重新发生布局
 *  一旦重新刷新 布局，就会重新调用
 *  1.layoutAttributesForElementsInRect：方法
 *  2.preparelayout方法
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds{
    return YES;
}
/** 重写方法
 *  此方法会计算并返回每个item的位置和大小，换句话说就是collectionView里面的布局是怎样布局的就根这个方法的返回值有关
 *  此方法会先计算一定数量的数据，当你继续滚动需要一些新数据时会再次来计算新的数据
 *  只要在这里有过返回的数据都会缓存起来，下次再滚回来不会再帮你计算新数据
 *  1.返回rect中的所有的元素的布局属性
 *  2.返回的是包含UICollectionViewLayoutAttributes的NSArray
 *  3.UICollectionViewLayoutAttributes可以是cell，追加视图或装饰视图的信息
 */
- (NSArray<UICollectionViewLayoutAttributes*>*)layoutAttributesForElementsInRect:(CGRect)rect{
    // 1.获取cell对应的attributes对象
    NSArray *temps = [[NSArray alloc] initWithArray:[super layoutAttributesForElementsInRect:rect] copyItems:YES];
    if(self.isZoom == NO) return temps;
    // 2.计算整体的中心点的x值
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width * 0.5;
    // 3.修改一下attributes对象
    for (UICollectionViewLayoutAttributes *attributes in temps) {
        // 计算每个cell的中心点距离
        CGFloat centerDistance = ABS(attributes.center.x - centerX);
        // 距离越大，缩放比越小，距离越小，缩放比越大
        CGFloat scale = 1.0 / (1 + centerDistance * 0.001);
        attributes.transform = CGAffineTransformMakeScale(scale, scale);
    }
    return temps;
}
/// 在CollectionView的第一次布局的时候被调用
- (void)prepareLayout{
    [super prepareLayout];
}

@end
