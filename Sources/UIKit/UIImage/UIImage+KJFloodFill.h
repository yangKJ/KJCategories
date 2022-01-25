//
//  UIImage+FloodFill.h
//  KJEmitterView
//
//  Created by 77。 on 2018/12/1.
//  Copyright © 2018 77。. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef struct KJPointNode{
    NSInteger value;
    NSInteger nextNodeOffset;
}KJPointNode;

@interface KJNodeQueue : NSObject<NSCopying>

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

- (instancetype)initWithCapacity:(NSInteger)capacity
                      Increments:(NSInteger)increments
                      Multiplier:(NSInteger)multiplier;

/// The node is pushed into the stack
- (void)kj_pushNodeWithX:(NSInteger)x PushY:(NSInteger)y;

/// The node is popped from the stack, and return whether the pop-up is finished
- (bool)kj_popNodeWithX:(NSInteger*)x PopY:(NSInteger*)y;

@end

/// https://lodev.org/cgtutor/floodfill.html
@interface UIImage (KJFloodFill)

/// Based on the flooding algorithm of the scan line, get the picture after filling the same color area
/// @param startPoint start coordinate point
/// @param newColor fill the image color
/// @param tolerance Judge the tolerance value of the same adjacent color
/// @param antialias whether antialiasing
/// @return returns the filled image
- (UIImage *)kj_FloodFillImageFromStartPoint:(CGPoint)startPoint
                                    NewColor:(UIColor *)newColor
                                   Tolerance:(CGFloat)tolerance
                                UseAntialias:(BOOL)antialias;

@end

NS_ASSUME_NONNULL_END
