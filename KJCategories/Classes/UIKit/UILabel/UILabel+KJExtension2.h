//
//  UILabel+KJExtension2.h
//  KJEmitterView
//
//  Created by 77。 on 2021/10/28.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, KJLabelTextAlignmentType) {
    KJLabelTextAlignmentTypeLeft = 0,
    KJLabelTextAlignmentTypeRight,
    KJLabelTextAlignmentTypeCenter,
    KJLabelTextAlignmentTypeLeftTop,
    KJLabelTextAlignmentTypeRightTop,
    KJLabelTextAlignmentTypeLeftBottom,
    KJLabelTextAlignmentTypeRightBottom,
    KJLabelTextAlignmentTypeTopCenter,
    KJLabelTextAlignmentTypeBottomCenter,
};
@interface UILabel (KJExtension2)

/// Set the display position of the text content,
/// There is no need to set the "textAlignment" property externally
@property (nonatomic, assign) KJLabelTextAlignmentType customTextAlignment;

/// Can copy
@property (nonatomic, assign) BOOL copyable;

/// Remove the copy long press gesture
- (void)kj_removeCopyLongPressGestureRecognizer;

@end

NS_ASSUME_NONNULL_END
