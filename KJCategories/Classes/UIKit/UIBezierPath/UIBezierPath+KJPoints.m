//
//  UIBezierPath+KJPoints.m
//  AutoDecorate
//
//  Created by 77。 on 2019/7/8.
//  Copyright © 2020 songxf. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "UIBezierPath+KJPoints.h"

@implementation UIBezierPath (KJPoints)

- (NSArray *)points{
    NSMutableArray *temps = [NSMutableArray array];
    CGPathApply(self.CGPath, (__bridge void *)temps, kGetBezierPathPoints);
    return temps.mutableCopy;
}
static void kGetBezierPathPoints(void *info, const CGPathElement * element){
    NSMutableArray *bezierPoints = (__bridge NSMutableArray *)info;
    CGPathElementType type = element->type;
    CGPoint *points = element->points;
    if (type != kCGPathElementCloseSubpath) {
        [bezierPoints addObject:[NSValue valueWithCGPoint:points[0]]];
        if ((type != kCGPathElementAddLineToPoint) && (type != kCGPathElementMoveToPoint)) {
            [bezierPoints addObject:[NSValue valueWithCGPoint:points[1]]];
        }
    }
    if (type == kCGPathElementAddCurveToPoint) {
        [bezierPoints addObject:[NSValue valueWithCGPoint:points[2]]];
    }
}
/// 圆滑贝塞尔曲线
- (UIBezierPath *)kj_smoothedPathWithGranularity:(int)granularity{
    NSArray * points = self.points;
    if (points.count < 4) return self;
    
    CGPoint(^kPOINT)(NSUInteger) = ^CGPoint(NSUInteger index){
        return [(NSValue *)[points objectAtIndex:index] CGPointValue];
    };
    UIBezierPath *smoothedPath = [UIBezierPath bezierPath];
    smoothedPath.lineWidth = self.lineWidth;
    [smoothedPath moveToPoint:kPOINT(0)];
    [smoothedPath addLineToPoint:kPOINT(1)];
    for (int index = 3; index < points.count; index ++) {
        CGPoint p0 = kPOINT(index - 3);
        CGPoint p1 = kPOINT(index - 2);
        CGPoint p2 = kPOINT(index - 1);
        CGPoint p3 = kPOINT(index);
        for (int i = 1; i < granularity; i++) {
            float t = (float)i * (1.0 / granularity);
            float tt = t * t;
            float ttt = tt * t;
            CGPoint pi;
            pi.x = 0.5 * ( 2*p1.x + (p2.x-p0.x)*t + (2*p0.x-5*p1.x+4*p2.x-p3.x)*tt + (3*p1.x-p0.x-3*p2.x+p3.x)*ttt );
            pi.y = 0.5 * ( 2*p1.y + (p2.y-p0.y)*t + (2*p0.y-5*p1.y+4*p2.y-p3.y)*tt + (3*p1.y-p0.y-3*p2.y+p3.y)*ttt );
            [smoothedPath addLineToPoint:pi];
        }
        [smoothedPath addLineToPoint:p2];
    }
    [smoothedPath addLineToPoint:kPOINT(points.count - 1)];
    return smoothedPath;
}

@end
