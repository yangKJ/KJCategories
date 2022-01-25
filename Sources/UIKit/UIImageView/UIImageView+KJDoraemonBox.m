//
//  UIImageView+KJDoraemonBox.m
//  KJEmitterView
//
//  Created by 杨科军 on 2019/11/17.
//  https://github.com/yangKJ/KJEmitterView

#import "UIImageView+KJDoraemonBox.h"
#import <objc/runtime.h>
#import "_KJMacros.h"
#import "NSObject+KJGCDBox.h"
#import "UIImage+KJAccelerate.h"
#import "UIImage+KJMask.h"

@implementation UIImageViewLettersInfo
- (instancetype)init{
    if (self = [super init]) {
        self.color = [self randomColor];
        self.circle = YES;
        self.frist = YES;
        self.uppercase = YES;
        self.partition = @" ";
    }
    return self;
}
- (UIColor *)randomColor{
    srand48(arc4random());
    float red = 0.0;
    while (red < 0.1 || red > 0.84) {
        red = drand48();
    }
    float green = 0.0;
    while (green < 0.1 || green > 0.84) {
        green = drand48();
    }
    float blue = 0.0;
    while (blue < 0.1 || blue > 0.84) {
        blue = drand48();
    }
    return [UIColor colorWithRed:red green:green blue:blue alpha:1.0f];
}

@end

@implementation UIImageView (KJDoraemonBox)
/// 显示文字图片
- (void)kj_imageViewWithText:(NSString *)text LettersInfo:(void(^)(UIImageViewLettersInfo *info))block{
    UIImageViewLettersInfo *info = [[UIImageViewLettersInfo alloc]init];
    if (block) {
        block(info);
        if (!info.attributes) info.attributes = @{NSFontAttributeName:[self fontForFontName:nil],
                                                  NSForegroundColorAttributeName:[UIColor whiteColor]};
        if (info.pinyin) {
            text = [self pinYin:text];
            if (info.uppercase) text = text.uppercaseString;
        }
        if (info.frist) {
            NSRange range = [text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0,1)];
            text = [text substringWithRange:range];
        } else {
            if (info.isPartition) {
                NSMutableString *displayString = [NSMutableString stringWithString:info.partition];
                NSMutableArray *words = [[text componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] mutableCopy];
                if ([words count]) {
                    NSString *firstWord = [words firstObject];
                    if ([firstWord length]) {
                        NSRange range = [firstWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0,1)];
                        [displayString appendString:[firstWord substringWithRange:range]];
                    }
                    if ([words count] >= 2) {
                        NSString *lastWord = [words lastObject];
                        while ([lastWord length] == 0 && [words count] >= 2) {
                            [words removeLastObject];
                            lastWord = [words lastObject];
                        }
                        if ([words count] > 1) {
                            NSRange lastLetterRange = [lastWord rangeOfComposedCharacterSequencesForRange:NSMakeRange(0,1)];
                            [displayString appendString:[lastWord substringWithRange:lastLetterRange]];
                        }
                    }
                }
                if (info.uppercase) {
                    text = [displayString uppercaseString];
                }else {
                    text = displayString.mutableCopy;
                }
            }
        }
        self.image = [self imageSnapshotFromText:text Color:info.color Circle:info.circle TextAttributes:info.attributes];
    }
}
- (NSString *)pinYin:(NSString *)text{
    NSMutableString *string = [text mutableCopy];
    CFStringTransform((CFMutableStringRef)string,NULL,kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)string,NULL,kCFStringTransformStripDiacritics,NO);
    return string;
}
- (UIFont *)fontForFontName:(NSString *)fontName {
    CGFloat fontSize = CGRectGetWidth(self.bounds) * 0.42;
    if (fontName) {
        return [UIFont fontWithName:fontName size:fontSize];
    } else {
        return [UIFont systemFontOfSize:fontSize];
    }
}
- (UIImage *)imageSnapshotFromText:(NSString *)text
                             Color:(UIColor *)color
                            Circle:(BOOL)circle
                    TextAttributes:(NSDictionary *)attributes{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGSize size = self.bounds.size;
    if (self.contentMode == UIViewContentModeScaleToFill ||
        self.contentMode == UIViewContentModeScaleAspectFill ||
        self.contentMode == UIViewContentModeScaleAspectFit ||
        self.contentMode == UIViewContentModeRedraw){
        size.width  = floorf(size.width  * scale) / scale;
        size.height = floorf(size.height * scale) / scale;
    }
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (circle) {
        CGPathRef path = CGPathCreateWithEllipseInRect(self.bounds, NULL);
        CGContextAddPath(context, path);
        CGContextClip(context);
        CGPathRelease(path);
    }
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    CGSize textSize = [text sizeWithAttributes:attributes];
    CGRect bounds = self.bounds;
    [text drawInRect:CGRectMake(bounds.size.width/2 - textSize.width/2,
                                bounds.size.height/2 - textSize.height/2,
                                textSize.width,
                                textSize.height) withAttributes:attributes];
    UIImage *snapshot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return snapshot;
}

/// 浏览头像，点击全屏展示
- (void)kj_headerImageShowScreen{
    [self kj_headerImageShowScreenWithBackground:UIColor.blackColor];
}
- (void)kj_headerImageShowScreenWithBackground:(UIColor *)color{
    UIImage *image = self.image;
    CGFloat w = [UIScreen mainScreen].bounds.size.width;
    CGFloat h = [UIScreen mainScreen].bounds.size.height;
    UIWindow *window = ({
        UIWindow *window;
        if (@available(iOS 13.0, *)) {
            window = [UIApplication sharedApplication].windows.firstObject;
        } else {
            window = [UIApplication sharedApplication].keyWindow;
        }
        window;
    });
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, w, h)];
    self.kOriginRect = [self convertRect:self.bounds toView:window];
    backgroundView.backgroundColor = color;
    backgroundView.alpha = 0;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.kOriginRect];
    imageView.image = image;
    imageView.tag = 552000;
    [backgroundView addSubview:imageView];
    [window addSubview:backgroundView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(kj_hideImage:)];
    [backgroundView addGestureRecognizer:tap];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = CGRectMake(0,(h-image.size.height*w/image.size.width)/2, w, image.size.height*w/image.size.width);
        backgroundView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
- (void)kj_hideImage:(UITapGestureRecognizer*)tap{
    UIView *backgroundView = tap.view;
    UIImageView *imageView = (UIImageView*)[tap.view viewWithTag:552000];
    [UIView animateWithDuration:0.3 animations:^{
        imageView.frame = self.kOriginRect;
        backgroundView.alpha = 0;
    } completion:^(BOOL finished) {
        [backgroundView removeFromSuperview];
    }];
}
- (CGRect)kOriginRect{
    return [objc_getAssociatedObject(self, @selector(kOriginRect)) CGRectValue];
}
- (void)setKOriginRect:(CGRect)kOriginRect{
    NSValue *rect = [NSValue valueWithCGRect:kOriginRect];
    objc_setAssociatedObject(self, @selector(kOriginRect), rect, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 模糊处理
- (void)kj_blurImageViewWithBlurType:(KJImageBlurType)type image:(UIImage *)image radius:(CGFloat)radius{
    __weak __typeof(self) weakself = self;
    if (type == KJImageBlurTypeGaussian) {
        kGCD_async(^{
            CIContext *context = [CIContext contextWithOptions:nil];
            CIImage *ciimage = [CIImage imageWithCGImage:image.CGImage];
            CIFilter *clampFilter = [CIFilter filterWithName:@"CIAffineClamp" keysAndValues:kCIInputImageKey,ciimage,nil];
            CIImage *clampResult = [clampFilter valueForKey:kCIOutputImageKey];
            
            CIFilter *gaussianFilter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey,clampResult,nil];
            [gaussianFilter setValue:@(radius) forKey:kCIInputRadiusKey];
            CIImage *gaussianResult = [gaussianFilter valueForKey:kCIOutputImageKey];
            
            CGImageRef cgImage = [context createCGImage:gaussianResult fromRect:[ciimage extent]];
            UIImage *newImage = [UIImage imageWithCGImage:cgImage];
            CGImageRelease(cgImage);
            kGCD_main(^{
                weakself.image = newImage;
            });
        });
    } else if (type == KJImageBlurTypeMask) {
        self.image = [self.image kj_maskImage:image];
    } else if (type == KJImageBlurTypeBlurEffect) {
        self.image = image;
        UIBlurEffect *effect;
        if (radius<10) {
            effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        } else if (radius<20) {
            effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        } else {
            effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        }
        UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
        effectView.frame = self.bounds;
        [self addSubview:effectView];
    } else if (type == KJImageBlurTypevImage) {
        self.image = [image kj_linearBlurryImageBlur:radius];
    }
}

@end
