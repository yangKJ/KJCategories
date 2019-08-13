# KJBannerView
![coverImage](https://raw.githubusercontent.com/yangKJ/CommonDatas/master/CommonDatas/Res/coverImage.jpg)
<video id="video" controls="" preload="none" width="375px" height="667px" poster="https://raw.githubusercontent.com/yangKJ/KJBannerViewDemo/master/Res/IMG_6906.PNG">
<source id="mp4" src="https://github.com/yangKJ/KJBannerViewDemo/blob/master/Res/IMG_6904.mp4" type="video/mp4">
</video>

----------------------------------------
### 框架整体介绍
* [作者信息](#作者信息)
* [作者其他库](#作者其他库)
* [功能介绍](#功能介绍)
* [Pod使用方法](#使用方法(支持cocoapods/carthage安装))
* [更新日志](#更新日志)
* [效果图](#效果图)
* [KJBannerView 功能区](#KJBannerView)
* [打赏作者 &radic;](#打赏作者)

----------------------------------------
#### <a id="功能介绍"></a>功能介绍
KJBannerView 是一款轮播Banner，自带图片下载、缓存相关功能、轻量级组件    
1.无任何第三方依赖、自带缓存加载  ☑️  
2.缩放无限循环滚动  ☑️  
3.自定义继承 KJBannerViewCell、定制特定样式  ☑️  
4.支持网络GIF和网络图片和本地图片混合轮播  ☑️  
5.图片和视频混合展示 

----------------------------------------
#### 温馨提示
使用第三方库Xcode报错  
Cannot synthesize weak property because the current deployment target does not support weak references  
可在`Podfile`文件底下加入下面的代码，'8.0'是对应的部署目标（deployment target） 删除库重新Pod  
不支持用weak修饰属性，而weak在使用ARC管理引用计数项目中才可使用  
遍历每个develop target，将target支持版本统一设成一个支持ARC的版本

```
##################加入代码##################
# 使用第三方库xcode报错Cannot synthesize weak property because the current deployment target does not support weak references
post_install do |installer|
installer.pods_project.targets.each do |target|
target.build_configurations.each do |config|
config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] ='8.0'
end
end
end
##################加入代码##################
```

----------------------------------------

#### <a id="作者信息"></a>作者信息
> Github地址：https://github.com/yangKJ  
> 简书地址：https://www.jianshu.com/u/c84c00476ab6  
> 博客地址：https://blog.csdn.net/qq_34534179  

#### <a id="作者其他库"></a>作者其他Pod库
```
播放器 - KJPlayer是一款视频播放器，AVPlayer的封装，继承UIView
- 支持播放网络和本地视频、播放多种格式
- 视频可以边下边播，把播放器播放过的数据流缓存到本地，下次直接从缓冲读取播放
- 支持拖动、手势快进倒退、增大减小音量、重力感应切换横竖屏等等
pod 'KJPlayer'  # 播放器功能区
pod 'KJPlayer/KJPlayerView'  # 自带展示界面

实用又方便的Category和一些自定义控件
pod 'KJEmitterView'
pod 'KJEmitterView/Function'#
pod 'KJEmitterView/Control' # 自定义控件

轮播图 - 支持缩放 多种pagecontrol 支持继承自定义样式 自带网络加载和缓存
pod 'KJBannerView'  # 轮播图，网络图片加载

菜单控件 - 下拉控件 选择控件
pod 'KJMenuView' # 菜单控件

加载Loading - 多种样式供选择
pod 'KJLoadingAnimation' # 加载控件

```

##### Issue
如果您在使用中有好的需求及建议，或者遇到什么bug，欢迎随时issue，我会及时的回复，有空也会不断优化更新这些库

#### <a id="使用方法(支持cocoapods/carthage安装)"></a>Pod使用方法
```
pod 'KJBannerView' # 轮播图 
```

#### <a id="更新日志"></a>更新日志
```
####版本更新日志:
### 版本1.2.5
- 新增委托方法 kj_BannerView:CurrentIndex: 滚动时候回调 可是否隐藏自带的PageControl
- 优化性能，修复重复创建PageControl

### 版本1.2.4
- 新增本地和网络图片混合，自带判断方式，去掉以前的本地判断方式
- 新增Gif图显示，支持本地图片、网络图片、网络GIF图片混合显示
- KJBannerViewImageType 控制图片的显示类型

### 版本1.2.2
- 修改pageControl样式颜色的修改方式，从而提高效率

### 版本1.2.1
- 再次优化，提高性能
- 新增自带Cell显示本地图片 isLocalityImage

### 版本1.2.0
- 新增自定义KJPageControl，支持3种样式（圆形，长方形，正方形）
- 重新整理，从而提高轮播图性能
- 自带Cell新增默认占位图，一条数据时隐藏KJPageControl

### 版本1.1.1
- 新增支持Swift宏
- 新增Block代理点击事件 KJBannerViewBlock
- 新增设置滚动方向属性 rollType

### 版本1.1.0
- 新增 支持自定义Cell
- 使用方法：
- 创建从KJBannerViewCell继承的Cell
- 在model设置数据

- (instancetype)initWithFrame:(CGRect)frame{
if (self=[super initWithFrame:frame]) {
[self.contentView addSubview:self.NameLabel];
}
return self;
}
- (void)setModel:(NSObject *)model{
KJBannerModel *kj_model = (KJBannerModel*)model;
self.NameLabel.text = kj_model.customTitle;
}

### 版本 1.0.2
- 新增 KJBannerView 轮播图 - banner支持缩放
- 自带图片下载、缓存相关功能，无任何第三方依赖、轻量级组件

```

#### <a id="效果图"></a>效果图
![轮播图](https://upload-images.jianshu.io/upload_images/1933747-2e51515ae91af6d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

![KJBannerViewDemo](https://upload-images.jianshu.io/upload_images/1933747-44a8733e65ea3b57.gif?imageMogr2/auto-orient/strip)

#### <a id="KJBannerView"></a>KJBannerView

- KJPageControl：自定义三种PageControl  长方形、正方形、圆形
- KJBannerViewFlowLayout：Cell缩放管理
- KJBannerViewCell：基类Cell，自定义的Cell需继承该Cell
- KJLoadImageView：图片下载工具类
- KJBannerTool：一些关于GIF的工具方法

##### 代码事例
```
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
@end

@implementation ViewController

- (void)viewDidLoad {
[super viewDidLoad];

[self _setDatas];

KJBannerView *banner = [[KJBannerView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-30, self.view.frame.size.width*0.4)];
self.banner = banner;
banner.itemClass = [KJCollectionViewCell class];
banner.autoScrollTimeInterval = 2;
//    banner.isZoom = YES;
banner.itemSpace = 10;
banner.itemWidth = self.view.frame.size.width-120;
//    banner.delegate = self;
banner.pageControl.kPageType = PageControlStyleCircle;
banner.pageControl.kSelectedColor = UIColor.redColor;
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
}

#pragma mark - KJBannerViewDelegate
//点击图片的代理
- (void)kj_BannerView:(KJBannerView *)banner SelectIndex:(NSInteger)index{
NSLog(@"index = %ld",(long)index);

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

```

#### <a id="打赏作者"></a>打赏作者
<!--user:用户名 repo:仓库名字 type:star count:数量-->
* 如果你觉得有帮助，还请为我 <iframe
style="margin-left: 2px; margin-bottom:-5px;"
frameborder="0" scrolling="0" width="100px" height="20px"
src="https://ghbtns.com/github-btn.html?user=yangKJ&repo=KJBannerViewDemo&type=star&count=true" ></iframe>   
* 如果在使用过程中遇到Bug，希望你能Issues，我会及时修复  
* 大家有什么需要添加的功能，也可以给我留言，有空我将补充完善  
* 谢谢大家的支持 - -！  

[![LOGO](https://github.com/yangKJ/KJPlayerDemo/blob/master/KJPlayerDemo/Demo/Assets.xcassets/AppIcon.appiconset/WechatIMG57486iPhoneSpootlight7_40pt@3x.png?raw=true)](https://github.com/yangKJ/KJBannerViewDemo)

[![谢谢老板](https://raw.githubusercontent.com/yangKJ/CommonDatas/master/CommonDatas/Money/77%E3%80%82/All.png)](https://github.com/yangKJ/KJBannerViewDemo)

#### 救救孩子吧，谢谢各位老板～～～～

