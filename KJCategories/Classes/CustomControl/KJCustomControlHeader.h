//
//  KJCustomControlHeader.h
//  Pods
//
//  Created by abas on 2021/11/21.
//  https://github.com/YangKJ/KJCategories
//  自定义控件模块，支持分模块导入

//  举个例子导入`渐变色滑杆模块`，pod 'KJCategories/CustomControl/GradientSlider'

#ifndef KJCustomControlHeader_h
#define KJCustomControlHeader_h

//********************** 渐变色滑杆 **********************
#if __has_include(<KJCategories/KJGradientSlider.h>)
#import <KJCategories/KJGradientSlider.h>
#elif __has_include("KJGradientSlider.h")
#import "KJGradientSlider.h"
#else
#endif

//********************** 开屏粒子动画 **********************
#if __has_include(<KJCategories/KJEmitterAnimation.h>)
#import <KJCategories/KJEmitterAnimation.h>
#elif __has_include("KJEmitterAnimation.h")
#import "KJEmitterAnimation.h"
#else
#endif

#endif /* KJCustomControlHeader_h */
