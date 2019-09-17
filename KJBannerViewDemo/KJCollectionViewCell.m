//
//  KJCollectionViewCell.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2019/1/13.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "KJCollectionViewCell.h"

@interface KJCollectionViewCell ()
@property (strong, nonatomic) UILabel *NameLabel;
@property (strong, nonatomic) KJLoadImageView *ImageView;

@end

@implementation KJCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        [self.contentView addSubview:self.ImageView];
        [self.contentView addSubview:self.NameLabel];
    }
    return self;
}

- (void)setModel:(NSObject *)model{
    KJBannerModel *mmodel = (KJBannerModel*)model;
    [self.ImageView kj_setImageWithURLString:mmodel.customImageUrl Placeholder:[UIImage imageNamed:@"tu3"]];
    self.NameLabel.text = mmodel.customTitle;
}

- (KJLoadImageView *)ImageView{
    if(!_ImageView){
        _ImageView = [[KJLoadImageView alloc]initWithFrame:self.contentView.bounds];
        _ImageView.layer.cornerRadius = 10;
    }
    return _ImageView;
}

- (UILabel*)NameLabel{
    if (!_NameLabel) {
        _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 100, 20)];
        _NameLabel.center = self.contentView.center;
        _NameLabel.textColor = UIColor.whiteColor;
    }
    return _NameLabel;
}

@end
