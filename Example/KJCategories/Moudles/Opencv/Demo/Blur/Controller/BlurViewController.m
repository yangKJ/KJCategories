//
//  BlurViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2021/3/20.
//  https://github.com/YangKJ/KJCategories

#import "BlurViewController.h"

@interface BlurViewController ()

@end

@implementation BlurViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topImageView.image = [UIImage imageNamed:@"Blur.jpg"];
    _weakself;
    self.kButtonAction = ^{
        weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvBilateralFilterBlurRadio:15 sigma:100];
    };
    self.kSliderMoveEnd = ^(CGFloat value) {
        CGFloat x = 50 * value;
        CGFloat y = 150 * weakself.bottomSlider.value;
        weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvBilateralFilterBlurRadio:x sigma:y];
    };
    self.kSlider2MoveEnd = ^(CGFloat value) {
        CGFloat x = 50 * weakself.topSlider.value;
        CGFloat y = 150 * value;
        weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvBilateralFilterBlurRadio:x sigma:y];
    };
    weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvBilateralFilterBlurRadio:15 sigma:100];
}

@end
