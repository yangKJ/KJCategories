//
//  UIImage+FloodFill.m
//  KJEmitterView
//
//  Created by 77。 on 2018/12/1.
//  Copyright © 2018 77。. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "UIImage+KJFloodFill.h"

@implementation UIImage (KJFloodFill)
/// 基于扫描线的泛洪算法，获取填充同颜色区域后的图片
- (UIImage *)kj_FloodFillImageFromStartPoint:(CGPoint)startPoint
                                    NewColor:(UIColor *)newColor
                                   Tolerance:(CGFloat)tolerance
                                UseAntialias:(BOOL)antialias{
    if (!self.CGImage || !newColor) return self;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGImageRef imageRef = self.CGImage;
    NSUInteger width = CGImageGetWidth(imageRef);
    NSUInteger height = CGImageGetHeight(imageRef);
    NSUInteger bitsPerComponent = CGImageGetBitsPerComponent(imageRef);
    NSUInteger bytesPerPixel = CGImageGetBitsPerPixel(imageRef) / bitsPerComponent;
    NSUInteger bytesPerRow = CGImageGetBytesPerRow(imageRef);
    unsigned char *imageData = malloc(height * bytesPerRow);
    CGBitmapInfo bitmapInfo = CGImageGetBitmapInfo(imageRef);
    if (kCGImageAlphaLast == (uint32_t)bitmapInfo || kCGImageAlphaFirst == (uint32_t)bitmapInfo) {
        bitmapInfo = (uint32_t)kCGImageAlphaPremultipliedLast;
    }
    CGContextRef context = CGBitmapContextCreate(imageData,
                                                 width,
                                                 height,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 bitmapInfo);
    CGColorSpaceRelease(colorSpace);
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
    NSUInteger byteIndex = roundf(startPoint.x) * bytesPerPixel + roundf(startPoint.y) * bytesPerRow;
    NSUInteger statrColor = getColorCode(byteIndex, imageData);
    NSUInteger red, green, blue, alpha = 0;
    const CGFloat *components = CGColorGetComponents(newColor.CGColor);
    if (CGColorGetNumberOfComponents(newColor.CGColor) == 2) {
        red = green = blue  = components[0] * 255;
        alpha = components[1] * 255;
    } else {
        red   = components[0] * 255;
        green = components[1] * 255;
        blue  = components[2] * 255;
        alpha = components[3] * 255;
    }
    NSUInteger nColor = red << 24 | green << 16 | blue << 8 | alpha;
    if (compareColor(statrColor, nColor, 0)) {
        CGContextRelease(context);
        return self;
    }
    
    // 开始点入栈
    KJNodeQueue *points = [[KJNodeQueue alloc] initWithCapacity:500 Increments:500 Multiplier:height];
    [points kj_pushNodeWithX:roundf(startPoint.x) PushY:roundf(startPoint.y)];
    
    // 抗锯齿化处理
    void (^kAntialias)(NSUInteger,NSUInteger) = ^(NSUInteger pointX, NSUInteger pointY) {
        NSUInteger byteIndex = bytesPerPixel * pointX + bytesPerRow * pointY;
        if (getColorCode(byteIndex, imageData) != nColor) antiAliasOperation(byteIndex, imageData, nColor);
    };
    
    NSInteger color;
    BOOL panLeft, panRight;
    NSInteger x, y;
    while ([points kj_popNodeWithX:&x PopY:&y]) {// 循环到栈内无节点
        byteIndex = bytesPerPixel * x + bytesPerRow * y;
        color = getColorCode(byteIndex, imageData);
        while (y >= 0 && compareColor(statrColor, color, tolerance)) {
            --y;
            if (y >= 0) {
                byteIndex = bytesPerPixel * x + bytesPerRow * y;
                color = getColorCode(byteIndex, imageData);
            }
        }
        ++y;
        byteIndex = bytesPerPixel * x + bytesPerRow * y;
        color = getColorCode(byteIndex, imageData);
        panLeft = panRight = false;
        while (y < height && compareColor(statrColor, color, tolerance) && color != nColor) {
            imageData[byteIndex] = red;
            imageData[byteIndex + 1] = green;
            imageData[byteIndex + 2] = blue;
            imageData[byteIndex + 3] = alpha;
            if (x > 0) {
                byteIndex = bytesPerPixel * (x - 1) + bytesPerRow * y;
                color = getColorCode(byteIndex, imageData);
                if (!panLeft && compareColor(statrColor, color, tolerance) && color != nColor) { // 左侧点入栈
                    [points kj_pushNodeWithX:x - 1 PushY:y];
                    panLeft = true;
                } else if (panLeft && !compareColor(statrColor, color, tolerance)) {
                    panLeft = false;
                }
            }
            if (x < width - 1) {
                byteIndex = bytesPerPixel * (x + 1) + bytesPerRow * y;
                color = getColorCode(byteIndex, imageData);
                if (!panRight && compareColor(statrColor, color, tolerance) && color != nColor) { // 右侧点入栈
                    [points kj_pushNodeWithX:x + 1 PushY:y];
                    panRight = true;
                } else if (panRight && !compareColor(statrColor, color, tolerance)){
                    panRight = false;
                }
            }
            ++y;
            if (y < height) {
                byteIndex = bytesPerPixel * x + bytesPerRow * y;
                color = getColorCode(byteIndex, imageData);
            }
            
            if (antialias) {
                if (x <= 0) kAntialias(x-1, y);
                if (x >= width) kAntialias(x+1, y);
                if (y <= 0) kAntialias(x, y-1);
                if (y >= height) kAntialias(x, y+1);
            }
        }
    }
    
    imageRef = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    UIImage *newImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    free(imageData);
    return newImage;
}

#pragma mark - 内部方法
/// 将RGBA转为NSUInteger
static NSUInteger getColorCode(NSUInteger byteIndex, unsigned char *imageData) {
//    if (imageData == NULL || strlen(imageData) == 0) return 0;
    NSUInteger red   = imageData[byteIndex];
    NSUInteger green = imageData[byteIndex + 1];
    NSUInteger blue  = imageData[byteIndex + 2];
    NSUInteger alpha = imageData[byteIndex + 3];
    return red << 24 | green << 16 | blue << 8 | alpha;
}
/// 对比两种颜色是否在容差内
static BOOL compareColor(NSUInteger color1, NSUInteger color2, NSInteger tolerance) {
    if(color1 == color2) return true;
    NSInteger red1   = ((0xff000000 & color1) >> 24);
    NSInteger green1 = ((0x00ff0000 & color1) >> 16);
    NSInteger blue1  = ((0x0000ff00 & color1) >> 8);
    NSInteger alpha1 = ((0x000000ff & color1));
    
    NSInteger red2   = ((0xff000000 & color2) >> 24);
    NSInteger green2 = ((0x00ff0000 & color2) >> 16);
    NSInteger blue2  = ((0x0000ff00 & color2) >> 8);
    NSInteger alpha2 = ((0x000000ff & color2));
    
    NSInteger diffRed   = labs(red2   - red1);
    NSInteger diffGreen = labs(green2 - green1);
    NSInteger diffBlue  = labs(blue2  - blue1);
    NSInteger diffAlpha = labs(alpha2 - alpha1);
    
    if (diffRed > tolerance || diffGreen > tolerance || diffBlue > tolerance || diffAlpha > tolerance){
        return false;
    }
    return true;
}
/// 抗锯齿化
static void antiAliasOperation(NSUInteger byteIndex, unsigned char *imageData, NSUInteger blendedColor) {
//    if (imageData == NULL || strlen(imageData) == 0) return;
    
    NSInteger red1   = ((0xff000000 & blendedColor) >> 24);
    NSInteger green1 = ((0x00ff0000 & blendedColor) >> 16);
    NSInteger blue1  = ((0x0000ff00 & blendedColor) >> 8);
    NSInteger alpha1 = ((0x000000ff & blendedColor));
    
    NSInteger red2   = imageData[byteIndex];
    NSInteger green2 = imageData[byteIndex + 1];
    NSInteger blue2  = imageData[byteIndex + 2];
    NSInteger alpha2 = imageData[byteIndex + 3];
    
    imageData[byteIndex]     = (red1 + red2) / 2;
    imageData[byteIndex + 1] = (green1 + green2) / 2;
    imageData[byteIndex + 2] = (blue1 + blue2) / 2;
    imageData[byteIndex + 3] = (alpha1 + alpha2) / 2;
}

@end

@implementation KJNodeQueue{
    NSMutableData *nodeCache;
    NSInteger _topNodeOffset, _freeNodeOffset;
    NSInteger _increments, _multiplier;
}
static const int8_t kFinallyNodeOffset = -1;
- (instancetype)copyWithZone:(NSZone*)zone{
    return [[KJNodeQueue allocWithZone:zone] init];
}
- (instancetype)init{
    return [self initWithCapacity:500 Increments:500 Multiplier:1000];
}
- (instancetype)initWithCapacity:(NSInteger)capacity Increments:(NSInteger)increments Multiplier:(NSInteger)multiplier{
    if (self = [super init]) {
        nodeCache = [NSMutableData dataWithLength:capacity * sizeof(KJPointNode)];
        _increments = increments;
        _multiplier = multiplier;
        _topNodeOffset = kFinallyNodeOffset;
        _freeNodeOffset = 0;
        [self initNodeWithCount:capacity];
    }
    return self;
}
/// 节点入栈
- (void)kj_pushNodeWithX:(NSInteger)x PushY:(NSInteger)y{
    KJPointNode *node = [self nextFreeNode];
    node->value = x * _multiplier + y;
    node->nextNodeOffset = _topNodeOffset;
    _topNodeOffset = [self offsetOfNode:node];
}
/// 节点出栈，返回是否出完
- (bool)kj_popNodeWithX:(NSInteger*)x PopY:(NSInteger*)y{
    if (_topNodeOffset == kFinallyNodeOffset) return false;
    KJPointNode *topNode = [self nodeOfOffset:_topNodeOffset];
    NSInteger value = topNode->value;
    NSInteger nextNodeOffset = topNode->nextNodeOffset;
    topNode->value = 0;
    topNode->nextNodeOffset = _freeNodeOffset;
    _freeNodeOffset = _topNodeOffset;
    _topNodeOffset = nextNodeOffset;
    *x = value / _multiplier;
    *y = value % _multiplier;
    return value == INT_MIN ? false : true;
}

#pragma mark - Private
/// 初始化节点
- (void)initNodeWithCount:(NSInteger)count{
    KJPointNode *node = (KJPointNode*)nodeCache.mutableBytes + _freeNodeOffset;
    for (int i = 0; i < count - 1; i++) {
        node->value = 0;
        node->nextNodeOffset = _freeNodeOffset + i + 1;
        node ++;
    }
    node->value = 0;
    node->nextNodeOffset = kFinallyNodeOffset;
}
- (KJPointNode*)nodeOfOffset:(NSInteger)offset{
    return (KJPointNode*)nodeCache.mutableBytes + offset;
}
- (NSInteger)offsetOfNode:(KJPointNode*)node{
    return node - (KJPointNode*)nodeCache.mutableBytes;
}
- (KJPointNode*)nextFreeNode{
    if (_freeNodeOffset < 0) {
        [nodeCache increaseLengthBy:_increments * sizeof(KJPointNode)];
        _freeNodeOffset = _topNodeOffset + 1;
        [self initNodeWithCount:_increments];
    }
    KJPointNode *node = (KJPointNode*)nodeCache.mutableBytes + _freeNodeOffset;
    _freeNodeOffset = node->nextNodeOffset;
    return node;
}

@end
