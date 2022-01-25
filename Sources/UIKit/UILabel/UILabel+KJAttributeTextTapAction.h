//
//  UILabel+KJAttributeTextTapAction.h
//  KJEmitterView
//
//  Created by yangkejun on 2021/9/6.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^KJLabelTapBlock)(UILabel * label, NSString * string, NSRange range, NSInteger index);
@interface UILabel (KJAttributeTextTapAction)

/// Whether to open click, default yes
@property (nonatomic, assign) BOOL openTap;
/// Click the highlight color, the default is red
@property (nonatomic, strong) UIColor * tapHighlightColor;
/// Whether to expand the click range, default yes
@property (nonatomic, assign) BOOL enlargeTapArea;

/// Add a click event to the text
/// @param strings The string array that needs to be added
/// @param withBlock click event callback
- (void)kj_addAttributeTapActionWithStrings:(NSArray<NSString *> *)strings
                                  withBlock:(KJLabelTapBlock)withBlock;

/// Add a click event to the text according to the range
/// @param ranges The Range string array that needs to be added
/// @param withBlock click event callback
- (void)kj_addAttributeTapActionWithRanges:(NSArray<NSString *> *)ranges
                                 withBlock:(KJLabelTapBlock)withBlock;

/// Remove click event
- (void)kj_removeAttributeTapActions;

@end

NS_ASSUME_NONNULL_END
