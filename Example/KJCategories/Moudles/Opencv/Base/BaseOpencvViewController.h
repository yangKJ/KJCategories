//
//  BaseOpencvViewController.h
//  KJEmitterView
//
//  Created by 77。 on 2021/3/20.
//  https://github.com/YangKJ/KJCategories

#import <UIKit/UIKit.h>
#import <KJCategories/KJCategories.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseOpencvViewController : UIViewController

@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *bottomImageView;
@property (nonatomic, strong) UIButton *changeButton;
@property (nonatomic, strong) UISlider *topSlider;
@property (nonatomic, strong) UISlider *bottomSlider;
@property (nonatomic, copy, readwrite) void(^kSliderMoving)(CGFloat value);
@property (nonatomic, copy, readwrite) void(^kSliderMoveEnd)(CGFloat value);
@property (nonatomic, copy, readwrite) void(^kSlider2Moving)(CGFloat value);
@property (nonatomic, copy, readwrite) void(^kSlider2MoveEnd)(CGFloat value);
@property (nonatomic, copy, readwrite) void(^kButtonAction)(void);

@end

NS_ASSUME_NONNULL_END
