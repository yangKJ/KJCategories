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

- (void)setImageUrl:(NSString *)imageUrl{
    if (self.imageType == 0) { // 混合，本地图片、网络图片、网络GIF
        //1.判断是本地还是网络
        BOOL boo = [KJBannerTool kj_bannerImageWithImageUrl:imageUrl];
        if (boo) { /// 本地图片
            self.loadImageView.image = [UIImage imageNamed:imageUrl];
            //[self kj_ImageLociaWithURL:imageUrl];
        }else{
            [self kj_ImageWithURL:imageUrl];
        }
    }else if (self.imageType == 1) { // 网络GIF和网络图片混合
        [self kj_ImageWithURL:imageUrl];
    }else if (self.imageType == 2) { // 本地图片
        self.loadImageView.image = [UIImage imageNamed:imageUrl];
    }else if (self.imageType == 3) { // 网络图片
        [self.loadImageView kj_setImageWithURLString:imageUrl Placeholder:self.placeholderImage];
    }else if (self.imageType == 4) { // 网络GIF图片
        [self kj_ImageWithURL:imageUrl];
    }
}

#pragma mark - 内部方法
/// 本地GIF和本地图片
- (void)kj_ImageLociaWithURL:(NSString*)imageUrl{
    //2.判断是否为本地的gif
    BOOL booo = [KJBannerTool kj_bannerIsGifImageWithImageName:imageUrl];
    if (booo == NO) {
        //显示本地图片
        self.loadImageView.image = [UIImage imageNamed:imageUrl];
    }
}
/// 网络图片和GIF处理
- (void)kj_ImageWithURL:(NSString*)imageUrl{
    __block NSString *name = [KJBannerTool kj_bannerMD5WithString:imageUrl];
    __block BOOL next = NO;
    [[KJBannerTool sharedInstance].imageTemps enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //判断是否已经存在
        if ([obj[@"name"] isEqualToString:name]) {
            //判断是否为GIF
            if ([obj[@"gif"] integerValue]) {
                self.loadImageView.image = obj[@"image"];
            }else{
                [self.loadImageView kj_setImageWithURLString:imageUrl Placeholder:self.placeholderImage];
            }
            next = YES;
            *stop = YES;
        }
    }];
    if (next) return;
    NSDictionary *dict;
    BOOL boooo = [KJBannerTool kj_bannerIsGifWithURL:imageUrl];
    if (boooo) {
        //5.获取gif图
        UIImage *animatedImage = [KJBannerTool kj_bannerGetImageWithURL:imageUrl];
        self.loadImageView.image = animatedImage;
        dict = @{@"name":name,@"image":animatedImage,@"gif":@(boooo)};
    }else{
        //5.显示网络图片
        [self.loadImageView kj_setImageWithURLString:imageUrl Placeholder:self.placeholderImage];
        dict = @{@"name":name,@"gif":@(boooo)};
    }
    [[KJBannerTool sharedInstance].imageTemps addObject:dict];
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
