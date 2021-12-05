//
//  UIImage+KJJoint.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  Copyright © 2020 杨科军. All rights reserved.
//  https://github.com/YangKJ/KJCategories
//  图片拼接技术

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// 拼接类型
typedef NS_ENUM(NSInteger, KJJointImageType) {
    KJJointImageTypeCustom = 0,/// 正常平铺
    KJJointImageTypePositively,/// 正斜对花
    KJJointImageTypeBackslash, /// 反斜对花
    KJJointImageTypeAcross,    /// 横对花
    KJJointImageTypeVertical,  /// 竖对花
};
@interface UIImage (KJJoint)

/// 竖直方向拼接随意张图片，固定主图的宽度
/// @param jointImage 拼接图片组
/// @return 返回拼接好的图片
- (UIImage *)kj_moreJointVerticalImage:(UIImage *)jointImage,...;

/// 水平方向拼接随意张图片，固定主图的高度
/// @param jointImage 拼接图片组
/// @return 返回拼接好的图片
- (UIImage *)kj_moreJointLevelImage:(UIImage *)jointImage,...;

/// 图片合成
/// @param loopTimes 重复合成次数
/// @param orientation 合成方向
/// @return 返回拼接图
- (UIImage *)kj_imageCompoundWithLoopNums:(NSInteger)loopTimes
                              orientation:(UIImageOrientation)orientation;
/// 水平拼接图片，固定主图高度
/// @param jointImage 拼接图片，可追加多张以nil结尾
/// @return 返回拼接图
- (UIImage *)kj_moreCoreGraphicsJointLevelImage:(UIImage *)jointImage,...;

/// 图片拼接艺术
/// @param type 拼接类型
/// @param size 拼接出来图片尺寸
/// @param maxw 固定拼接图片的宽度
/// @return 返回拼接图
- (UIImage *)kj_jointImageWithJointType:(KJJointImageType)type
                                   size:(CGSize)size
                               maxwidth:(CGFloat)maxw;
/// 异步图片拼接处理
/// @param block 回调拼接之后的图片
/// @param type 拼接类型
/// @param size 拼接图片尺寸
/// @param maxw 固定拼接图片的宽度
- (void)kj_asyncJointImage:(void(^)(UIImage * image))block
                 jointType:(KJJointImageType)type
                      size:(CGSize)size
                  maxwidth:(CGFloat)maxw;

@end

NS_ASSUME_NONNULL_END
