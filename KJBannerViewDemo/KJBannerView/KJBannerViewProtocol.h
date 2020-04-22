//
//  KJBannerViewProtocol.h
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2020/3/3.
//  Copyright © 2020 杨科军. All rights reserved.
//  委托协议相关

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class KJBannerView;
@protocol KJBannerViewDelegate <NSObject>
@optional
/** 点击图片回调 */
- (void)kj_BannerView:(KJBannerView*)banner SelectIndex:(NSInteger)index;
/** 滚动时候回调 是否隐藏自带的PageControl */
- (BOOL)kj_BannerView:(KJBannerView*)banner CurrentIndex:(NSInteger)index;
@end

@protocol KJBannerViewDataSource <NSObject>
/// 自定义控件
- (UIView*)kj_BannerView:(KJBannerView*)banner BannerViewCell:(KJBannerViewCell*)bannercell ImageDatas:(NSArray*)imageDatas Index:(NSInteger)index;
@end
