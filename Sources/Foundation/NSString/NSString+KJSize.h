//
//  NSString+KJSize.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/8/10.
//  https://github.com/YangKJ/KJCategories

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KJSize)

/// Get text width
/// @param font font
/// @param height fixed height
/// @param alignment alignment
/// @param linebreakMode line type
/// @param lineSpace line spacing
- (CGFloat)kj_maxWidthWithFont:(UIFont *)font
                        Height:(CGFloat)height
                     Alignment:(NSTextAlignment)alignment
                 LinebreakMode:(NSLineBreakMode)linebreakMode
                     LineSpace:(CGFloat)lineSpace;

/// Get text height
/// @param font font
/// @param width fixed width
/// @param alignment alignment
/// @param linebreakMode line type
/// @param lineSpace line spacing
- (CGFloat)kj_maxHeightWithFont:(UIFont *)font
                          Width:(CGFloat)width
                      Alignment:(NSTextAlignment)alignment
                  LinebreakMode:(NSLineBreakMode)linebreakMode
                      LineSpace:(CGFloat)lineSpace;

/// Calculate the height of the string
/// @param font font
/// @param size size
/// @param spacing Line spacing
- (CGSize)kj_textSizeWithFont:(UIFont *)font
                    superSize:(CGSize)size
                      spacing:(CGFloat)spacing;
/// Text to picture
/// @param size size
/// @param color color
/// @param attributes parameters
- (UIImage *)kj_textBecomeImageWithSize:(CGSize)size
                        BackgroundColor:(UIColor *)color
                         TextAttributes:(NSDictionary *)attributes;

@end

NS_ASSUME_NONNULL_END
