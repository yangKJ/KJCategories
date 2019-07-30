//
//  KJBannerView.h
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/27.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJPageControl.h"
NS_ASSUME_NONNULL_BEGIN
@class KJBannerView;
/// 滚动方法
typedef NS_ENUM(NSInteger, KJBannerViewRollDirectionType) {
    KJBannerViewRollDirectionTypeRightToLeft = 0, /// 默认，从右往左
    KJBannerViewRollDirectionTypeLeftToRight,    /// 从左往右
};
/// 图片的几种类型
typedef NS_ENUM(NSInteger, KJBannerViewImageType) {
    KJBannerViewImageTypeMix = 0, /// 混合，本地图片、网络图片、网络GIF
    KJBannerViewImageTypeGIFAndNet,/// 网络GIF图片和网络图片混合
    KJBannerViewImageTypeLocality,/// 本地图片
    KJBannerViewImageTypeNetIamge,/// 网络图片
    KJBannerViewImageTypeGIFImage,/// 网络GIF图片
};
@protocol KJBannerViewDelegate <NSObject>
@optional
/** 点击图片回调 */
- (void)kj_BannerView:(KJBannerView *)banner SelectIndex:(NSInteger)index;
@end

@interface KJBannerView : UIView

/// 支持自定义Cell，自定义Cell需继承自 KJBannerViewCell
@property (nonatomic,strong) Class itemClass;
//////////////////////  数据源API //////////////////////
/** 网络数组 1.本地  2.图片 url string  */
@property (nonatomic,strong) NSArray *imageDatas;
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
/** 占位图, 用于网络未加载到图片时 */
@property (nonatomic,strong) UIImage *placeholderImage;
/** 分页控制器 */
@property (nonatomic,strong) KJPageControl *pageControl;
/** 滚动方向，默认从右到左 */
@property (nonatomic,assign) KJBannerViewRollDirectionType rollType;
/// 代理方法
@property (nonatomic,weak) id<KJBannerViewDelegate> delegate;
/// block回调
@property (nonatomic,readwrite,copy) void(^kSelectBlock)(KJBannerView *banner,NSInteger idx);

/************************** 自带Cell可设置属性 *****************************/
/** cell的占位图, 用于网络未加载到图片时 */
@property (nonatomic,strong) UIImage *cellPlaceholderImage;
/** 轮播图片的ContentMode, 默认为 UIViewContentModeScaleToFill */
@property (nonatomic,assign) UIViewContentMode bannerImageViewContentMode;
/** imagView圆角, 默认为0 */
@property (nonatomic,assign) CGFloat imgCornerRadius;
/** 图片的样式, 默认 KJBannerViewImageTypeLocality 网络图片 */
@property (nonatomic,assign) KJBannerViewImageType imageType;
@end

NS_ASSUME_NONNULL_END
