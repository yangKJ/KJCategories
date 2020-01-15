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
#import "KJTestViewController.h"

#define gif @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1564463770360&di=c93e799328198337ed68c61381bcd0be&imgtype=0&src=http%3A%2F%2Fimg.mp.itc.cn%2Fupload%2F20170714%2F1eed483f1874437990ad84c50ecfc82a_th.jpg"
#define gif2 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1579085817466&di=0c1cba2b5dba938cd33ea7d053b1493a&imgtype=0&src=http%3A%2F%2Fww2.sinaimg.cn%2Flarge%2F85cc5ccbgy1ffngbkq2c9g20b206k78d.jpg"
#define tu1 @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1579082232413&di=2775dc6e781e712d518bf1cf7a1e675e&imgtype=0&src=http%3A%2F%2Fimg3.doubanio.com%2Fview%2Fnote%2Fl%2Fpublic%2Fp41813904.jpg"

@interface ViewController ()<KJBannerViewDelegate,KJBannerViewDataSource>{
    __block UILabel *lab,*labe;
}
@property (weak, nonatomic) IBOutlet KJBannerView *banner;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UISwitch *Switch;
@property (nonatomic,strong) KJBannerView *banner2;
@property (nonatomic,strong) NSArray *temp;
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.banner kj_repauseTimer];
    [self.banner2 kj_repauseTimer];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.banner kj_pauseTimer];
    [self.banner2 kj_pauseTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _setDatas];
    [self setXib];
    [self setUI];
    [self setTimer];
}

- (void)setUI{
    KJBannerView *banner2 = [[KJBannerView alloc]initWithFrame:self.backView.bounds];
    self.banner2 = banner2;
    banner2.imgCornerRadius = 15;
    banner2.autoScrollTimeInterval = 2;
    banner2.isZoom = YES;
    banner2.itemSpace = -10;
    banner2.itemWidth = 280;
    banner2.delegate = self;
    banner2.dataSource = self;
//    banner2.itemClass = [KJCollectionViewCell class];
    banner2.imageType = KJBannerViewImageTypeMix;
    [self.backView addSubview:banner2];
    self.banner2.imageDatas = self.temp;
    
    [self.button addTarget:self action:@selector(clearAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.Switch addTarget:self action:@selector(qiehuanAction:) forControlEvents:(UIControlEventValueChanged)];
    
    long long num = [KJLoadImageView kj_imagesCacheSize];
    self.label.text = [NSString stringWithFormat:@"缓存大小：%.02f MB",num / 1024 / 1024.0];
    
    CGFloat w = self.view.frame.size.width;
    CGFloat h = CGRectGetMaxY(self.label.frame) + 50;
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, h + 30, w-40, 20)];
//    label.textColor = UIColor.greenColor;
    label.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(20, h + 30 + 30, w-40, 20)];
//    label2.textColor = UIColor.greenColor;
    label2.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:label2];
    
    lab = label;
    labe = label2;
    label.text = [NSString stringWithFormat:@"当前设备可用内存：%.2fMB",[KJTestViewController availableMemory]];
    label2.text = [NSString stringWithFormat:@"当前任务所占用内存：%.2fMB",[KJTestViewController usedMemory]];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(20, self.view.frame.size.height - 30, w-40, 20)];
//    label3.text = @"pod 'KJBannerView',";
    label3.textColor = UIColor.redColor;
    label3.numberOfLines = 0;
    label3.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label3];
}

- (void)setTimer{
    __weak typeof(self) weakself = self;
    NSTimer*timer = [NSTimer kj_scheduledTimerWithTimeInterval:1.0 Repeats:YES Block:^(NSTimer *timer) {
        dispatch_async(dispatch_get_main_queue(), ^{
            lab.text = [NSString stringWithFormat:@"当前设备可用内存：%.2fMB",[KJTestViewController availableMemory]];
            labe.text =[NSString stringWithFormat:@"当前任务所占用内存：%.2fMB",[KJTestViewController usedMemory]];
            weakself.label.text = [NSString stringWithFormat:@"缓存大小：%.02f MB",[KJLoadImageView kj_imagesCacheSize] / 1024 / 1024.0];
        });
    }];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

- (void)setXib{
    /// xib方式
    self.banner.delegate = self;
    self.banner.pageControl.pageType = PageControlStyleSizeDot;
    self.banner.imageType = KJBannerViewImageTypeMix;
    self.banner.imageDatas = @[gif,@"98338_https_hhh",tu1,gif2,@"http://photos.tuchong.com/285606/f/4374153.jpg"];
}

- (void)qiehuanAction:(UISwitch*)sender{
    if (!sender.on) {
        NSArray *images = @[
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1579082232413&di=2775dc6e781e712d518bf1cf7a1e675e&imgtype=0&src=http%3A%2F%2Fimg3.doubanio.com%2Fview%2Fnote%2Fl%2Fpublic%2Fp41813904.jpg",  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1579081905778&di=6ff1ad740b5d1dfc2d622c44fff8716b&imgtype=0&src=http%3A%2F%2Fimg.guitarchina.com%2Fimg2011%2F1013wj3%2F57.jpg",
        @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2791659266,2306116334&fm=26&gp=0.jpg",
        @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1579081948321&di=12073138df74d694f683a2526852a3af&imgtype=0&src=http%3A%2F%2Fwx4.sinaimg.cn%2Flarge%2F005Nclsvgy1fde9a93yipj31kw11znbs.jpg",
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
- (IBAction)pauseRoll:(UIButton *)sender {
    [self.banner kj_pauseTimer];
    [self.banner2 kj_pauseTimer];
}
- (IBAction)repauseRoll:(UIButton *)sender {
    [self.banner kj_repauseTimer];
    [self.banner2 kj_repauseTimer];
}

#pragma mark - KJBannerViewDelegate
//点击图片的代理
- (void)kj_BannerView:(KJBannerView *)banner SelectIndex:(NSInteger)index{
    NSLog(@"index = %ld",(long)index);
    KJTestViewController *vc = [KJTestViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}
- (BOOL)kj_BannerView:(KJBannerView *)banner CurrentIndex:(NSInteger)index{
    if (banner == self.banner) {
        return NO;
    }
    NSLog(@"currentIndex = %ld",(long)index);
    return NO;
}

- (void)_setDatas{
    NSArray *images = @[@"http://photos.tuchong.com/285606/f/4374153.jpg"];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i=0; i<images.count; i++) {
        KJBannerModel *model = [[KJBannerModel alloc]init];
        model.customImageUrl = images[i];
        model.customTitle = [NSString stringWithFormat:@"图片名称:%ld",i];
        [arr addObject:model];
    }
    self.temp = arr;
}

#pragma mark - KJBannerViewDataSource
- (UIView*)kj_BannerView:(KJBannerView*)banner BannerViewCell:(KJBannerViewCell*)bannercell ImageDatas:(NSArray*)imageDatas Index:(NSInteger)index{
    KJBannerModel *model = imageDatas[index];
    CGRect rect = {0, 0, 100, 20};
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.text = model.customTitle;
    label.textColor = UIColor.whiteColor;
    label.center = bannercell.contentView.center;
    KJLoadImageView *imageView = [[KJLoadImageView alloc]initWithFrame:bannercell.contentView.bounds];
    imageView.kj_isScale = YES;
    [imageView kj_setImageWithURLString:model.customImageUrl Placeholder:[UIImage imageNamed:@"tu3"]];
    [imageView addSubview:label];
    return imageView;
}

@end
