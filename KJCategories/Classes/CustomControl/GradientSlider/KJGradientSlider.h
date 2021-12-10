//
//  KJGradientSlider.h
//  KJEmitterView
//
//  Created by 77。 on 2019/8/24.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Gradient color slider
@interface KJGradientSlider : UISlider

/// Color array, default white
@property (nonatomic, strong) NSArray<UIColor *> *colors;
/// Location information corresponding to each color
@property (nonatomic, strong) NSArray<NSNumber *> *locations;
/// The height of the color, the default is 2.5px
@property (nonatomic, assign) CGFloat colorHeight;
/// Border width, default 0px
@property (nonatomic, assign) CGFloat borderWidth;
/// Border color, default black
@property (nonatomic, strong) UIColor *borderColor;
/// Current progress, used for external kvo
@property (nonatomic, assign, readonly) CGFloat progress;

/// Reset UI
- (void)updateUI;

/// moving
/// @param timeSpan Response time interval, very frequent calls during the control sliding process
/// @param withBlock Callback while moving
- (void)movingWithTimeSpan:(CGFloat)timeSpan withBlock:(void(^)(CGFloat value))withBlock;

/// End of move
- (void)moveEndBlock:(void(^)(CGFloat value))withBlock;

@end

NS_ASSUME_NONNULL_END
