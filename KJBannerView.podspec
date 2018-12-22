Pod::Spec.new do |s|
  s.name         = "KJBannerView"
  s.version      = "0.0.1"
  s.summary      = "Some iOS Emitter"
  s.homepage     = "https://github.com/yangKJ/KJBannerViewDemo"
  s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.license      = "Copyright (c) 2018 yangkejun"
  s.author       = { "77" => "393103982@qq.com" }
  s.platform     = :ios
  s.source       = { :git => "https://github.com/yangKJ/KJBannerViewDemo.git", :tag => "#{s.version}" }
  s.social_media_url = 'https://www.jianshu.com/u/c84c00476ab6'
  s.requires_arc = true
  
  
  s.subspec 'Classes' do |ss|
    ss.source_files = "KJBannerViewDemo/Classes/**/*.{h,m}" # 添加文件
    ss.public_header_files = "KJBannerViewDemo/Classes/**/*.h",'KJBannerViewDemo/Classes/*.h'# 添加头文件
  end

  s.frameworks = 'Foundation','UIKit','CommonCrypto'
  
end


