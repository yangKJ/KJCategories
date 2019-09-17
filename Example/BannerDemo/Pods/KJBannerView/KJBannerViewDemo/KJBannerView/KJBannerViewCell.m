//
//  KJBannerViewCell.m
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/27.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBannerViewCell.h"

@interface KJBannerViewCell()
@property (nonatomic,strong) KJLoadImageView *loadImageView;
@end

@implementation KJBannerViewCell

- (void)setInfo:(KJBannerDatasInfo *)info{
    switch (info.type) {
        case KJBannerImageInfoTypeLocality:
        case KJBannerImageInfoTypeGIFImage:
            self.loadImageView.image = info.image;
            break;
        case KJBannerImageInfoTypeNetIamge:
            [self.loadImageView kj_setImageWithURLString:info.imageUrl Placeholder:self.placeholderImage];
            break;
        default:
            break;
    }
}

#pragma mark - lazy
- (KJLoadImageView *)loadImageView{
    if(!_loadImageView){
        _loadImageView = [[KJLoadImageView alloc]initWithFrame:self.bounds];
        _loadImageView.image = self.placeholderImage;
        _loadImageView.contentMode = self.contentMode;
        [self.contentView addSubview:_loadImageView];
        if (self.imgCornerRadius > 0) {
            /// 画圆
            UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_loadImageView.bounds cornerRadius:_imgCornerRadius];
            CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
            /// 设置大小
            maskLayer.frame = self.bounds;
            /// 设置图形样子
            maskLayer.path = maskPath.CGPath;
            _loadImageView.layer.mask = maskLayer;
        }
    }
    return _loadImageView;
}
@end
