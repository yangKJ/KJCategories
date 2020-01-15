//
//  KJBannerView.m
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/27.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBannerView.h"
#import "KJBannerViewFlowLayout.h"
#import <objc/runtime.h>

@interface KJBannerView()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) KJBannerViewFlowLayout *layout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,assign) NSUInteger nums; // 总数
@property (nonatomic,assign) NSUInteger dragIndex;//
@property (nonatomic,assign) NSUInteger lastX;// 上次的X
@property (nonatomic,strong) NSTimer *timer;
/** 分页控制器 */
@property (nonatomic,strong) KJPageControl *pageControl;
/// 是否自定义Cell, 默认no
@property (nonatomic,assign) BOOL useCustomCell;
/// 是否使用KJBannerViewDataSource委托方式
@property (nonatomic,assign) BOOL useDataSource;

@end

@implementation KJBannerView

#pragma mark - config
- (void)kConfig{
    /// 初始化 - 设置默认参数
    _infiniteLoop = YES;
    _autoScroll = YES;
    _isZoom = NO;
    _itemWidth = self.bounds.size.width;
    _itemSpace = 0;
    _imgCornerRadius = 0;
    _autoScrollTimeInterval = 2;
    _bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
    _rollType = KJBannerViewRollDirectionTypeRightToLeft;
    _imageType = KJBannerViewImageTypeNetIamge;
    _placeholderImage = [UIImage imageNamed:@"KJBannerView.bundle/KJBannerPlaceholderImage"];
    _useCustomCell = NO;
    _kj_scale = NO;
    _useDataSource = NO;
    self.itemClass = [KJBannerViewCell class];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self kConfig];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self kConfig];
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
    }
    return self;
}
/// 暂停计时器滚动处理
- (void)kj_pauseTimer{
    if (_timer) {
        [_timer setFireDate:[NSDate distantFuture]];
    }
}
/// 继续计时器滚动
- (void)kj_repauseTimer{
    if (_timer) {
        [_timer setFireDate:[NSDate date]];
    }
}
#pragma mark - setter/getter
- (void)setDelegate:(id<KJBannerViewDelegate>)delegate{
    _delegate = delegate;
    if ([delegate respondsToSelector:@selector(kj_BannerView:CurrentIndex:)]) {
        BOOL close = [delegate kj_BannerView:self CurrentIndex:0];
        if (close) [self.pageControl removeFromSuperview];
    }
}
- (void)setDataSource:(id<KJBannerViewDataSource>)dataSource{
    _dataSource = dataSource;
    self.useDataSource = YES;
}
- (void)setImageDatas:(NSArray *)imageDatas{
    _imageDatas = imageDatas;
    if (self.useCustomCell == NO && self.useDataSource == NO) {
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            NSMutableArray *temp = [NSMutableArray array];
            for (NSString *string in imageDatas) {
                KJBannerDatasInfo *info = [[KJBannerDatasInfo alloc]init];
                info.superType = weakself.imageType;
                info.imageUrl = string;
                [temp addObject:info];
            }
            [KJBannerTool sharedInstance].imageTemps = temp.mutableCopy;
            temp = nil;
            dispatch_async(dispatch_get_main_queue(), ^{            
                [weakself kj_dealImageDatas:imageDatas];
            });
        });
    }else{
        [self kj_dealImageDatas:imageDatas];
    }
}

- (void)kj_dealImageDatas:(NSArray*)imageDatas{
    if(imageDatas.count > 1){
        /// 如果循环则50倍,让之看着像无限循环一样
        _nums = self.infiniteLoop ? imageDatas.count * 10000 : imageDatas.count;
        self.pageControl.hidden = NO;
        self.collectionView.scrollEnabled = YES;
        [self setAutoScroll:self.autoScroll];
        self.pageControl.totalPages = imageDatas.count;
    }else{
        //不循环
        _nums = 1;
        self.pageControl.hidden = YES;
        self.collectionView.scrollEnabled = NO;
        [self invalidateTimer];
    }
    /// 刷新数据
    [self.collectionView reloadData];
    /// 设置滚动item在最中间位置
    [self kSetCollectionItemIndexPlace];
}

- (void)setItemClass:(Class)itemClass{
    _itemClass = itemClass;
    if (![NSStringFromClass(itemClass) isEqualToString:@"KJBannerViewCell"]) {
        _useCustomCell = YES;
    }
    /// 注册cell
    [self.collectionView registerClass:_itemClass forCellWithReuseIdentifier:@"KJBannerViewCell"];
}
- (void)setItemWidth:(CGFloat)itemWidth{
    _itemWidth = itemWidth;
    self.layout.itemSize = CGSizeMake(itemWidth, self.bounds.size.height);
}
- (void)setItemSpace:(CGFloat)itemSpace{
    _itemSpace = itemSpace;
    self.layout.minimumLineSpacing = itemSpace;
}
- (void)setIsZoom:(BOOL)isZoom{
    _isZoom = isZoom;
    self.layout.isZoom = isZoom;
}
- (void)setAutoScroll:(BOOL)autoScroll{
    _autoScroll = autoScroll;
    //创建之前，停止定时器
    [self invalidateTimer];
    if (_autoScroll) [self setupTimer];
}

#pragma mark - private
/// 设置初始滚动位置
- (void)kSetCollectionItemIndexPlace{
    self.collectionView.frame = self.bounds;
    self.layout.itemSize = CGSizeMake(self.itemWidth, self.bounds.size.height);
    self.layout.minimumLineSpacing = self.itemSpace;
    if(self.collectionView.contentOffset.x == 0 && _nums > 0) {
        // 如果是无限循环, 应该默认把 collection 的 item 滑动到 中间位置
        // 乘以 0.5, 正好是取得中间位置的 item, 图片也恰好是图片数组里面的第 0 个
        NSInteger targeIndex = self.infiniteLoop ? _nums * 0.5 : 0;
        /// 设置图片默认位置
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:targeIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
        self.lastX = self.collectionView.contentOffset.x;
        self.collectionView.userInteractionEnabled = YES;
    }
}
- (void)willMoveToSuperview:(UIView *)newSuperview{
    [super willMoveToSuperview:newSuperview];
    [self invalidateTimer];
}
/// 释放计时器
- (void)invalidateTimer{
    [_timer invalidate];
    _timer = nil;
}
/// 开启计时器
- (void)setupTimer{
    [self invalidateTimer]; // 创建定时器前先停止定时器,不然会出现僵尸定时器,导致轮播频率错误
    __weak typeof(self) weakself = self;
    self.timer = [NSTimer kj_scheduledTimerWithTimeInterval:self.autoScrollTimeInterval Repeats:YES Block:^(NSTimer *timer) {
        [weakself automaticScroll];
    }];
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}
/// 自动滚动
- (void)automaticScroll{
    if(_nums == 0) return;
    NSInteger currentIndex = [self currentIndex];
    NSInteger targetIndex;
    /// 滚动方向设定
    if (_rollType == KJBannerViewRollDirectionTypeRightToLeft) {
        targetIndex = currentIndex + 1;
    }else{
        if (currentIndex == 0) currentIndex = _nums;
        targetIndex = currentIndex - 1;
    }
    [self scrollToIndex:targetIndex];
}
/// 当前位置
- (NSInteger)currentIndex{
    if(self.collectionView.frame.size.width == 0 || self.collectionView.frame.size.height == 0) return 0;
    NSInteger index = 0;
    if (_layout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {//水平滑动
        index = (self.collectionView.contentOffset.x + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    }else{
        index = (self.collectionView.contentOffset.y + _layout.itemSize.height * 0.5) / _layout.itemSize.height;
    }
    return MAX(0,index);
}
/// 滚动到指定位置
- (void)scrollToIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(kj_BannerView:CurrentIndex:)]) {
        NSInteger idx = index % _imageDatas.count;
        [self.delegate kj_BannerView:self CurrentIndex:idx];
    }
    
    if(index >= _nums){ //滑到最后则调到中间
        if(self.infiniteLoop){
            index = _nums * 0.5;
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
    _lastX = scrollView.contentOffset.x;
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
    CGFloat currentX = scrollView.contentOffset.x;
    CGFloat moveWidth = currentX - self.lastX;
    NSInteger shouldPage = moveWidth / (self.itemWidth*.5);
    if (velocity.x > 0 || shouldPage > 0) {
        _dragIndex = 1;
    }else if (velocity.x < 0 || shouldPage < 0){
        _dragIndex = -1;
    }else{
        _dragIndex = 0;
    }
    self.collectionView.userInteractionEnabled = NO;
    NSInteger idx = (_lastX + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:idx + _dragIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    /// 松开手指滑动开始减速的时候,设置滑动动画
    NSInteger idx = (_lastX + (self.itemWidth + self.itemSpace) * 0.5) / (self.itemSpace + self.itemWidth);
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:idx + _dragIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.nums;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    KJBannerViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"KJBannerViewCell" forIndexPath:indexPath];
    NSInteger itemIndex = indexPath.item % self.imageDatas.count;
    if (self.useDataSource) {
        if ([self.dataSource respondsToSelector:@selector(kj_BannerView:BannerViewCell:ImageDatas:Index:)]) {
            cell.itemView = [_dataSource kj_BannerView:self BannerViewCell:cell ImageDatas:self.imageDatas Index:itemIndex];
        }
        return cell;
    }else{
        if (self.useCustomCell) {
            cell.model = self.imageDatas[itemIndex];
        }else{
            cell.kj_scale = self.kj_scale;
            cell.imgCornerRadius = self.imgCornerRadius;
            cell.placeholderImage = self.placeholderImage;
            cell.contentMode = self.bannerImageViewContentMode;
            cell.info = [KJBannerTool sharedInstance].imageTemps[itemIndex];
        }
        return cell;
    }
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
        _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:self.layout];
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
- (KJBannerViewFlowLayout *)layout{
    if(!_layout){
        _layout = [[KJBannerViewFlowLayout alloc]init];
        _layout.isZoom = self.isZoom;
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _layout.minimumLineSpacing = 0;
    }
    return _layout;
}

#pragma mark - runtime
//动态添加方法
void KJBannerRemovePageControl(id self,SEL sel) {
    [self kj_removePageControl];
}
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    //给本类动态添加一个方法
    if ([NSStringFromSelector(sel) isEqualToString:@"kj_removeBannerPageControl"]) {
        class_addMethod(self, sel, (IMP)KJBannerRemovePageControl, "v@:");
    }
    return [super resolveInstanceMethod:sel];
}

- (void)kj_removePageControl{
    [self.pageControl removeFromSuperview];
}

@end


