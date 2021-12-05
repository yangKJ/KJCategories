//
//  KJSetDrawVC.m
//  专属橱窗
//
//  Created by 杨科军 on 2018/10/25.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "FloodImageVieController.h"
#import "UIImage+KJFloodFill.h"

@interface FloodImageVieController ()

@property (weak, nonatomic) IBOutlet UIImageView *bigImageView;
@property (weak, nonatomic) IBOutlet UIButton *redButton;
@property (weak, nonatomic) IBOutlet UIButton *delButton;
@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) UIImage *lastImage;

@end

@implementation FloodImageVieController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI{
    self.lastImage = [UIImage imageNamed:@"zuqiu"];
    self.color = [UIColor redColor];
    self.indicatorView = [[UIView alloc] init];
    self.indicatorView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.indicatorView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (CGRectEqualToRect(self.indicatorView.frame, CGRectZero)) {
        _indicatorView.frame = CGRectMake(self.redButton.frame.origin.x+2,
                                          self.redButton.frame.origin.y + self.redButton.frame.size.height+5,
                                          self.redButton.frame.size.width-4, 2);
    }
    self.bigImageView.image = self.lastImage;
}
- (IBAction)changeColor:(UIButton *)sender {
    self.color = sender.backgroundColor;
    self.indicatorView.backgroundColor = self.color;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.indicatorView.frame;
        frame.origin.x = sender.frame.origin.x+2;
        frame.origin.y = sender.frame.origin.y + sender.frame.size.height + 5;
        self.indicatorView.frame = frame;
    }];
}

- (IBAction)backAction:(UIButton *)sender {
    if (self.lastImage) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.bigImageView.image = self.lastImage;
        });
    }
}

#pragma mark - touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:_bigImageView];
    if (![_bigImageView pointInside:point withEvent:event]) {
        return;
    }
    point.x = roundf(_bigImageView.image.size.width / _bigImageView.bounds.size.width * point.x);
    point.y = roundf(_bigImageView.image.size.height / _bigImageView.bounds.size.height * point.y);
    self.lastImage = _bigImageView.image;
    self.bigImageView.image = [self.lastImage kj_FloodFillImageFromStartPoint:point
                                                                     NewColor:self.color
                                                                    Tolerance:5
                                                                 UseAntialias:YES];
}

@end
