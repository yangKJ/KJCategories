//
//  KJGradientSlider.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/8/24.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import "KJGradientSlider.h"

@interface KJGradientSlider()

@property (nonatomic,strong) UIImageView *backImageView;
@property (nonatomic,assign) float timeSpan;
@property (nonatomic,assign) NSTimeInterval lastTime;
@property (nonatomic,assign) CGFloat progress;
@property (nonatomic,readwrite,copy) void(^kValueChangeBlock)(CGFloat progress);
@property (nonatomic,readwrite,copy) void(^kMoveEndBlock)(CGFloat progress);


@end

@implementation KJGradientSlider

- (void)updateUI{
    [self drawNewImage];
}
/// 移动中
/// @param timeSpan 响应时间间隔
/// @param withBlock 移动中回调
- (void)movingWithTimeSpan:(CGFloat)timeSpan withBlock:(void(^)(CGFloat value))withBlock{
    self.timeSpan = timeSpan;
    self.kValueChangeBlock = withBlock;
}
/// 移动结束
- (void)moveEndBlock:(void(^)(CGFloat))withBlock{
    self.kMoveEndBlock = withBlock;
}

#pragma mark - system method

- (void)awakeFromNib{
    [super awakeFromNib];
    [self setup];
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if (CGRectEqualToRect(self.backImageView.frame, CGRectZero)) {
        CGRect imgViewFrame = self.backImageView.frame;
        imgViewFrame.size.width = self.frame.size.width;
        imgViewFrame.size.height = self.colorHeight;
        imgViewFrame.origin.y = (self.frame.size.height - self.colorHeight) * 0.5;
        self.backImageView.frame = imgViewFrame;
        [self drawNewImage];
    }
}

#pragma mark - private method

- (void)drawNewImage{
    self.backImageView.image = [KJGradientSlider colorImageWithColors:_colors
                                                            locations:_locations
                                                                 size:CGSizeMake(self.frame.size.width, _colorHeight)
                                                          borderWidth:_borderWidth
                                                          borderColor:_borderColor];
    self.progress = self.value;
}
- (void)setup{
    self.colors = @[UIColor.whiteColor];
    self.locations = @[@(1.)];
    self.colorHeight = 2.5;
    self.borderWidth = 0.0;
    self.borderColor = UIColor.blackColor;
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.backImageView];
    [self sendSubviewToBack:self.backImageView];
    self.tintColor = [UIColor clearColor];
    self.maximumTrackTintColor = self.minimumTrackTintColor = [UIColor clearColor];
    [self addTarget:self action:@selector(valueChange) forControlEvents:UIControlEventValueChanged];
    [self addTarget:self action:@selector(endMove) forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:self action:@selector(endMove) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(touchCancel) forControlEvents:UIControlEventTouchCancel];
}
- (void)valueChange{
    self.progress = self.value;
    if (self.kValueChangeBlock) {
        if (_timeSpan == 0) {
            self.kValueChangeBlock(self.value);
        } else if (CFAbsoluteTimeGetCurrent() - self.lastTime > _timeSpan) {
            _lastTime = CFAbsoluteTimeGetCurrent();
            self.kValueChangeBlock(self.value);
        }
    }
}
- (void)endMove{
    self.progress = self.value;
    if (self.kMoveEndBlock) {
        self.kMoveEndBlock(self.value);
        return;
    }
    if (self.kValueChangeBlock) self.kValueChangeBlock(self.value);
}
- (void)touchCancel{
    self.progress = self.value;
    if (self.kMoveEndBlock) self.kMoveEndBlock(self.value);
}

+ (UIImage *)colorImageWithColors:(NSArray<UIColor *> *)colors
                        locations:(NSArray<NSNumber*> *)locations
                             size:(CGSize)size
                      borderWidth:(CGFloat)borderWidth
                      borderColor:(UIColor *)borderColor{
    NSAssert(colors || locations, @"colors and locations must has value");
    NSAssert(colors.count == locations.count, @"Please make sure colors and locations count is equal");
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (borderWidth > 0 && borderColor) {
        CGRect rect = CGRectMake(size.width * 0.01, 0, size.width * 0.98, size.height);
        UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:size.height*0.5];
        [borderColor setFill];
        [path fill];
    }
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(size.width * 0.01 + borderWidth,
                                                                            borderWidth,
                                                                            size.width * 0.98 - borderWidth * 2,
                                                                            size.height - borderWidth * 2)
                                                    cornerRadius:size.height * 0.5];
    [self kj_drawLinearGradient:context path:path.CGPath colors:colors locations:locations];
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
+ (void)kj_drawLinearGradient:(CGContextRef)context
                         path:(CGPathRef)path
                       colors:(NSArray<UIColor *> *)colors
                    locations:(NSArray<NSNumber*> *)locations{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSMutableArray *colorefs = [@[] mutableCopy];
    [colors enumerateObjectsUsingBlock:^(UIColor *obj, NSUInteger idx, BOOL *stop) {
        [colorefs addObject:(__bridge id)obj.CGColor];
    }];
    CGFloat locs[locations.count];
    for (int i = 0; i < locations.count; i++) {
        locs[i] = locations[i].floatValue;
    }
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorefs, locs);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint startPoint = CGPointMake(CGRectGetMinX(pathRect), CGRectGetMidY(pathRect));
    CGPoint endPoint = CGPointMake(CGRectGetMaxX(pathRect), CGRectGetMidY(pathRect));
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
