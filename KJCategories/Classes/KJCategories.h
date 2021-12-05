// KJCategories.h
//
// Copyright (c) 2021 Zz <ykj310@126.com>
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


// 机器猫工具库，就像机器猫的口袋一样有无穷无尽意想不到的的各种道具供我们使用

// 该库是从之前`KJEmitterView`当中独立拆解出来使用，后续有相关也会慢慢补充..
// 觉得有帮助的老哥，请帮忙点个星⭐..
// 传送门：https://github.com/YangKJ/KJCategories <备注：快捷打开浏览器命令，command + 鼠标左键>

#import <Foundation/Foundation.h>

#import "KJCategories.h"

//! Project version number for KJCategories.
FOUNDATION_EXPORT double KJCategoriesVersionNumber;

//! Project version string for KJCategories.
FOUNDATION_EXPORT const unsigned char KJCategoriesVersionString[];

// In this header, you should import all the public headers of your framework
// using statements like #import <KJCategories/KJCategories.h>
// or @import KJCategories;

//************ UIKit/Foundation 高频使用分类 ************
#if __has_include(<KJCategories/KJCoreHeader.h>)
#import <KJCategories/KJCoreHeader.h>
#elif __has_include("KJCoreHeader.h")
#import "KJCoreHeader.h"
#else
#endif

//************ UIKit功能分类模块 ************
//    pod 'KJCategories/Kit'
#if __has_include(<KJCategories/KJUIKitHeader.h>)
#import <KJCategories/KJUIKitHeader.h>
#elif __has_include("KJUIKitHeader.h")
#import "KJUIKitHeader.h"
#else
#endif

//************ Foundation功能分类模块 ************
//    pod 'KJCategories/Foundation'
#if __has_include(<KJCategories/KJFoundationHeader.h>)
#import <KJCategories/KJFoundationHeader.h>
#elif __has_include("KJFoundationHeader.h")
#import "KJFoundationHeader.h"
#else
#endif

//************ OpenCV功能分类模块 ************
//    pod 'KJCategories/Opencv'
#if __has_include(<KJCategories/UIImage+KJOpencv.h>)
#import <KJCategories/UIImage+KJOpencv.h>
#elif __has_include("UIImage+KJOpencv.h")
#import "UIImage+KJOpencv.h"
#else
#endif

//************ 自定义控件模块 ************
//    pod 'KJCategories/CustomControl'
#if __has_include(<KJCategories/KJCustomControlHeader.h>)
#import <KJCategories/KJCustomControlHeader.h>
#elif __has_include("KJCustomControlHeader.h")
#import "KJCustomControlHeader.h"
#else
#endif
