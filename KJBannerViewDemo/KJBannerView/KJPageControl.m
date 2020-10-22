//
//  KJPageControl.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/5/27.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJPageControl.h"

@interface LoopPageView : UIView

@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, strong) UIColor *normalColor;
@property (nonatomic, strong) UIColor *selectColor;
/// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame Margin:(CGFloat)margin NormalWidth:(CGFloat)normalw SelectWidth:(CGFloat)selectw Height:(CGFloat)height;

@property (nonatomic, strong) NSMutableArray *temps;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, assign) CGFloat margin;
@property (nonatomic, assign) CGFloat normalWidth;
@property (nonatomic, assign) CGFloat selectWidth;
@property (nonatomic, assign) CGFloat Height;

@end

@implementation LoopPageView
- (instancetype)initWithFrame:(CGRect)frame Margin:(CGFloat)margin NormalWidth:(CGFloat)normalw SelectWidth:(CGFloat)selectw Height:(CGFloat)height{
    if (self = [super initWithFrame:frame]) {
        _temps = [NSMutableArray array];
        _backView = [[UIView alloc] initWithFrame:frame];
        [self addSubview:_backView];
        _pages = _currentPage = 0;
        _normalWidth = normalw; //普通宽度
        _margin = margin; //间距
        _selectWidth = selectw;// 当前 宽度
        _Height = height;
    }
    return self;
}

- (void)setCurrentPage:(NSInteger)currentPage{
    if (_currentPage == currentPage) return;
    _currentPage = MIN(currentPage, _pages - 1);
    CGFloat viewX = 0;
    for (NSInteger i = 0; i < _pages; i++) {
        UIView * view = self.temps[i];
        if (i == _currentPage) {
            view.frame = CGRectMake(viewX, 0, _selectWidth, _Height);
            viewX += _selectWidth + _margin;
            view.backgroundColor = _selectColor;
        }else {
            view.frame = CGRectMake(viewX, 0, _normalWidth, _Height);
            viewX += _normalWidth + _margin;
            view.backgroundColor = _normalColor;
        }
    }
}

- (void)setPages:(NSInteger)pages{
    pages = MAX(0, pages);
    if (_pages != pages) {
        _pages = pages;
        [self.backView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview) withObject:self];
        [self.temps removeAllObjects];
        CGFloat width = _selectWidth + (pages-1)*_normalWidth + (pages-1)*_margin;
        self.backView.frame = CGRectMake(0, 0, width, _Height);
        self.backView.center = CGPointMake(CGRectGetWidth(self.frame)/2, _Height-2);
        CGFloat x = 0;
        for (NSInteger i = 0; i < pages; i++) {
            UIView *view = [UIView new];
            if (i == _currentPage) {
                view.frame = CGRectMake(x, 0, _selectWidth, _Height);
                view.backgroundColor = _selectColor;
                x += _selectWidth + _margin;
            }else{
                view.frame = CGRectMake(x, 0, _normalWidth, _Height);
                view.backgroundColor = _normalColor;
                x += _normalWidth + _margin;
            }
            view.layer.cornerRadius = _Height*.5;
            view.layer.masksToBounds = YES;
            [self.backView addSubview:view];
            [self.temps addObject:view];
        }
    }
}

@end


@interface KJPageControl ()
@property(nonatomic,strong) LoopPageView *loopPageView;
@end

@implementation KJPageControl

/// 设置PageView
- (void)setTotalPages:(NSInteger)totalPages{
    _totalPages = totalPages;
    
    if (_pageType == PageControlStyleSizeDot) {
        self.loopPageView.pages = totalPages;
        return;
    }
    
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat margin = 8; /// 间隙
    CGFloat width = self.frame.size.width - (_totalPages - 1) * margin;
    /// 修改page的中心位置
    self.center = CGPointMake(width, self.center.y);
    CGFloat pointWidth = width / _totalPages;
    pointWidth = pointWidth > self.frame.size.height / 2 ? self.frame.size.height / 2 : pointWidth;
    
    for (int i = 0; i < _totalPages; i++) {
        UIView *aview = [UIView new];
        aview.backgroundColor = i == _currentIndex ? _selectColor : _normalColor;
        switch (_pageType) {
            case PageControlStyleCircle:
                aview.frame = CGRectMake((margin * 2 / 3 + pointWidth) * i, 0, pointWidth, pointWidth);
                aview.layer.cornerRadius = pointWidth / 2;
                aview.layer.masksToBounds = YES;
                break;
            case PageControlStyleSquare:
                aview.frame = CGRectMake((margin * 2 / 3 + pointWidth) * i, 0, pointWidth*.8, pointWidth*.8);
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

/// 当前的currentPage
- (void)setCurrentIndex:(NSInteger)currentIndex{
    if (_pageType == PageControlStyleSizeDot) {
        self.loopPageView.currentPage = currentIndex;
        return;
    }
    if (_currentIndex != currentIndex) {
        _currentIndex = MIN(currentIndex, _totalPages - 1);
        /// 遍历修改颜色
        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            obj.backgroundColor = idx == currentIndex ? self.selectColor : self.normalColor;
        }];
    }
}

#pragma mark - lazy
- (LoopPageView*)loopPageView{
    if (!_loopPageView) {
        _loopPageView = [[LoopPageView alloc] initWithFrame:self.bounds Margin:5.f NormalWidth:5.f SelectWidth:14.f Height:5];
        _loopPageView.normalColor = _normalColor;
        _loopPageView.selectColor = _selectColor;
        [self addSubview:_loopPageView];
    }
    return _loopPageView;
}

@end

