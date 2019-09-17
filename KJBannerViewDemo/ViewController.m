//
//  ViewController.m
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2018/12/22.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "ViewController.h"
#import "KJBannerHeader.h"
#import "KJCollectionViewCell.h"
#import "KJBannerModel.h"
#import <objc/message.h>

#define gif @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564463770360&di=c93e799328198337ed68c61381bcd0be&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20170714%2F1eed483f1874437990ad84c50ecfc82a_th.jpg"

@interface ViewController ()<KJBannerViewDelegate>
@property (weak, nonatomic) IBOutlet KJBannerView *banner;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,strong) KJBannerView *banner2;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISwitch *Switch;
@property (nonatomic,strong) NSArray *temp;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setDatas];
    [self setXib];
    
    KJBannerView *banner2 = [[KJBannerView alloc]initWithFrame:self.backView.bounds];
    self.banner2 = banner2;
    banner2.itemClass = [KJCollectionViewCell class];
    banner2.imgCornerRadius = 15;
    banner2.autoScrollTimeInterval = 2;
    banner2.isZoom = YES;
    banner2.itemSpace = -10;
    banner2.itemWidth = self.backView.frame.size.width-120;
    banner2.delegate = self;
    banner2.imageType = KJBannerViewImageTypeMix;
    [self.backView addSubview:banner2];
//    /// 隐藏page
//    [banner2 performSelector:@selector(kj_removeBannerPageControl)];
    self.banner2.imageDatas = self.temp;
    
    [self.button addTarget:self action:@selector(clearAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.Switch addTarget:self action:@selector(qiehuanAction:) forControlEvents:(UIControlEventValueChanged)];
    
    long long num = [KJLoadImageView kj_imagesCacheSize];
    self.label.text = [NSString stringWithFormat:@"缓存大小：%.02f mb",num / 1024 / 1024.0];
}

- (void)setXib{
    /// xib方式
    self.banner.delegate = self;
    self.banner.pageControl.pageType = PageControlStyleSizeDot;
    self.banner.imageType = KJBannerViewImageTypeMix;
    self.banner.imageDatas = @[gif,@"98338_https_hhh",@"tu3", @"http://photos.tuchong.com/285606/f/4374153.jpg"];
}

- (void)qiehuanAction:(UISwitch*)sender{
    if (!sender.on) {
        NSArray *images = @[@"http://photos.tuchong.com/285606/f/4374153.jpg",
                            @"http://img5.cache.netease.com/photo/0003/2012-06-21/84G462VS51GQ0003.jpg",
                            @"http://thumb.niutuku.com/960x1/2f/fd/2ffd3765c4b43c743751246b156d1896.jpg",
                            ];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i=0; i<images.count; i++) {
            KJBannerModel *model = [[KJBannerModel alloc]init];
            model.customImageUrl = images[i];
            model.customTitle = [NSString stringWithFormat:@"新版数据:%ld",i];
            [arr addObject:model];
        }
        self.banner2.imageDatas = arr;
    }else{
        self.banner2.imageDatas = self.temp;
    }
}
- (void)clearAction{
    [KJLoadImageView kj_clearImagesCache];
}

#pragma mark - KJBannerViewDelegate
//点击图片的代理
- (void)kj_BannerView:(KJBannerView *)banner SelectIndex:(NSInteger)index{
    NSLog(@"index = %ld",(long)index);
}
- (BOOL)kj_BannerView:(KJBannerView *)banner CurrentIndex:(NSInteger)index{
    long long num = [KJLoadImageView kj_imagesCacheSize];
    self.label.text = [NSString stringWithFormat:@"缓存大小：%.02f mb",num / 1024 / 1024.0];
    if (banner == self.banner) {
        return NO;
    }
    NSLog(@"currentIndex = %ld",(long)index);
    return NO;
}

- (void)_setDatas{
    NSArray *images = @[
        @"http://img12.360buyimg.com/piao/jfs/t2743/132/3170930521/77809/42cfd6d4/57836e27N06956fd3.jpg",
        @"http://photos.tuchong.com/285606/f/4374153.jpg",
        @"http://img5.cache.netease.com/photo/0003/2012-06-21/84G462VS51GQ0003.jpg",
        @"http://thumb.niutuku.com/960x1/2f/fd/2ffd3765c4b43c743751246b156d1896.jpg",
        @"http://i2.hdslb.com/bfs/archive/1c471796343e34a8613518cc0d393792680a1022.jpg",
        ];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i=0; i<images.count; i++) {
        KJBannerModel *model = [[KJBannerModel alloc]init];
        model.customImageUrl = images[i];
        model.customTitle = [NSString stringWithFormat:@"图片名称:%ld",i];
        [arr addObject:model];
    }
    self.temp = arr;
}

@end
