//
//  KJBannerView.h
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/27.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>

@class KJBannerView;
@protocol KJBannerViewDelegate <NSObject>
@optional
/** 点击图片回调 */
- (void)kj_BannerView:(KJBannerView *)banner SelectIndex:(NSInteger)index;
@end

@interface KJBannerView : UIView
//////////////////////  数据源API //////////////////////
/** 网络数组 1.本地  2.图片 url string  */
@property (nonatomic,strong) NSArray *imageDatas;
/** 占位图, 用于网络未加载到图片时 */
@property (nonatomic,strong) UIImage *placeholderImage;
/** cell的占位图, 用于网络未加载到图片时 */
@property (nonatomic,strong) UIImage *cellPlaceholderImage;
/** 轮播图片的ContentMode, 默认为 UIViewContentModeScaleToFill */
@property (nonatomic,assign) UIViewContentMode bannerImageViewContentMode;
/** 分页控制器 */
@property (nonatomic,strong) UIPageControl *pageControl;
/// 是否无线循环, 默认yes
@property (nonatomic,assign) BOOL infiniteLoop;
/// 是否自动滑动, 默认yes
@property (nonatomic,assign) BOOL autoScroll;
/// 是否缩放, 默认不缩放
@property (nonatomic,assign) BOOL isZoom;
/// 自动滚动间隔时间, 默认2s
@property (nonatomic,assign) CGFloat autoScrollTimeInterval;
/// cell宽度  左右宽度
@property (nonatomic,assign) CGFloat itemWidth;
/// cell间距  上下高度, 默认为0
@property (nonatomic,assign) CGFloat itemSpace;
/// imagView圆角, 默认为0
@property (nonatomic,assign) CGFloat imgCornerRadius;
/// 代理方法
@property (nonatomic,weak) id<KJBannerViewDelegate> delegate;

@end
