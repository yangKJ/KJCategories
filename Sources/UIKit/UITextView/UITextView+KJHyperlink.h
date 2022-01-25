//
//  UITextView+KJHyperlink.h
//  KJEmitterView
//
//  Created by 77。 on 2019/12/4.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Define URL structure
typedef struct kURLCustom {
    UIColor *color;/// text color
    UIFont *font;/// text size
} URLCustom;
typedef void (^KJTextViewURLHyperlinkBlock)(NSString * URLString);
@interface UITextView (KJHyperlink)

// Remarks:
// 1. The delegate UITextViewDelegate is implemented, and it will be invalid if it is reused by the outside world
// 2. You need to set the text content before calling this method self.textView.text = @"xxxx";
// 3. Turn off the editing function of text
// 4. The default URL address color is blue

/// Identify the URL address of the clickable hyperlink
/// @param custom URL structure
/// @param withBlock Recognition success callback
- (NSArray *)kj_clickTextViewURLCustom:(URLCustom)custom withBlock:(KJTextViewURLHyperlinkBlock)withBlock;

@end

NS_ASSUME_NONNULL_END
