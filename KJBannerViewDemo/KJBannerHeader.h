//
//  KJBannerHeader.h
//  KJBannerViewDemo
//
//  Created by 杨科军 on 2018/12/23.
//  Copyright © 2018 杨科军. All rights reserved.
//

#ifndef KJBannerHeader_h
#define KJBannerHeader_h

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <objc/runtime.h>


/*
#版本更新日志

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

/*  滚动轮播Banner
 *  Banner 支持缩放
 *  自带图片下载、缓存相关功能
 */
#import "KJBannerView.h"
#import "KJLoadImageView.h" /// 加载网络图片

#endif /* KJBannerHeader_h */
