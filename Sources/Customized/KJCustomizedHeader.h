//
//  KJCustomizedHeader.h
//  Pods
//
//  Created by yangkejun on 2021/11/21.
//  https://github.com/YangKJ/KJCategories
//  Custom control module, support sub-module import

//  Example import `GradientSlider`:
//  pod 'KJCategories/Customized/GradientSlider'

#ifndef KJCustomizedHeader_h
#define KJCustomizedHeader_h

#if __has_include(<KJCategories/KJGradientSlider.h>)
#import <KJCategories/KJGradientSlider.h>
#elif __has_include("KJGradientSlider.h")
#import "KJGradientSlider.h"
#else
#endif

#if __has_include(<KJCategories/KJEmitterAnimation.h>)
#import <KJCategories/KJEmitterAnimation.h>
#elif __has_include("KJEmitterAnimation.h")
#import "KJEmitterAnimation.h"
#else
#endif

#endif /* KJCustomizedHeader_h */
