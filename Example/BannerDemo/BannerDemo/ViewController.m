//
//  ViewController.m
//  BannerDemo
//
//  Created by 杨科军 on 2019/7/30.
//  Copyright © 2019 杨科军. All rights reserved.
//

#import "ViewController.h"
#import <KJBannerHeader.h>
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    KJBannerView *banner2 = [[KJBannerView alloc]initWithFrame:CGRectMake(0, 150+self.view.frame.size.width*0.4, self.view.frame.size.width, self.view.frame.size.width*0.4)];
    banner2.imgCornerRadius = 15;
    banner2.autoScrollTimeInterval = 2;
    banner2.isZoom = YES;
    banner2.itemSpace = -10;
    banner2.itemWidth = self.view.frame.size.width-120;
    banner2.imageType = KJBannerViewImageTypeMix;
    NSString *gif = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564463770360&di=c93e799328198337ed68c61381bcd0be&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20170714%2F1eed483f1874437990ad84c50ecfc82a_th.jpg";
    banner2.imageDatas = @[gif,@"timg",@"jita",
                           @"http://photos.tuchong.com/285606/f/4374153.jpg",
                           ];
    [self.view addSubview:banner2];
    
    banner2.kSelectBlock = ^(KJBannerView * _Nonnull banner, NSInteger idx) {
        NSLog(@"---------%@,%ld",banner,idx);
    };
}


@end
