//
//  KJBannerView.h
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/27.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJPageControl.h"
#import "KJBannerViewCell.h"
#import "NSTimer+KJSolve.h"
#import "KJBannerViewProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface KJBannerView : UIView
/// 代理方法
@property (nonatomic,weak) id<KJBannerViewDelegate> delegate;
@property (nonatomic,weak) id<KJBannerViewDataSource> dataSource;
/// block回调
@property (nonatomic,readwrite,copy) void(^kSelectBlock)(KJBannerView *banner,NSInteger idx);

//************************ 数据源API ************************
/** 网络数组 1.本地  2.图片 url string  */
@property (nonatomic,strong) NSArray *imageDatas;
/// 自动滚动间隔时间, 默认2s
@property (nonatomic,assign) IBInspectable CGFloat autoScrollTimeInterval;
/// 是否无线循环, 默认yes
@property (nonatomic,assign) IBInspectable BOOL infiniteLoop;
/// 是否自动滑动, 默认yes
@property (nonatomic,assign) IBInspectable BOOL autoScroll;
/// 是否缩放, 默认不缩放
@property (nonatomic,assign) IBInspectable BOOL isZoom;
/// cell宽度, 左右宽度
@property (nonatomic,assign) IBInspectable CGFloat itemWidth;
/// cell间距, 默认为0
@property (nonatomic,assign) IBInspectable CGFloat itemSpace;
/** 滚动方向, 默认从右到左 */
@property (nonatomic,assign) KJBannerViewRollDirectionType rollType;
/** 分页控制器 */
@property (nonatomic,strong,readonly) KJPageControl *pageControl;

/// 暂停计时器滚动处理
/// 备注：在viewDidDisappear当中实现
- (void)kj_pauseTimer;
/// 继续计时器滚动
/// 备注：在viewDidAppear当中实现
- (void)kj_repauseTimer;

//************************ 自带Cell可设置属性 *****************************/
/** imagView圆角, 默认为0 */
@property (nonatomic,assign) IBInspectable CGFloat imgCornerRadius;
/** cell的占位图, 用于网络未加载到图片时 */
@property (nonatomic,strong) IBInspectable UIImage *placeholderImage;
/** 轮播图片的ContentMode, 默认为 UIViewContentModeScaleToFill */
@property (nonatomic,assign) UIViewContentMode bannerImageViewContentMode;
/** 图片的样式, 默认 KJBannerViewImageTypeLocality 网络图片 */
@property (nonatomic,assign) KJBannerViewImageType imageType;
/** 是否裁剪, 默认no*/
@property (nonatomic,assign) BOOL kj_scale;

//************************ 废弃属性方法 *****************************/
/// 支持自定义Cell，自定义Cell需继承自 KJBannerViewCell
@property (nonatomic,strong) Class itemClass DEPRECATED_MSG_ATTRIBUTE("Please use dataSource [kj_BannerView:BannerViewCell:ImageDatas:Index:]");

@end

NS_ASSUME_NONNULL_END
