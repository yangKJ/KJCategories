//
//  KJPageControl.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/5/27.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJPageControl.h"

@interface KJPageControl ()

@end

@implementation KJPageControl

/// 设置PageView
- (void)setTotalPages:(NSInteger)totalPages{
    if (_totalPages != totalPages) {
        _totalPages = totalPages;
        CGFloat margin = 8; /// 间隙
        CGFloat width = self.frame.size.width - (_totalPages - 1)*margin;
        /// 修改page的中心位置
        self.center = CGPointMake(width, self.center.y);
        CGFloat pointWidth = width / _totalPages;
        pointWidth = pointWidth > self.frame.size.height / 2 ? self.frame.size.height / 2 : pointWidth;
        
        for (int i = 0; i < _totalPages; i++) {
            UIView *aview = [UIView new];
            aview.backgroundColor = i == _currentIndex ? _selectColor : _normalColor;
            switch (_pageType) {
                case PageControlStyleCircle:
                    aview.frame = CGRectMake((margin*2/3 + pointWidth) * i, 0, pointWidth, pointWidth);
                    aview.layer.cornerRadius = pointWidth / 2 ;
                    aview.layer.masksToBounds = YES;
                    break;
                case PageControlStyleSquare:
                    aview.frame = CGRectMake((margin + pointWidth) * i, 0, pointWidth, pointWidth);
                    break;
                case PageControlStyleRectangle:
                    aview.frame = CGRectMake((margin + pointWidth) * i, 0, pointWidth*1.5, pointWidth/4.0);
                    break;
                default:
                    break;
            }
            [self addSubview:aview];
        }
    }
}

/// 当前的currentPage
- (void)setCurrentIndex:(NSInteger)currentIndex{
    if (_currentIndex != currentIndex) {    
        _currentIndex = currentIndex;
        /// 遍历修改颜色
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.backgroundColor = idx == currentIndex ? self.selectColor : self.normalColor;
        }];
    }
}

@end
