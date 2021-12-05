//
//  MorphologyViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2021/3/20.
//  https://github.com/YangKJ/KJCategories

#import "MorphologyViewController.h"

@interface MorphologyViewController ()

@end

@implementation MorphologyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topImageView.image = [UIImage imageNamed:@"Morphology"];
    _weakself;
    weakself.bottomSlider.value = 0.42;
    weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvMorphology:KJOpencvMorphologyStyleOPEN element:42];
    self.kButtonAction = ^{
        weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvMorphology:KJOpencvMorphologyStyleOPEN element:42];
    };
    self.kSliderMoveEnd = ^(CGFloat value) {
        int x = 4 * value;
        int y = 100 * weakself.bottomSlider.value;
        weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvMorphology:x element:y];
    };
    self.kSlider2MoveEnd = ^(CGFloat value) {
        int x = 4 * weakself.topSlider.value;
        int y = 100 * value;
        weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvMorphology:x element:y];
    };
}

@end
