//
//  UIImage+KJDoraemonBox.h
//  KJEmitterView
//
//  Created by 77。 on 2018/12/1.
//  Copyright © 2018 77。. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (KJDoraemonBox)

/// Get the average color of the picture
- (UIColor *)kj_getImageAverageColor;

/// Get grayscale image
- (UIImage *)kj_getGrayImage;

/// Draw pictures
- (UIImage *)kj_mallocDrawImage;

/// Click through the transparent area of ​​the picture
/// @param point point coordinates
- (bool)kj_transparentWithPoint:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
