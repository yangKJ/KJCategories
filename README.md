# KJCategories

![License MIT](https://img.shields.io/github/license/mashape/apistatus.svg?maxAge=2592000)
![Pod version](https://img.shields.io/cocoapods/v/KJCategories.svg?style=flat)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Platform info](https://img.shields.io/cocoapods/p/KJCategories.svg?style=flat)](http://cocoadocs.org/docsets/KJCategories)

- 该库是从之前`KJEmitterView`当中独立拆解出来使用，后续有相关也会慢慢补充..
- 觉得有帮助的老哥，请帮忙点个星⭐..

#### 救救孩子吧，谢谢各位老板～～～～

---

- UIButton：图文混排、点击事件封装、扩大点击域、时间间隔限制、倒计时、点击粒子效果等
- UIView：手势封装、圆角渐变、Xib属性，基础动画封装等
- UITextView：输入框扩展、限制字数、撤销处理、获取文本内部超链接
- UITextField：占位颜色，线条，图文处理等
- UILabel：富文本，快捷显示文本位置
- UIImage：截图和裁剪、图片压缩、蒙版处理，图片拼接、图片尺寸处理，滤镜渲染、泛洪算法等
- UIImage：二维码、条形码生成，动态图播放，水印处理等等
- Runtime：列表，方法交换，动态继承等
- Foundation：数组和字典防崩处理，数组算法处理，谓词相关，加密解密等等
- Opencv：图片处理封装，霍夫矫正，特征提取，形态学处理，滤镜处理，照片修复等等
- CustomControl：自定义渐变色滑杆，

#### Foundation我还整理封装异常处理Crash防护 [KJExceptionDemo](https://github.com/yangKJ/KJExceptionDemo)

### <a id="效果图"></a>
<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-5cccc7ddb754fef5.gif?imageMogr2/auto-orient/strip" width="200" hspace="1px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-ee290038a762cac4.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="30px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-eb62f6e462505d69.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
</p>

<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-b5c171bee7c7bae5.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f1a37cede69d462aab85ff1486aa5fd4~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="30px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-a2dc9062541cf24c.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
</p>

<p align="left">
<img src="https://upload-images.jianshu.io/upload_images/1933747-ec3102711073b390.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="1px">
<img src="https://upload-images.jianshu.io/upload_images/1933747-eaca7b4e368efb93.image?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240" width="200" hspace="30px">
<img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/2cc5f05dd18740bdad9170d962ba6404~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="1px">
</p>

<p align="left">
<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/be86b64dac0b4bb4ae393f2b17d732a6~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="1px">
<img src="https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/0d0e31ce4c324bfebc12500608335c2c~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="30px">
<img src="https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/de85289ad3574a0cb101446249d800e4~tplv-k3u1fbpfcp-watermark.image" width="200" hspace="1px">
</p>

### Example

- **Core** 该模块主要涵盖常用核心分类

```ruby
pod 'KJCategories'
```

- **Kit** 该模块主要包含UIKit相关分类

```ruby
pod 'KJCategories/Kit'
```

- **Foundation** 该模块主要包含Foundation相关分类

```ruby
pod 'KJCategories/Foundation'
```

`Kit`和`Foundation`模块均可选择子模块导入项目工程

- 举个例子导入`数组模块`
  - `pod 'KJCategories/Foundation/NSArray'`
- 举个例子导入`贝塞尔曲线模块`
  - `pod 'KJCategories/Kit/UIBezierPath'`
  
- **Opencv** 该模块主要封装关于C++图片处理框架OpenCV

```ruby
pod 'KJCategories/Opencv'
```

- **CustomControl** 该模块主要就是自定义组件，支持子模块导入

```ruby
pod 'KJCategories/CustomControl'
```

-  举个例子导入`渐变色滑杆模块`
  - `pod 'KJCategories/CustomControl/GradientSlider'`

## License

KJCategories is available under the MIT license. See the LICENSE file for more info.
