//
//  KJBannerHeader.h
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2018/12/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#ifndef KJBannerHeader_h
#define KJBannerHeader_h

/*
 ------------- 本人其他库 -------------
 播放器 - KJPlayer是一款视频播放器，AVPlayer的封装，继承UIView
 pod 'KJPlayer'  # 播放器功能区
 pod 'KJPlayer/KJPlayerView'  # 自带展示界面
 - 支持播放网络和本地视频、播放多种格式
 - 视频可以边下边播，把播放器播放过的数据流缓存到本地，下次直接从缓冲读取播放
 - 支持拖动、手势快进倒退、增大减小音量、重力感应切换横竖屏等等

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
 
 
 Github地址：https://github.com/yangKJ
 简书地址：https://www.jianshu.com/u/c84c00476ab6
 博客地址：https://blog.csdn.net/qq_34534179
 
 
#版本更新日志
 
### 版本1.2.3
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
 
```
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
```
 
### 版本 1.0.2
- 新增 KJBannerView 轮播图 - banner支持缩放
- 自带图片下载、缓存相关功能，无任何第三方依赖、轻量级组件
![轮播图](https://upload-images.jianshu.io/upload_images/1933747-2e51515ae91af6d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

*/

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>

/*  滚动轮播Banner
 *  Banner 支持缩放
 *  自带图片下载、缓存相关功能
 */
#import "KJBannerView.h"
//#import "KJLoadImageView.h" /// 加载网络图片
//#import "KJBannerTool.h" /// 工具类

#endif /* KJBannerHeader_h */
