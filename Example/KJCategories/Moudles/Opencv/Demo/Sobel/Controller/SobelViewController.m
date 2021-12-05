//
//  SobelViewController.m
//  KJEmitterView
//
//  Created by 杨科军 on 2021/3/21.
//  https://github.com/YangKJ/KJCategories

#import "SobelViewController.h"

@interface SobelViewController ()

@end

@implementation SobelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.topImageView.image = [UIImage imageNamed:@"Sobel.jpeg"];
    _weakself;
    self.kButtonAction = ^{
        weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvFeatureExtractionFromSobel];
    };
    weakself.bottomImageView.image = [weakself.topImageView.image kj_opencvFeatureExtractionFromSobel];
}

@end
