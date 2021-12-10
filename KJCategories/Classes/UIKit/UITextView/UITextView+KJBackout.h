//
//  UITextView+KJBackout.h
//  KJEmitterView
//
//  Created by 77。 on 2019/11/10.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (KJBackout)

/// Whether to enable the cancel function
@property (nonatomic, assign) BOOL openBackout;

/// Cancel input, equivalent to command + z
- (void)kj_textViewBackout;

@end

NS_ASSUME_NONNULL_END
