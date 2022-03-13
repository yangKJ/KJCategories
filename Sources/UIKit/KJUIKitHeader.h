//
//  KJUIKitHeader.h
//  KJCategories
//
//  Created by 77。 on 2021/11/7.
//  https://github.com/YangKJ/KJCategories

//  Example import `UIBezierPath`:
//  pod 'KJCategories/KitExtension/UIBezierPath'

#ifndef KJUIKitHeader_h
#define KJUIKitHeader_h

#if __has_include(<KJCategories/UIBezierPath+KJPoints.h>)
#import <KJCategories/UIBezierPath+KJPoints.h>
#import <KJCategories/UIBezierPath+KJText.h>
#elif __has_include("UIBezierPath+KJPoints.h")
#import "UIBezierPath+KJPoints.h"
#import "UIBezierPath+KJText.h"
#else
#endif

#if __has_include(<KJCategories/UIButton+KJEmitter.h>)
#import <KJCategories/UIButton+KJEmitter.h>
#import <KJCategories/UIButton+KJCountDown.h>
#import <KJCategories/UIButton+KJIndicator.h>
#elif __has_include("UIButton+KJEmitter.h")
#import "UIButton+KJEmitter.h"
#import "UIButton+KJCountDown.h"
#import "UIButton+KJIndicator.h"
#else
#endif

#if __has_include(<KJCategories/UICollectionView+KJTouch.h>)
#import <KJCategories/UICollectionView+KJTouch.h>
#elif __has_include("UICollectionView+KJTouch.h")
#import "UICollectionView+KJTouch.h"
#else
#endif

#if __has_include(<KJCategories/UIColor+KJExtension2.h>)
#import <KJCategories/UIColor+KJExtension2.h>
#elif __has_include("UIColor+KJExtension2.h")
#import "UIColor+KJExtension2.h"
#else
#endif

#if __has_include(<KJCategories/UIDevice+KJSystem.h>)
#import <KJCategories/UIDevice+KJSystem.h>
#elif __has_include("UIDevice+KJSystem.h")
#import "UIDevice+KJSystem.h"
#else
#endif

#if __has_include(<KJCategories/UIImage+KJDoraemonBox.h>)
#import <KJCategories/UIImage+KJDoraemonBox.h>
#import <KJCategories/UIImage+KJAccelerate.h>
#import <KJCategories/UIImage+KJCompress.h>
#import <KJCategories/UIImage+KJCoreImage.h>
#import <KJCategories/UIImage+KJFloodFill.h>
#import <KJCategories/UIImage+KJGIF.h>
#import <KJCategories/UIImage+KJJoint.h>
#import <KJCategories/UIImage+KJMask.h>
#import <KJCategories/UIImage+KJQRCode.h>
#elif __has_include("UIImage+KJDoraemonBox.h")
#import "UIImage+KJDoraemonBox.h"
#import "UIImage+KJAccelerate.h"
#import "UIImage+KJCompress.h"
#import "UIImage+KJCoreImage.h"
#import "UIImage+KJFloodFill.h"
#import "UIImage+KJGIF.h"
#import "UIImage+KJJoint.h"
#import "UIImage+KJMask.h"
#import "UIImage+KJQRCode.h"
#else
#endif

#if __has_include(<KJCategories/UILabel+KJExtension2.h>)
#import <KJCategories/UILabel+KJExtension2.h>
#import <KJCategories/UILabel+KJAttributeTextTapAction.h>
#elif __has_include("UILabel+KJExtension2.h")
#import "UILabel+KJExtension2.h"
#import "UILabel+KJAttributeTextTapAction.h"
#else
#endif

#if __has_include(<KJCategories/UINavigationBar+KJExtension.h>)
#import <KJCategories/UINavigationBar+KJExtension.h>
#import <KJCategories/UINavigationItem+KJExtension.h>
#elif __has_include("UINavigationBar+KJExtension.h")
#import "UINavigationBar+KJExtension.h"
#import "UINavigationItem+KJExtension.h"
#else
#endif

#if __has_include(<KJCategories/UIResponder+KJAdapt.h>)
#import <KJCategories/UIResponder+KJAdapt.h>
#elif __has_include("UIResponder+KJAdapt.h")
#import "UIResponder+KJAdapt.h"
#else
#endif

#if __has_include(<KJCategories/UISlider+KJTapValue.h>)
#import <KJCategories/UISlider+KJTapValue.h>
#elif __has_include("UISlider+KJTapValue.h")
#import "UISlider+KJTapValue.h"
#else
#endif

#if __has_include(<KJCategories/UITabBar+KJBadge.h>)
#import <KJCategories/UITabBar+KJBadge.h>
#elif __has_include("UITabBar+KJBadge.h")
#import "UITabBar+KJBadge.h"
#else
#endif

#if __has_include(<KJCategories/UITextView+KJLimitCounter.h>)
#import <KJCategories/UITextView+KJLimitCounter.h>
#import <KJCategories/UITextView+KJHyperlink.h>
#import <KJCategories/UITextView+KJBackout.h>
#elif __has_include("UITextView+KJLimitCounter.h")
#import "UITextView+KJLimitCounter.h"
#import "UITextView+KJHyperlink.h"
#import "UITextView+KJBackout.h"
#else
#endif

#if __has_include(<KJCategories/UIView+KJAnimation.h>)
#import <KJCategories/UIView+KJAnimation.h>
#import <KJCategories/UIView+KJRectCorner.h>
#import <KJCategories/UIView+KJKeyboard.h>
#elif __has_include("UIView+KJAnimation.h")
#import "UIView+KJAnimation.h"
#import "UIView+KJRectCorner.h"
#import "UIView+KJKeyboard.h"
#else
#endif

#if __has_include(<KJCategories/UIViewController+KJFullScreen.h>)
#import <KJCategories/UIViewController+KJFullScreen.h>
#elif __has_include("UIViewController+KJFullScreen.h")
#import "UIViewController+KJFullScreen.h"
#else
#endif

#endif /* KJUIKitHeader_h */
