#
# Be sure to run `pod lib lint KJCategories.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KJCategories'
  s.version          = '1.0.4'
  s.summary          = '🎸🎸🎸 Common categories for daily development. Such as UIKit, Foundation, OpenCV and more.'
  
  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  
  s.homepage         = 'https://github.com/yangKJ/KJCategories'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yangkejun' => 'ykj310@126.com' }
  s.source           = { :git => 'https://github.com/yangKJ/KJCategories.git', :tag => "#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  
  s.platform = :ios
  s.swift_version = '5.0'
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.static_framework = true
  s.frameworks = "UIKit", "Foundation"
  
  s.default_subspec  = "Core"
  s.ios.source_files = "Sources/KJCategories.h"
  
  s.subspec 'Core' do |xx|
    xx.source_files = "Sources/Core/KJCoreHeader.h"
    xx.subspec 'UIKit' do |xxx|
      xxx.source_files = "Sources/Core/UIKit/**/*.{h,m}"
    end
    xx.subspec 'Foundation' do |xxx|
      xxx.source_files = "Sources/Core/Foundation/**/*.{h,m}"
    end
  end
  
  s.subspec 'Opencv' do |xx|
    xx.source_files = "Sources/Opencv/**/*.{h,mm}"
    xx.dependency 'OpenCV', "~> 4.1.0"
    xx.pod_target_xcconfig  = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
    xx.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  end
  
  s.subspec 'UIKit' do |xx|
    xx.source_files = "Sources/UIKit/KJUIKitHeader.h"
    xx.subspec 'UIBezierPath' do |xxx|
      xxx.source_files = "Sources/UIKit/UIBezierPath/*.{h,m}"
    end
    xx.subspec 'UIButton' do |xxx|
      xxx.source_files = "Sources/UIKit/UIButton/*.{h,m}"
    end
    xx.subspec 'UICollectionView' do |xxx|
      xxx.source_files = "Sources/UIKit/UICollectionView/*.{h,m}"
    end
    xx.subspec 'UIColor' do |xxx|
      xxx.source_files = "Sources/UIKit/UIColor/*.{h,m}"
    end
    xx.subspec 'UIDevice' do |xxx|
      xxx.source_files = "Sources/UIKit/UIDevice/*.{h,m}"
    end
    xx.subspec 'UIImage' do |xxx|
      xxx.source_files = "Sources/UIKit/UIImage/*.{h,m}"
    end
    xx.subspec 'UILabel' do |xxx|
      xxx.source_files = "Sources/UIKit/UILabel/*.{h,m}"
    end
    xx.subspec 'UINavigation' do |xxx|
      xxx.source_files = "Sources/UIKit/UINavigation/*.{h,m}"
    end
    xx.subspec 'UIResponder' do |xxx|
      xxx.source_files = "Sources/UIKit/UIResponder/*.{h,m}"
    end
    xx.subspec 'UIScrollView' do |xxx|
      xxx.source_files = "Sources/UIKit/UIScrollView/*.{h,m}"
      xxx.dependency 'DZNEmptyDataSet'
    end
    xx.subspec 'UISlider' do |xxx|
      xxx.source_files = "Sources/UIKit/UISlider/*.{h,m}"
    end
    xx.subspec 'UITabBar' do |xxx|
      xxx.source_files = "Sources/UIKit/UITabBar/*.{h,m}"
    end
    xx.subspec 'UITextView' do |xxx|
      xxx.source_files = "Sources/UIKit/UITextView/*.{h,m}"
    end
    xx.subspec 'UIView' do |xxx|
      xxx.source_files = "Sources/UIKit/UIView/*.{h,m}"
    end
    xx.subspec 'UIViewController' do |xxx|
      xxx.source_files = "Sources/UIKit/UIViewController/*.{h,m}"
    end
  end
  
  s.subspec 'Foundation' do |xx|
    xx.source_files = "Sources/Foundation/KJFoundationHeader.h"
    xx.subspec 'NSArray' do |xxx|
      xxx.source_files = "Sources/Foundation/NSArray/*.{h,m}"
    end
    xx.subspec 'NSData' do |xxx|
      xxx.source_files = "Sources/Foundation/NSData/*.{h,m}"
    end
    xx.subspec 'NSDate' do |xxx|
      xxx.source_files = "Sources/Foundation/NSDate/*.{h,m}"
    end
    xx.subspec 'NSDictionary' do |xxx|
      xxx.source_files = "Sources/Foundation/NSDictionary/*.{h,m}"
    end
    xx.subspec 'NSNumber' do |xxx|
      xxx.source_files = "Sources/Foundation/NSNumber/*.{h,m}"
    end
    xx.subspec 'NSObject' do |xxx|
      xxx.source_files = "Sources/Foundation/NSObject/*.{h,m}"
    end
    xx.subspec 'NSString' do |xxx|
      xxx.source_files = "Sources/Foundation/NSString/*.{h,m}"
    end
    xx.subspec 'NSTimer' do |xxx|
      xxx.source_files = "Sources/Foundation/NSTimer/*.{h,m}"
    end
  end
  
  s.subspec 'Customized' do |xx|
    xx.source_files = "Sources/Customized/KJCustomizedHeader.h"
    ## Rainbow gradient slider
    xx.subspec 'GradientSlider' do |xxx|
      xxx.source_files = "Sources/Customized/GradientSlider/*.{h,m}"
    end
    ## Open screen particle animation
    xx.subspec 'EmitterAnimation' do |xxx|
      xxx.source_files = "Sources/Customized/EmitterAnimation/*.{h,m}"
    end
    xx.subspec 'ProjectionView' do |xxx|
      xxx.source_files = "Sources/Customized/ProjectionView/*.swift"
    end
    ## Shine view
    xx.subspec 'ShadowView' do |xxx|
      xxx.source_files = "Sources/Customized/ShadowView/*.swift"
    end
  end
  
end
