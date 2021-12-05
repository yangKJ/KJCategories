//
//  UILabel+KJExtension2.h
//  KJEmitterView
//
//  Created by 77。 on 2021/10/28.
//  Copyright © 2021 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Label 文本显示样式
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

/// 设置文字内容显示位置，外部不需要再去设置 " textAlignment " 属性
@property (nonatomic, assign) KJLabelTextAlignmentType customTextAlignment;

#pragma mark - 长按复制功能
/// 是否可以拷贝
@property (nonatomic, assign) BOOL copyable;
/// 移除拷贝长按手势
- (void)kj_removeCopyLongPressGestureRecognizer;

#pragma mark - 下拉菜单
/// TODO:下拉菜单扩展
- (UITableView *)kj_dropdownMenuTexts:(NSArray<NSString *> *)texts
                            MaxHeight:(CGFloat)height
                           selectText:(void(^)(NSString *string))block;

@end

NS_ASSUME_NONNULL_END
