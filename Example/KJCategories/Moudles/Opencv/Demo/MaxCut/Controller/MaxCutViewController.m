//
//  MaxCutViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2021/3/20.
//  https://github.com/YangKJ/KJCategories


#import "MaxCutViewController.h"

@interface MaxCutViewController ()

@end

@implementation MaxCutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topImageView.image = [UIImage imageNamed:@"MaxCut"];
    self.topImageView.backgroundColor = UIColor.blackColor;
    _weakself;
    self.kButtonAction = ^{
        weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvCutMaxRegionImage];
    };
    weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvCutMaxRegionImage];
}

@end
