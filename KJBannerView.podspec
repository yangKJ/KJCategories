Pod::Spec.new do |s|
  s.name         = "KJBannerView"
  s.version      = "1.2.3"
  s.summary      = "Banner"
  s.homepage     = "https://github.com/yangKJ/KJBannerViewDemo"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.license      = "Copyright (c) 2018 yangkejun"
  s.author       = { "77" => "393103982@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yangKJ/KJBannerViewDemo.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://www.jianshu.com/u/c84c00476ab6'
  s.requires_arc = true
  
  s.ios.source_files = 'KJBannerViewDemo/KJBannerHeader.h' # 添加头文件

  s.subspec 'KJBannerView' do |ss|
    ss.source_files = "KJBannerViewDemo/KJBannerView/*.{h,m}" # 添加文件
    ss.resources = "KJBannerViewDemo/KJBannerView/*.{bundle}" # 添加数据资料
  end

  s.frameworks = 'Foundation','UIKit'
  
end


