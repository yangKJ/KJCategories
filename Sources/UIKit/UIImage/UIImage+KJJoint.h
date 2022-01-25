//
//  UIImage+KJJoint.h
//  KJEmitterView
//
//  Created by yangkejun on 2020/8/10.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/// Splicing type
typedef NS_ENUM(NSInteger, KJJointImageType) {
    KJJointImageTypeCustom = 0,/// normal tile
    KJJointImageTypePositively,/// diagonally opposite flowers
    KJJointImageTypeBackslash, /// Backslash to the flower
    KJJointImageTypeAcross, /// Horizontal to flower
    KJJointImageTypeVertical, /// Vertical pair of flowers
};
@interface UIImage (KJJoint)

/// Stitch any pictures in the vertical direction and fix the width of the main picture
/// @param jointImage stitching picture group
/// @return returns the spliced ​​picture
- (UIImage *)kj_moreJointVerticalImage:(UIImage *)jointImage,...;

/// Stitch random pictures in the horizontal direction and fix the height of the main picture
/// @param jointImage stitching picture group
/// @return returns the spliced ​​picture
- (UIImage *)kj_moreJointLevelImage:(UIImage *)jointImage,...;

/// Picture synthesis
/// @param loopTimes Repeated synthesis times
/// @param orientation Synthesis direction
/// @return Return to the mosaic
- (UIImage *)kj_imageCompoundWithLoopNums:(NSInteger)loopTimes
                              orientation:(UIImageOrientation)orientation;

/// Stitch pictures horizontally, fix the height of the main picture
/// @param jointImage stitching pictures, you can add multiple pictures ending in nil
/// @return Return to the mosaic
- (UIImage *)kj_moreCoreGraphicsJointLevelImage:(UIImage *)jointImage,...;

/// Picture stitching art
/// @param type splicing type
/// @param size stitched out picture size
/// @param maxw fix the width of the stitched picture
/// @return Return to the mosaic
- (UIImage *)kj_jointImageWithJointType:(KJJointImageType)type
                                   size:(CGSize)size
                               maxwidth:(CGFloat)maxw;

/// Asynchronous image stitching processing
/// @param block callback image after stitching
/// @param type splicing type
/// @param size stitching picture size
/// @param maxw fix the width of the stitched picture
- (void)kj_asyncJointImage:(void(^)(UIImage * image))block
                 jointType:(KJJointImageType)type
                      size:(CGSize)size
                  maxwidth:(CGFloat)maxw;

@end

NS_ASSUME_NONNULL_END
