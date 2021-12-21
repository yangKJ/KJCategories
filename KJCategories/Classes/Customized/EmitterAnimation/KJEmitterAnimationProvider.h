//
//  KJEmitterAnimationProvider.h
//  KJCategories
//
//  Created by 77。 on 2019/8/27.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class KJEmitterImagePixel;
@interface KJEmitterAnimationProvider : NSObject

/// The maximum number of particles displayed in each row and column
/// setting zero means that each pixel is a particle
@property (nonatomic, assign) NSInteger maxPixels;
/// The particle's birth position, default `CGPointZero`
@property (nonatomic, assign) CGPoint pixelBeginPoint;
/// Random range of pixel particles
@property (nonatomic, assign) CGFloat pixelRandomRange;
/// Change the color of the particles, the default pixel color
@property (nonatomic, strong, nullable) UIColor *pixelColor;
/// Ignore black particles, default is NO
@property (nonatomic, assign) BOOL blockIgnored;
/// Ignore white particles, default is NO
@property (nonatomic, assign) BOOL whiteIgnored;
/// Particle falling speed, default `0.5`
/// The larger the value, the faster the falling, and the shorter the animation duration
@property (nonatomic, assign) CGFloat dropSpeed;

/// Split the picture into pixel particles
- (NSArray<KJEmitterImagePixel *> *)resolutionImagePixels:(UIImage *)image;

/// Split pixel particles asynchronously
- (void)asyncResolutionPixelImage:(UIImage *)image
                        withBlock:(void(^)(NSArray<KJEmitterImagePixel *> *pixels))withBlock;

@end

@interface KJEmitterImagePixel : NSObject

@property (nonatomic, assign) CGFloat red;
@property (nonatomic, assign) CGFloat green;
@property (nonatomic, assign) CGFloat blue;
@property (nonatomic, assign) CGFloat alpha;
@property (nonatomic, assign) CGPoint point;
@property (nonatomic, assign) CGFloat randomPointRange;
@property (nonatomic, assign) CGFloat delayTime;
@property (nonatomic, assign) CGFloat delayDuration;

@end


NS_ASSUME_NONNULL_END
