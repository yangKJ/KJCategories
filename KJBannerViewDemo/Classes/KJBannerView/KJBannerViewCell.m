//
//  KJBannerViewCell.m
//  KJBannerView
//
//  Created by 杨科军 on 2018/2/27.
//  Copyright © 2018年 杨科军. All rights reserved.
//

#import "KJBannerViewCell.h"

@interface KJBannerViewCell()

@end

@implementation KJBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self.contentView addSubview:self.loadImageView];
    }
    return self;
}
- (void)layoutSubviews{
    self.loadImageView.frame = self.bounds;
    
    /// 画圆
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.loadImageView.bounds cornerRadius:self.imgCornerRadius];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = self.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    _loadImageView.layer.mask = maskLayer;
}

- (void)setImageUrl:(NSString *)imageUrl{
    [_loadImageView kj_setImageWithURLString:imageUrl Placeholder:_placeholderImage];
}

#pragma mark - lazy
- (KJLoadImageView *)loadImageView{
    if(!_loadImageView){
        _loadImageView = [[KJLoadImageView alloc]init];
    }
    return _loadImageView;
}
@end
