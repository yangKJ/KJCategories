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

@interface ViewController ()<KJBannerViewDelegate>
@property (nonatomic,strong) KJBannerView *banner;
@property (nonatomic,strong) KJBannerView *banner2;
@property (nonatomic,strong) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setDatas];
    
    KJBannerView *banner = [[KJBannerView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-30, self.view.frame.size.width*0.4)];
    self.banner = banner;
    banner.itemClass = [KJCollectionViewCell class];
    banner.autoScrollTimeInterval = 2;
    banner.itemSpace = 10;
    banner.itemWidth = self.view.frame.size.width-120;
    banner.delegate = self;
    banner.pageControl.pageType = PageControlStyleCircle;
    banner.pageControl.selectColor = UIColor.redColor;
    banner.rollType = KJBannerViewRollDirectionTypeLeftToRight;
    [self.view addSubview:banner];
    
    banner.kSelectBlock = ^(KJBannerView * _Nonnull banner, NSInteger idx) {
        NSLog(@"---------%@,%ld",banner,idx);
    };
    
    KJBannerView *banner2 = [[KJBannerView alloc]initWithFrame:CGRectMake(0, 150+self.view.frame.size.width*0.4, self.view.frame.size.width, self.view.frame.size.width*0.4)];
    self.banner2 = banner2;
    banner2.imgCornerRadius = 15;
    banner2.autoScrollTimeInterval = 2;
    banner2.isZoom = YES;
    banner2.itemSpace = -10;
    banner2.itemWidth = self.view.frame.size.width-120;
    banner2.delegate = self;
    banner2.imageType = KJBannerViewImageTypeMix;
    NSString *gif = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564463770360&di=c93e799328198337ed68c61381bcd0be&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20170714%2F1eed483f1874437990ad84c50ecfc82a_th.jpg";
    banner2.imageDatas = @[gif,@"98338_https_hhh",@"tu3",
                           @"http://photos.tuchong.com/285606/f/4374153.jpg",
                           ];
    [self.view addSubview:banner2];
    
    UIButton *clearButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    clearButton.frame = CGRectMake(self.view.frame.size.width*.5 - 50, self.view.frame.size.height - 100, 100, 30);
    [clearButton setTitle:@"清除缓存" forState:(UIControlStateNormal)];
    [clearButton setTitleColor:UIColor.redColor forState:(UIControlStateNormal)];
    [clearButton addTarget:self action:@selector(clearAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:clearButton];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width*.5 - 100, self.view.frame.size.height - 100 - 50, 200, 30)];
    label.font = [UIFont systemFontOfSize:12];
    label.textAlignment = NSTextAlignmentCenter;
    self.label = label;
    [self.view addSubview:label];
    
    long long num = [KJLoadImageView kj_imagesCacheSize];
    self.label.text = [NSString stringWithFormat:@"缓存大小：%.02f mb",num / 1024 / 1024.0];
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
        return YES;
    }
    NSLog(@"currentIndex = %ld",(long)index);
    return NO;
}

- (void)_setDatas{
    __weak typeof(self) weakself = self;
    //  延时执行
    int64_t delayInSeconds = 1.0; // 延迟的时间
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
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
        
        weakself.banner.imageDatas = arr;
    });
}

@end
