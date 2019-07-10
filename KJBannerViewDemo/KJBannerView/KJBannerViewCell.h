//
//  KJBannerViewCell.h
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/27.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KJLoadImageView.h"

@interface KJBannerViewCell : UICollectionViewCell

/// 数据模型 - 用于自定义样式传递数据
@property (nonatomic,strong) NSObject *model;

/// 是否为本地图片，默认NO
@property (nonatomic,assign) BOOL isLocalityImage;
/// 图片显示方式
@property (nonatomic,assign) UIViewContentMode contentMode;
/// 圆角
@property (nonatomic,assign) CGFloat imgCornerRadius;
/// url
@property (nonatomic,strong) NSString *imageUrl;
/// 占位图
@property (nonatomic,strong) UIImage *placeholderImage;

@end
