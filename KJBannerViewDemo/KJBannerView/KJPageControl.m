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
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 默认设置
        _kBackPageColor = UIColor.lightGrayColor;
        _kSelectedColor = UIColor.whiteColor;
        _kCurrentPage = 0;
        _kPageType = PageControlStyleRectangle;
    }
    return self;
}
/// 设置PageView
- (void)setKNumberPages:(NSInteger)kNumberPages{
    if (_kNumberPages != kNumberPages) {
        _kNumberPages = kNumberPages;
        CGFloat margin = 8; /// 间隙
        CGFloat width = self.frame.size.width - (_kNumberPages - 1)*margin;
        /// 修改page的中心位置
        self.center = CGPointMake(width, self.center.y);
        CGFloat pointWidth = width / _kNumberPages;
        pointWidth = pointWidth > self.frame.size.height / 2 ? self.frame.size.height / 2 : pointWidth;
        
        for (int i = 0; i < _kNumberPages; i++) {
            UIView *aview = [UIView new];
            aview.backgroundColor = _kBackPageColor;
            switch (_kPageType) {
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
            
            /** 设置cuurrentPag */
            if (i == _kCurrentPage) {
                aview.backgroundColor = _kSelectedColor;
            }
        }
    }
}

/// 当前的currentPage
- (void)setKCurrentPage:(NSInteger)kCurrentPage{
    if (_kCurrentPage != kCurrentPage) {
        _kCurrentPage = kCurrentPage;
        for (NSInteger i = 0; i<self.subviews.count; i++) {
            UIView *view = self.subviews[i];
            if (i == _kCurrentPage) {
                view.backgroundColor = _kSelectedColor;
            }else{
                view.backgroundColor = _kBackPageColor;
            }
        }
    }
}

@end
