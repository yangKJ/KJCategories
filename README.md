# KJBannerView

* 这个工程提供了轮播Banner，自带图片下载、缓存相关功能
* 无任何第三方依赖、轻量级组件
* pod 'KJBannerView'

#### 相关Demo下载地址
[Demo下载地址](https://github.com/yangKJ/KJBannerViewDemo）
#### 简书地址
[简书地址](https://www.jianshu.com/u/c84c00476ab6）

### Bug解决
1、Cannot synthesize weak property because the current deployment target does not support weak references

- 解决方案：
- 1、项目 -> TARGETS -> Build Settings -> 搜索 Weak References in Manual Retain Release 改为YES
- 2、如果不行，在podfile文件底下加入下面的代码，'8.0'是对应的部署目标（deployment target）删除库重新pod

```
##################加入代码##################
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] ='8.0'
        end
    end
end
##################加入代码##################
```

### 版本 1.0.2
新增 KJBannerView 轮播图 - banner支持缩放
自带图片下载、缓存相关功能，无任何第三方依赖、轻量级组件
![轮播图](https://upload-images.jianshu.io/upload_images/1933747-2e51515ae91af6d4.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)



