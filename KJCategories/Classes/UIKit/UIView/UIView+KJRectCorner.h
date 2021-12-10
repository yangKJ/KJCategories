//
//  UIView+KJRectCorner.h
//  CategoryDemo
//
//  Created by 77。 on 2018/7/12.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_OPTIONS(NSInteger, KJBorderOrientationType) {
    KJBorderOrientationTypeUnknown = 1 << 0,/// unknown edge
    KJBorderOrientationTypeTop = 1 << 1,    /// top
    KJBorderOrientationTypeBottom = 1 << 2, /// bottom
    KJBorderOrientationTypeLeft = 1 << 3,   /// left
    KJBorderOrientationTypeRight = 1 << 4,  /// right
};
@interface UIView (KJRectCorner)

#pragma mark - Advanced rounded corners and border extension

/// Fillet radius, default 5px
@property (nonatomic, assign) CGFloat kj_radius;
/// Rounded corner orientation
@property (nonatomic, assign) UIRectCorner kj_rectCorner;

/// Border color, default black
@property (nonatomic, strong) UIColor *kj_borderColor;
/// Border width, default 1px
@property (nonatomic, assign) CGFloat kj_borderWidth;
/// Border position, required parameter
@property (nonatomic, assign) KJBorderOrientationType kj_borderOrientation;

/// Dotted border
/// @param lineColor line color
/// @param lineWidth line width
/// @param spaceAry array of intervals between lines
- (void)kj_dashedLineColor:(UIColor *)lineColor
                 lineWidth:(CGFloat)lineWidth
                spaceArray:(NSArray<NSNumber*>*)spaceAry;

#pragma mark - Gradient related

/// Gradient layer
/// @param colors gradient color array
/// @param frame The size of the gradient
/// @param locations The dividing point of the gradient color
/// @param startPoint start coordinates, the range is between (0,0) and (1,1), such as (0,0)(1,0) represents the horizontal gradient, (0,0)(0,1) ) Represents a vertical gradient
/// @param endPoint end coordinates
/// @return Return to the gradient layer
- (CAGradientLayer *)kj_gradientLayerWithColors:(NSArray *)colors
                                          frame:(CGRect)frame
                                      locations:(NSArray *)locations
                                     startPoint:(CGPoint)startPoint
                                       endPoint:(CGPoint)endPoint;

/// Generate gradient background color
/// @param colors gradient color array
/// @param locations The dividing point of the gradient color
/// @param startPoint start coordinates
/// @param endPoint end coordinates
- (void)kj_gradientBgColorWithColors:(NSArray *)colors
                           locations:(NSArray *)locations
                          startPoint:(CGPoint)startPoint
                            endPoint:(CGPoint)endPoint;

#pragma mark - Specify graphics

/// Draw a straight line
- (void)kj_DrawLineWithPoint:(CGPoint)fPoint
                     toPoint:(CGPoint)tPoint
                   lineColor:(UIColor *)color
                   lineWidth:(CGFloat)width;

/// Draw a dotted line
- (void)kj_DrawDashLineWithPoint:(CGPoint)fPoint
                         toPoint:(CGPoint)tPoint
                       lineColor:(UIColor *)color
                       lineWidth:(CGFloat)width
                       lineSpace:(CGFloat)space
                        lineType:(NSInteger)type;

/// Draw a five-pointed star
- (void)kj_DrawPentagramWithCenter:(CGPoint)center
                            radius:(CGFloat)radius
                             color:(UIColor *)color
                              rate:(CGFloat)rate;

/// Draw a hexagon according to the width and height
- (void)kj_DrawSexangleWithWidth:(CGFloat)width
                       LineWidth:(CGFloat)lineWidth
                     StrokeColor:(UIColor *)color
                       FillColor:(UIColor *)fcolor;

/// Draw an octagon according to the width and height
- (void)kj_DrawOctagonWithWidth:(CGFloat)width
                         Height:(CGFloat)height
                      LineWidth:(CGFloat)lineWidth
                    StrokeColor:(UIColor *)color
                      FillColor:(UIColor *)fcolor
                             Px:(CGFloat)px
                             Py:(CGFloat)py;

@end

NS_ASSUME_NONNULL_END
