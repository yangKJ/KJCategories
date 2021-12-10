//
//  NSString+KJSize.m
//  KJEmitterView
//
//  Created by yangkejun on 2021/8/10.
//  https://github.com/YangKJ/KJCategories

#import "NSString+KJSize.h"

@implementation NSString (KJSize)

/// 获取文本宽度
- (CGFloat)kj_maxWidthWithFont:(UIFont *)font
                        Height:(CGFloat)height
                     Alignment:(NSTextAlignment)alignment
                 LinebreakMode:(NSLineBreakMode)linebreakMode
                     LineSpace:(CGFloat)lineSpace{
    return [self kj_sizeWithFont:font
                            Size:CGSizeMake(CGFLOAT_MAX, height)
                       Alignment:alignment
                   LinebreakMode:linebreakMode
                       LineSpace:lineSpace].width;
}
/// 获取文本高度
- (CGFloat)kj_maxHeightWithFont:(UIFont *)font
                          Width:(CGFloat)width
                      Alignment:(NSTextAlignment)alignment
                  LinebreakMode:(NSLineBreakMode)linebreakMode
                      LineSpace:(CGFloat)lineSpace{
    return [self kj_sizeWithFont:font
                            Size:CGSizeMake(width, CGFLOAT_MAX)
                       Alignment:alignment
                   LinebreakMode:linebreakMode
                       LineSpace:lineSpace].height;
}
- (CGSize)kj_sizeWithFont:(UIFont *)font
                     Size:(CGSize)size
                Alignment:(NSTextAlignment)alignment
            LinebreakMode:(NSLineBreakMode)linebreakMode
                LineSpace:(CGFloat)lineSpace{
    if (self.length == 0) return CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = linebreakMode;
    paragraphStyle.alignment = alignment;
    if (lineSpace > 0) paragraphStyle.lineSpacing = lineSpace;
    NSDictionary *attributes = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:paragraphStyle};
    CGSize newSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                                     attributes:attributes context:NULL].size;
    return CGSizeMake(ceil(newSize.width), ceil(newSize.height));
}
/// 计算字符串高度尺寸，spacing为行间距
- (CGSize)kj_textSizeWithFont:(UIFont *)font superSize:(CGSize)size spacing:(CGFloat)spacing{
    if (self == nil) return CGSizeMake(0, 0);
    NSDictionary *dict = @{NSFontAttributeName : font};
    if (spacing > 0) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:spacing];
        dict = @{NSFontAttributeName: font, NSParagraphStyleAttributeName:paragraphStyle};
    }
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_7_0)
    size = [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:dict
                              context:nil].size;
#else
    size = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByCharWrapping];
#endif
    return size;
}

/// 文字转图片
- (UIImage *)kj_textBecomeImageWithSize:(CGSize)size BackgroundColor:(UIColor *)color TextAttributes:(NSDictionary *)attributes{
    CGRect bounds = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, bounds);
    CGSize textSize = [self sizeWithAttributes:attributes];
    [self drawInRect:CGRectMake(bounds.size.width/2-textSize.width/2,
                                bounds.size.height/2-textSize.height/2,
                                textSize.width,
                                textSize.height) withAttributes:attributes];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
