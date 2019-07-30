//
//  KJBannerView.m
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/27.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBannerView.h"
#import "KJBannerViewCell.h"
#import "KJBannerViewFlowLayout.h"

@interface KJBannerView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) KJBannerViewFlowLayout *FlowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSUInteger temps; // 总数
@property (nonatomic,assign) NSUInteger dragDirection;//
@property (nonatomic,assign) NSUInteger oldPoint;//
@property (nonatomic,strong) NSTimer *timer;
/// 是否自定义Cell, 默认no
@property (nonatomic,assign) BOOL isCustomCell;

@end

@implementation KJBannerView

#pragma mark  - config
- (void)kConfig{
    /// 初始化 - 设置默认参数
    _infiniteLoop = YES;
    _autoScroll = YES;
    _isZoom = NO;
    _itemWidth = self.bounds.size.width;
    _itemSpace = 0;
    _imgCornerRadius = 0;
    _autoScrollTimeInterval = 2;
    _imgCornerRadius = 0;
    _bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _isCustomCell = NO;
    _rollType = KJBannerViewRollDirectionTypeRightToLeft;
    _imageType = KJBannerViewImageTypeNetIamge;
    _cellPlaceholderImage = [UIImage imageNamed:@"KJBannerView.bundle/KJBannerPlaceholderImage"];
    self.itemClass = [KJBannerViewCell class];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self kConfig];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
    }
    return self;
}

#pragma mark  - setter or getter
- (void)setItemClass:(Class)itemClass{
    _itemClass = itemClass;
    if (![NSStringFromClass(itemClass) isEqualToString:@"KJBannerViewCell"]) {
        _isCustomCell = YES;
    }
    /// 注册cell
    [self.collectionView registerClass:_itemClass forCellWithReuseIdentifier:@"KJBannerViewCell"];
}
- (void)setItemWidth:(CGFloat)itemWidth{
    _itemWidth = itemWidth;
    self.FlowLayout.itemSize = CGSizeMake(itemWidth, self.bounds.size.height);
}
- (void)setItemSpace:(CGFloat)itemSpace{
    _itemSpace = itemSpace;
    self.FlowLayout.minimumLineSpacing = itemSpace;
}
- (void)setIsZoom:(BOOL)isZoom{
    _isZoom = isZoom;
    self.FlowLayout.isZoom = isZoom;
}
- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    //创建之前，停止定时器
    [self invalidateTimer];
    if (_autoScroll) {
        [self setupTimer];
    }
}
- (void)setImageDatas:(NSArray *)imageDatas{
    _imageDatas = imageDatas;
    [[KJBannerTool sharedInstance].imageTemps removeAllObjects];
    self.pageControl.totalPages = _imageDatas.count;
    /// 如果循环则50倍,让之看着像无限循环一样
    _temps = self.infiniteLoop ? _imageDatas.count * 50 : _imageDatas.count;
    if(_imageDatas.count > 1){
        self.pageControl.hidden = NO;
        self.collectionView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
    }else{
        //不循环
        self.pageControl.hidden = YES;
        self.collectionView.scrollEnabled = NO;
        [self invalidateTimer];
    }
    
    /// 刷新数据
    [self.collectionView reloadData];
    /// 设置滚动item在最中间位置
    [self kSetCollectionItemIndexPlace];
}

#pragma mark  - private
/// 设置初始滚动位置
- (void)kSetCollectionItemIndexPlace{
    self.collectionView.frame = self.bounds;
    self.FlowLayout.itemSize = CGSizeMake(_itemWidth, self.bounds.size.height);
    self.FlowLayout.minimumLineSpacing = self.itemSpace;
    if(self.collectionView.contentOffset.x == 0 && _temps > 0) {
        NSInteger targeIndex = 0;
        if(self.infiniteLoop){
            // 无线循环
            // 如果是无限循环, 应该默认把 collection 的 item 滑动到 中间位置
            // 乘以 0.5, 正好是取得中间位置的 item, 图片也恰好是图片数组里面的第 0 个
            targeIndex = _temps * 0.5;
        }else{
            targeIndex = 0;
        }
        /// 设置图片默认位置
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targeIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.oldPoint = self.collectionView.contentOffset.x;
        self.collectionView.userInteractionEnabled = YES;
    }
}
/// 释放计时器
- (void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}
/// 开启计时器
- (void)setupTimer{
    [self invalidateTimer]; // 创建定时器前先停止定时器,不然会出现僵尸定时器,导致轮播频率错误
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticScroll) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    _timer = timer;
}
/// 自动滚动
- (void)automaticScroll{
    if(_temps == 0) return;
    NSInteger currentIndex = [self currentIndex];
    NSInteger targetIndex;
    /// 滚动方向设定
    if (_rollType == KJBannerViewRollDirectionTypeRightToLeft) {
        targetIndex = currentIndex + 1;
    }else{
        if (currentIndex == 0) {
            currentIndex = _temps;
        }
        targetIndex = currentIndex - 1;
    }
    [self scrollToIndex:targetIndex];
}
/// 当前位置
- (NSInteger)currentIndex{
    if(self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) return 0;
    NSInteger index = 0;
    if (_FlowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {//水平滑动
        index = (self.collectionView.contentOffset.x + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    }else{
        index = (self.collectionView.contentOffset.y + _FlowLayout.itemSize.height * 0.5) / _FlowLayout.itemSize.height;
    }
    return MAX(0,index);
}
/// 滚动到指定位置
- (void)scrollToIndex:(NSInteger)index{
    if(index >= _temps){ //滑到最后则调到中间
        if(self.infiniteLoop){
            index = _temps * 0.5;
            [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        }
        return;
    }
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    /// 滑动时关闭交互
    self.collectionView.userInteractionEnabled = NO;
    if (!self.imageDatas.count) return; // 解决清除timer时偶尔会出现的问题
    self.pageControl.currentIndex = [self currentIndex] % self.imageDatas.count;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _oldPoint = scrollView.contentOffset.x;
    if (self.autoScroll) return [self invalidateTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (self.autoScroll) return [self setupTimer];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    [self scrollViewDidEndScrollingAnimation:self.collectionView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    self.collectionView.userInteractionEnabled = YES;
    if (!self.imageDatas.count) return; // 解决清除timer时偶尔会出现的问题
}

/// 手离开屏幕的时候
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    /// 如果是向右滑或者滑动距离大于item的一半,则像右移动一个item+space的距离,反之向左
    float currentPoint = scrollView.contentOffset.x;
    float moveWidth = currentPoint - _oldPoint;
    int shouldPage = moveWidth/(self.itemWidth/2);
    if (velocity.x > 0 || shouldPage > 0) {
        _dragDirection = 1;
    }else if (velocity.x < 0 || shouldPage < 0){
        _dragDirection = -1;
    }else{
        _dragDirection = 0;
    }
    self.collectionView.userInteractionEnabled = NO;
    NSInteger currentIndex = (_oldPoint + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex + _dragDirection inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)scrollViewWillBeginDecelerating: (UIScrollView *)scrollView{
    /// 松开手指滑动开始减速的时候,设置滑动动画
    NSInteger currentIndex = (_oldPoint + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:currentIndex + _dragDirection inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark  - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.temps;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KJBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KJBannerViewCell" forIndexPath:indexPath];
    long itemIndex = (int)indexPath.item % self.imageDatas.count;
    if (_isCustomCell) {
        cell.model = self.imageDatas[itemIndex];
    }else{
        cell.imgCornerRadius = self.imgCornerRadius;
        cell.placeholderImage = self.cellPlaceholderImage;
        cell.contentMode = self.bannerImageViewContentMode;
        cell.imageType = self.imageType;
        cell.imageUrl = self.imageDatas[itemIndex];
    }
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger idx = [self currentIndex] % self.imageDatas.count;
    if ([self.delegate respondsToSelector:@selector(kj_BannerView:SelectIndex:)]) {
        [self.delegate kj_BannerView:self SelectIndex:idx];
    }
    !self.kSelectBlock?:self.kSelectBlock(self,idx);
}

#pragma mark - lazy
- (UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.FlowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollsToTop = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = self.backgroundColor;
    }
    return _collectionView;
}
- (KJPageControl *)pageControl{
    if(!_pageControl){
        _pageControl = [[KJPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - 15, self.bounds.size.width, 15)];
        // 默认设置
        _pageControl.pageType = PageControlStyleRectangle;
        _pageControl.normalColor = UIColor.lightGrayColor;
        _pageControl.selectColor = UIColor.whiteColor;
        _pageControl.currentIndex = 0;//[self currentIndex];
    }
    return _pageControl;
}
- (KJBannerViewFlowLayout *)FlowLayout{
    if(!_FlowLayout){
        _FlowLayout = [[KJBannerViewFlowLayout alloc]init];
        _FlowLayout.isZoom = self.isZoom;
        _FlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _FlowLayout.minimumLineSpacing = 0;
    }
    return _FlowLayout;
}

@end


