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
@property (nonatomic,strong) KJLoadImageView *loadImageView;
/// 圆角
@property (nonatomic,assign) CGFloat imgCornerRadius;
/// url
@property (nonatomic,strong) NSString *imageUrl;
/// 占位图
@property (nonatomic,strong) UIImage *placeholderImage;

@end
