//
//  UIBezierPath+KJPoints.h
//  AutoDecorate
//
//  Created by 77。 on 2019/7/8.
//  Copyright © 2020 songxf. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (KJPoints)

/// Get all points
@property (nonatomic, strong, readonly) NSArray *points;

/// Smooth Bezier curve
/// @param granularity roundness
- (UIBezierPath *)kj_smoothedPathWithGranularity:(int)granularity;

@end

NS_ASSUME_NONNULL_END
