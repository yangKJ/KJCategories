//
//  KJOpencvType.h
//  KJEmitterView
//
//  Created by 杨科军 on 2021/3/20.
//  https://github.com/YangKJ/KJCategories
//  枚举文件夹

#ifndef KJOpencvType_h
#define KJOpencvType_h

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
//  A ---- B
//  |      |
//  |      |
//  D ---- C
// 透视选区四点，样式如上
typedef struct KJKnownPoints {
    CGPoint PointA;
    CGPoint PointB;
    CGPoint PointC;
    CGPoint PointD;
} KJKnownPoints;
// 线条，start -> end
typedef struct KJLine {
    CGPoint start;
    CGPoint end;
} KJLine;
NS_INLINE KJLine KJLineMake(CGPoint start, CGPoint end){
    KJLine line;
    line.start = start;
    line.end = end;
    return line;
}
NS_INLINE CGPoint kPoint(CGFloat x, CGFloat y){
    return CGPointMake(x, y);
}
NS_INLINE KJKnownPoints KJKnownPointsMake(CGPoint A, CGPoint B, CGPoint C, CGPoint D){
    KJKnownPoints points;
    points.PointA = A;
    points.PointB = B;
    points.PointC = C;
    points.PointD = D;
    return points;
}
/// 形态学操作
typedef NS_ENUM(NSInteger, KJOpencvMorphologyStyle) {
    KJOpencvMorphologyStyleOPEN = 0,/// 开操作，先腐蚀后膨胀，可以去掉小的对象
    KJOpencvMorphologyStyleCLOSE,   /// 闭操作，先膨胀后腐蚀，可以填补小洞
    KJOpencvMorphologyStyleGRADIENT,/// 形态学梯度，膨胀减去腐蚀
    KJOpencvMorphologyStyleTOPHAT,  /// 顶帽，源图像与开操作之间的差值
    KJOpencvMorphologyStyleBLACKHAT /// 黑帽，闭操作与源图像之间的差值
};

#endif /* KJOpencvType_h */
NS_ASSUME_NONNULL_END
